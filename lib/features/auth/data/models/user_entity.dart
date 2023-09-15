import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';

class UserEntity extends UserModel{
  const UserEntity({
    required super.uid,
    required super.email,
    required super.fullName,
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
    };
  }

  UserEntity copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    String? fullName,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      fullName: fullName ?? this.fullName,
    );
  }
}
