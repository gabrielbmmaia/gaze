import 'package:equatable/equatable.dart';
import 'package:gaze/features/series/data/models/series_entity.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    this.favoriteList = const [],
    this.bio,
    this.profilePic,
  });

  const UserModel.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
          profilePic: '',
          bio: '',
          favoriteList: const [],
        );

  final String uid;
  final String email;
  final String? profilePic;
  final String fullName;
  final String? bio;
  final List<SeriesEntity> favoriteList;

  @override
  String toString() {
    return 'User {uid: $uid, email: $email, fullName: $fullName, '
        'profilePic: $profilePic}';
  }

  UserModel addFavoriteItem(SeriesEntity item) {
    final updatedFavorites = List<SeriesEntity>.from(favoriteList);
    updatedFavorites.add(item);
    return copyWith(favoriteList: updatedFavorites);
  }

  UserModel removeFavoriteItem(SeriesEntity item) {
    final updatedFavorites = List<SeriesEntity>.from(favoriteList);
    updatedFavorites.remove(item);
    return copyWith(favoriteList: updatedFavorites);
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? profilePic,
    String? bio,
    List<SeriesEntity>? favoriteList,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      favoriteList: favoriteList ?? this.favoriteList,
    );
  }

  @override
  List<dynamic> get props => [uid, email, profilePic, fullName, favoriteList];
}
