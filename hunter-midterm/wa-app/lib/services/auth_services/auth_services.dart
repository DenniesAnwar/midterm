import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:wa_app/custom_widgets/show_snackbar.dart';
import 'package:wa_app/providers/user_provider.dart';
import 'package:wa_app/utills/constants.dart';

class FirebaseAuthServices {
  static final _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<User> afterGoogleLogin(GoogleSignInAccount gSA) async {
    GoogleSignInAccount googleSignInAccount = gSA;
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    return user!;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        return user;
      }
    } catch (except) {
      // ignore: avoid_print
      print(except);
    }
    return null;
  }

  static Future<User?> signUpWithFacebook(BuildContext context) async {
    late User? user;

    try {
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });

      user = (await _auth.signInWithPopup(facebookProvider)).user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        ShowSnackBar.showSnackBar(
            context: context,
            title:
                'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.');
        Navigator.of(context).maybePop();
      } else {
        ShowSnackBar.showSnackBar(
            context: context, title: 'Something went wrong please try again');
        Navigator.of(context).maybePop();
      }
    }
    return user;
  }

  static Future<User?> signUpWithEmailAndPassword(
      {required BuildContext context,
      required Map<String, dynamic> data}) async {
    try {
      UserProvider _uProvider =
          Provider.of<UserProvider>(context, listen: false);
      //Create a new email and password in firebase
      UserCredential _userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data['email'], password: data['password']);
      if (_userCredentials.user != null) {
        //await _userCredentials.user!.updateDisplayName(fullName);
        _uProvider.user = FirebaseAuth.instance.currentUser;

        data.remove('email');
        data.remove('password');
        await _uProvider.updateCurrentUser(data);
      }
      return _uProvider.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ShowSnackBar.showSnackBar(
            context: context, title: 'The password provided is too weak.');
        Navigator.of(context).maybePop();
      } else if (e.code == 'email-already-in-use') {
        ShowSnackBar.showSnackBar(
            context: context, title: 'Email already exists.');
        Navigator.of(context).maybePop();
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }

  static Future<Map<String, dynamic>> signInWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    User? user;
    Map<String, dynamic> data = {
      'isSuccess': false,
      'isNetworkError': false,
      'message': 'Username or password is wrong'
    };
    try {
      //Create a new email and password in firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      user = userCredential.user;

      data['isSuccess'] = true;
      data['user'] = user;
    } on FirebaseAuthException catch (e) {
      user = null;
      if (e.code == 'user-not-found') {
        data['message'] = 'Invalid email';
      } else if (e.code == 'wrong-password') {
        data['message'] = 'Password is wrong';
      } else if (e.code == 'auth/network-request-failed') {
        data['message'] = 'Network error';
        data['isNetworkError'] = 'Network error';
      }
    }
    return data;
  }

  static Future<String> updateUserPassword(
      {required BuildContext context,
      required String password,
      required String newPassword}) async {
    String message = "";

    final AuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!, password: password);
    await _auth.currentUser!
        .reauthenticateWithCredential(credential)
        .then((value) async {
      await _auth.currentUser!.updatePassword(newPassword).then((value) async {
        await Provider.of<UserProvider>(context, listen: false)
            .passwordChanged();
        message = passwordUpdateSuccessMessage;
      });
    }).catchError((error) async {
      try {
        FirebaseAuthException errorCode = error;
        message = errorCode.code == 'wrong-password'
            ? 'Current password is wrong'
            : 'Password should be at-least 6 characters';
      } catch (ex) {
        message = "Something went wrong please try again";
      }
    });
    return message;
  }

  static Future<bool> forgotPassword(
      {required BuildContext context, required String email}) async {
    bool success = true;
    try {
      await _auth.sendPasswordResetEmail(
          email: email,
          actionCodeSettings: ActionCodeSettings(
            handleCodeInApp: true,
            url: "https://woaccelerator.com",
            // "https://firebase.google.com/docs/auth/admin/manage-users#update_a_user",
          ));
    } on Exception catch (_, __) {
      success = false;
    }

    Navigator.of(context).maybePop();
    return success;
  }

  static Future<String> resetEmail(String newEmail) async {
    var message = "";
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    try {
      await firebaseUser?.updateEmail(newEmail);
      message = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        message = 'Invalid email';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email already exists';
      } else if (e.code == 'requires-recent-login') {
        message = e.message ?? "Require recent login";
      }
    }
    return message;
  }
}
