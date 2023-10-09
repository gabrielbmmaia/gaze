import 'package:firebase_auth/firebase_auth.dart';

/// Todas possíveis ações de update de um [User]
enum UpdateUserAction {
  fullName,
  email,
  profilePic,
  bio
}
