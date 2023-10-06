import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/series/data/models/series_entity.dart';

class UserEntity extends UserModel {
  const UserEntity({
    required super.uid,
    required super.email,
    required super.fullName,
    super.favoriteList,
    super.profilePic,
    super.bio,
  });

  UserEntity.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
          fullName: map['fullName'] as String,
          favoriteList: (map['favoriteList'] as List<dynamic>)
              .map((series) => SeriesEntity.fromJson(series as DataMap))
              .toList(),
        );

  const UserEntity.empty()
      : this(
          email: '',
          fullName: '',
          uid: '',
        );

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'profilePic': profilePic,
      'bio': bio,
      'fullName': fullName,
      'favoriteList': favoriteList,
    };
  }
}
