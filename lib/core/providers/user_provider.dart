import 'package:flutter/cupertino.dart';
import 'package:gaze/features/auth/data/models/user_entity.dart';

class UserProvider extends ChangeNotifier {
  UserEntity? _user;

  UserEntity? get user => _user;

  void initUser(UserEntity? user){
    if (_user != user) _user = user;
  }

  set user (UserEntity? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
