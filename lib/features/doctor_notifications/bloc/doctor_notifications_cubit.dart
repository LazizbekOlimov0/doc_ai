import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'doctor_notifications_model.dart';
import 'doctor_notifications_state.dart';

class DoctorNotificationsCubit extends Cubit<DoctorNotificationsState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<QuerySnapshot>? _sub;

  String get _uid => _auth.currentUser!.uid;

  DoctorNotificationsCubit() : super(const DoctorNotificationsState());

  void load() {
    emit(state.copyWith(status: DoctorNotifStatus.loading));
    _sub?.cancel();
    _sub = _firestore
        .collection('users')
        .doc(_uid)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen(
      (snap) {
        emit(state.copyWith(
          status: DoctorNotifStatus.loaded,
          notifications: snap.docs.map((d) => DoctorNotification.fromFirestore(d)).toList(),
        ));
      },
      onError: (e) {
        emit(state.copyWith(status: DoctorNotifStatus.error, error: e.toString()));
      },
    );
  }

  Future<void> markRead(String notifId) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('notifications')
        .doc(notifId)
        .update({'isRead': true});
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
