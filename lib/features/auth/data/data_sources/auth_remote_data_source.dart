import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/core/errors/exceptions.dart';
import 'package:gaze/core/utils/constants.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/data/models/user_entity.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/series/data/models/series_entity.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

  Future<void> addFavoriteItem({required SeriesEntity item});

  Future<void> removeFavoriteItem({required SeriesEntity item});

  Future<bool> isFavoriteItem({required SeriesEntity item});

  Future<List<SeriesEntity>> getFavoriteSeries();

  Stream<List<SeriesEntity>> getFavoriteListStream();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw const ServerException(
          message: 'Please try again later',
          statusCode: 'Unknown Error',
        );
      }
      var userData = await _getUserData(user.uid);

      if (userData.exists) {
        return UserEntity.fromMap(userData.data()!);
      }

      // upload the user
      await _setUserData(user, email);

      userData = await _getUserData(user.uid);
      return UserEntity.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCred.user?.updateDisplayName(fullName);
      await userCred.user?.updatePhotoURL(kDefaultAvatar);
      await _setUserData(_authClient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.fullName:
          await _authClient.currentUser?.updateDisplayName(userData as String);
          await _updateUserData({'fullName': userData});

        case UpdateUserAction.email:
          await _authClient.currentUser?.updateEmail(userData as String);
          await _updateUserData({'email': userData});

        case UpdateUserAction.bio:
          await _updateUserData({'bio': userData as String});

        case UpdateUserAction.profilePic:
          final ref = _dbClient
              .ref()
              .child('profile_pics/${_authClient.currentUser?.uid}');
          await ref.putFile(userData as File);
          final url = await ref.getDownloadURL();
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profilePic': url});
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> addFavoriteItem({required SeriesEntity item}) async {
    try {
      await _cloudStoreClient
          .collection('users')
          .doc(_authClient.currentUser?.uid)
          .update({
        'favoriteList': FieldValue.arrayUnion([item.toMap()]),
      });
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '');
    }
  }

  @override
  Future<void> removeFavoriteItem({required SeriesEntity item}) async {
    try {
      await _cloudStoreClient
          .collection('users')
          .doc(_authClient.currentUser?.uid)
          .update({
        'favoriteList': FieldValue.arrayRemove([item.toMap()]),
      });
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '');
    }
  }

  @override
  Future<bool> isFavoriteItem({required SeriesEntity item}) async {
    try {
      final userDoc = await _cloudStoreClient
          .collection('users')
          .doc(_authClient.currentUser?.uid)
          .get();
      final favoriteList = userDoc.data()?['favoriteList'] as List<dynamic>;
      final favoriteSeries = (favoriteList as List<dynamic>)
          .map((item) => SeriesEntity.fromJson(item as DataMap))
          .toList();
      return favoriteSeries.contains(item);
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<SeriesEntity>> getFavoriteSeries() async {
    try {
      final userDoc = await _cloudStoreClient
          .collection('users')
          .doc(_authClient.currentUser?.uid)
          .get();
      final favoriteList = userDoc.data()?['favoriteList'] as List<dynamic>;
      return (favoriteList as List<dynamic>)
          .map((item) => SeriesEntity.fromJson(item as DataMap))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _cloudStoreClient.collection('users').doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _cloudStoreClient.collection('users').doc(user.uid).set(
          UserEntity(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            fullName: user.displayName ?? '',
            profilePic: user.photoURL ?? '',
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap map) async {
    await _cloudStoreClient
        .collection('users')
        .doc(_authClient.currentUser?.uid)
        .update(map);
  }

  @override
  Stream<List<SeriesEntity>> getFavoriteListStream() {
    final userDocumentRef =
        _cloudStoreClient.collection('users').doc(_authClient.currentUser?.uid);

    return userDocumentRef.snapshots().map((documentSnapshot) {
      var favoriteList = <SeriesEntity>[];

      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        final data = documentSnapshot.data()!;
        if (data.containsKey('favoriteList')) {
          final favoriteListData = data['favoriteList'] as List<dynamic>;
          favoriteList = favoriteListData
              .map(
                (item) => SeriesEntity.fromJson(item as Map<String, dynamic>),
              )
              .toList();
        }
      }
      return favoriteList;
    });
  }
}
