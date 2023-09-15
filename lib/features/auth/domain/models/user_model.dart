import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    this.profilePic,
  });

  const UserModel.empty()
      : this(
          uid: '',
          email: '',
          fullName: '',
          profilePic: '',
        );

  final String uid;
  final String email;
  final String? profilePic;
  final String fullName;

  @override
  String toString() {
    return 'User {uid: $uid, email: $email, fullName: $fullName, '
        'profilePic: $profilePic}';
  }

  @override
  List<String?> get props => [uid, email, profilePic, fullName];
}
