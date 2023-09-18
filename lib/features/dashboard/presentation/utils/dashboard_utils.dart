import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaze/core/services/injection_container.dart';
import 'package:gaze/features/auth/data/models/user_entity.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<UserEntity> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => UserEntity.fromMap(event.data()!));
}
