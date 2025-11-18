import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(
      String uid, String first, String last, String role) async {
    await _db.collection('users').doc(uid).set({
      'first_name': first,
      'last_name': last,
      'role': role,
      'created_at': DateTime.now(),
    });
  }

  Stream<QuerySnapshot> getMessages(String board) {
    return _db
        .collection('boards')
        .doc(board)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  Future<void> sendMessage(String board, String name, String message) async {
    await _db.collection('boards').doc(board).collection('messages').add({
      'name': name,
      'message': message,
      'timestamp': DateTime.now(),
    });
  }
}
