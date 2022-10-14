// ignore: implementation_imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wa_app/services/auth_services/auth_services.dart';
import 'package:wa_app/services/functions/helpers.dart';
import 'package:wa_app/ui/shared/user_registration/components/widgets.dart';
import 'package:wa_app/utills/colors.dart';
import 'package:wa_app/utills/styles.dart';

class LoadAuthButtons extends StatefulWidget {
  const LoadAuthButtons({Key? key, required this.isRegistering})
      : super(key: key);
  final bool isRegistering;
  @override
  State<LoadAuthButtons> createState() => _LoadAuthButtonsState();
}

class _LoadAuthButtonsState extends State<LoadAuthButtons> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        _loadAuthButton("assets/icons/ic_google.png", "Sign in with Google  ",
            _signInWithGoogle()),
        const SizedBox(height: 20),
        _loadAuthButton("assets/icons/ic_facebook.png", "Sign in with Facebook",
            _signInWithFacebook()),
        const SizedBox(height: 20),
        // _loadAuthButton("assets/icons/ic_apple.png", "Sign in with Apple     ",
        //     _signInWithApple()),
      ],
    );
  }

  _signInWithGoogle() => () async {
        User? user = await FirebaseAuthServices().signInWithGoogle();
        if (user != null) {
          Helpers.showAppDialog(context: context, widget: loadingWidget());
          await Helpers.redirectUser(
              isRegistering: widget.isRegistering,
              user: user,
              context: context);
        }
      };

  _signInWithFacebook() => () async {
        User? user = await FirebaseAuthServices.signUpWithFacebook(context);
        if (user != null) {
          Helpers.showAppDialog(context: context, widget: loadingWidget());
          await Helpers.redirectUser(
              isRegistering: widget.isRegistering,
              user: user,
              context: context);
        }
      };
  //_signInWithApple() => () async {};

  _loadAuthButton(String imageUrl, String title, GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 520,
        height: 65,
        decoration: BoxDecoration(
            border: Border.all(color: kBorderColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imageUrl),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: kMediumTextStyle.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
