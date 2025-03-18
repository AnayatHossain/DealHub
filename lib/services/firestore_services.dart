import '../screens/authentication/firebase_const.dart';

class FirestorServices {
  static getUser(uid){
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }
}