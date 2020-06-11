import 'UserSingleton.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static void updateAdminCollection(firebaseUser) async {
    if (UserSingleton().fireUser != null) {
      final QuerySnapshot querySnapshot = await Firestore.instance
          .collection("Admins")
          .where('uid', isEqualTo: UserSingleton().fireUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = querySnapshot.documents;
      if (documents.isEmpty) {
        Firestore.instance
            .collection("Admins")
            .document(UserSingleton().fireUser.uid)
            .setData({
          'name': UserSingleton().fireUser.displayName,
          'email': UserSingleton().fireUser.email,
          'profileImage': UserSingleton().fireUser.photoUrl,
          'token': await _firebaseMessaging.getToken(),
          'uid': UserSingleton().fireUser.uid,
        });
      }
    }
  }

  static Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final FirebaseUser firebaseUser =
          (await _auth.signInWithCredential(authCredential)).user;
      var currentUser = await _auth.currentUser();
      UserSingleton().fireUser = firebaseUser;
      Auth.updateAdminCollection(firebaseUser);
      if (currentUser != null)
        return true;
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> logoutUser() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
