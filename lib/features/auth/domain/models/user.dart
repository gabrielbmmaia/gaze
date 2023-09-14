import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.uid,
    required this.email,
    required this.fullName,
    this.profilePic,
  });

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
