import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  FireStoreService._();

  static FireStoreService get instance {
    return FireStoreService._();
  }

  static final FirebaseFirestore db = FirebaseFirestore.instance;
}