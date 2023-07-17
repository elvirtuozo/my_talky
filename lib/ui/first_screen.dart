import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:size_config/size_config.dart';
import 'package:talky/ui/third_screen.dart';
import 'package:talky/ui/second_screen.dart';
import 'package:size_config/size_config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:talky/generated/assets.dart';

class MyFirstScreen extends StatefulWidget {
  const MyFirstScreen({Key? key}) : super(key: key);

  @override
  State<MyFirstScreen> createState() => _MyFirstScreenState();
}

class _MyFirstScreenState extends State<MyFirstScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            content: Text(
              'Do you want to exit TALKY.',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //<-- SEE HERE
                child: Text(
                  'No',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                // <-- SEE HERE
                child: Text(
                  'Yes',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Widget myBody() {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 2.h),
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
                  SizedBox(child: Image(image: const AssetImage("assets/talky2.png"),height: 270.h,)),

                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "help us \nimprove ",
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: <TextSpan>[
                            TextSpan(
                              text: "Arabic \n",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextSpan(
                              text: 'Speech \nRecognition.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ])),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(250, 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      side: const BorderSide(width: 2.0, color: Colors.black),
                    ),
                    onPressed: () async {
                      if (!kIsWeb) {
                        var status = await Permission.microphone.request();
                        setState(() {});
                        if (status != PermissionStatus.granted) {
                          print("NO PERMISSION");
                          // throw RecordingPermissionException('Microphone permission not granted');
                        }
                      }
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //     builder: (context) =>
                      // const MySecondScreen()));
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('Allow', true);
                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User? user) {
                        if (user == null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MySecondScreen()),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    // SimpleRecorder()),
                                    const MyThirdScreen()),
                          );
                        }
                      });
                    },
                    child: Text(
                      "Let's Go ",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),
            )),
      );
    }

    return myBody();
    //   FutureBuilder(
    //   // Initialize FlutterFire
    //   future: Firebase.initializeApp(),
    //   builder: (context, snapshot) {
    //     // Check for errors
    //     if (snapshot.hasError) {
    //       return Scaffold(
    //         body: Center(
    //             child: Column(
    //           children: [
    //             const Text("Please make sure you have access to the internet!"),
    //             ElevatedButton(
    //               onPressed: () {
    //                 setState(() {});
    //               },
    //               child: const Text("Retry"),
    //             ),
    //           ],
    //         )),
    //       );
    //     }
    //
    //     // Once complete, show your application
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return myBody();
    //     }
    //
    //     // Otherwise, show something whilst waiting for initialization to complete
    //     return const Scaffold(
    //       body: Center(child: Text("LOADING!")),
    //     );
    //   },
    // );
  }
}
