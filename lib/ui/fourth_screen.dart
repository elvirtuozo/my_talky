import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:size_config/size_config.dart';
import 'package:talky/ui/first_screen.dart';
import 'package:talky/ui/second_screen.dart';

class MyFourthScreen extends StatelessWidget {
  const MyFourthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyFirstScreen()),
        );
        return false;
        // return Future.value(_allow); // if true allow back else block it
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyFirstScreen()),
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 55.s,
                  color: Colors.black,
                )),
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 100.h,
            actions: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10.h, 15.w, 0),
                child: SizedBox(child: Image(image: const AssetImage("assets/talky2.png"),height: 5.h,)),

                // Center(
                //   child: RichText(
                //       textAlign: TextAlign.center,
                //       text: TextSpan(
                //           text: "TAL\n",
                //           style: Theme.of(context).textTheme.displaySmall,
                //           children: <TextSpan>[
                //             TextSpan(
                //               text: " ",
                //               style: Theme.of(context).textTheme.labelSmall,
                //             ),
                //             TextSpan(
                //               text: 'KY.',
                //               style: Theme.of(context).textTheme.displaySmall,
                //             )
                //           ])),
                // ),
              )
            ]),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("THANK YOU FOR HELPING US",
                  style: GoogleFonts.leagueSpartan(
                      textStyle: const TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(220.w, 100.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0.s)),
                  side: BorderSide(width: 3.w, color: Colors.black),
                ),
                child: Row(
                  children: [
                    Icon(Icons.refresh,color: Colors.red,size: 50.h),

                    Text(" Reset",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),

                  ],
                ),

                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MySecondScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
