import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:loading_indicator/loading_indicator.dart';


import 'first_screen.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  @override
  void initState() {
    super.initState();
    initializeUser();
    navigateUser();
  }

  Future initializeUser() async {
    await Firebase.initializeApp();
    final User? firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser?.reload();
    _user = (_auth.currentUser)!;
    // get User authentication status here
  }

  navigateUser() async {
    // checking whether user already loggedIn or not

      // &&  FirebaseAuth.instance.currentUser.reload() != null
      Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    MyFirstScreen()),
                (Route<dynamic> route) => false),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 2.h),
              Text("Welcome to",style: Theme.of(context).textTheme.labelMedium,),
              // RichText(
              //     textAlign: TextAlign.center,
              //     text: TextSpan(
              //         text: "TAL\n",
              //         style: Theme.of(context).textTheme.displayLarge,
              //         children: <TextSpan>[
              //           TextSpan(
              //             text: " ",
              //             style: Theme.of(context).textTheme.bodyMedium,
              //           ),
              //           TextSpan(
              //             text: 'KY.',
              //             style: Theme.of(context).textTheme.displayLarge,
              //           )
              //         ])),

              SizedBox(child: Image(image: const AssetImage("assets/talky2.png"),height: 250.h,)),
              Text("Donate your\nvoice for a\nbetter\nFuture. ",
                      style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 7.hp),




            ],
          ),
        ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: SizedBox(
      // height: 50.h,
      width: 60.w,
      child: LoadingIndicator(
        indicatorType: Indicator.ballClipRotate,
        colors: const [Colors.red],
        strokeWidth: 1.5.wp,
        pathBackgroundColor: Colors.black,
      ),
    ),);
  }
}