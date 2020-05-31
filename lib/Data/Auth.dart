import 'UserSingleton.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //method to create a new user
  static void updateUserCollection() async {
    if (UserSingleton().fireUser != null) {
      final QuerySnapshot querySnapshot = await Firestore.instance
          .collection("Users")
          .where('id', isEqualTo: UserSingleton().user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = querySnapshot.documents;
      if (documents.isEmpty) {
        Firestore.instance
            .collection("Users")
            .document(UserSingleton().user.uid)
            .setData(UserSingleton().user.toJson());
      }
    }
  }

  static void setUserData(FirebaseUser fireUser) async {
    UserSingleton().user.name = fireUser.displayName;
    UserSingleton().user.email = fireUser.email;
    UserSingleton().user.uid = fireUser.uid;
    UserSingleton().user.profileImage = fireUser.photoUrl;
    UserSingleton().user.token = await _firebaseMessaging.getToken();
    UserSingleton().user.isAdmin = false;
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
      setUserData(firebaseUser);
      UserSingleton().fireUser = firebaseUser;
      print(UserSingleton().fireUser.displayName);
      Auth.updateUserCollection();
      if (currentUser != null) return true;
      return false;
    } catch (e) {
      print(e);
    }
  }

  static Future<void> logoutUser() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
