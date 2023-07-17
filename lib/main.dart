import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:flutter/services.dart';
import 'package:talky/ui/splash_screen.dart';
import 'generated/assets.dart';
import 'ui/first_screen.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizeConfigInit(
      referenceHeight: 900,
      referenceWidth: 400,
      builder: (BuildContext context, Orientation orientation) {
        return MaterialApp(
          title: 'TALKY',
          debugShowCheckedModeBanner: false,
          theme: myTheme
              .copyWith(
            colorScheme: myTheme.colorScheme.copyWith(primary: Colors.black,),
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}

ThemeData myTheme=
  ThemeData(
    // Define the default brightness and colors.
    // brightness: Brightness.dark,
    primaryColor: Colors.black,
    //
    // colorScheme: const ColorScheme(
    //     brightness: Brightness.light,
    //     primary: Colors.black,
    // onPrimary: Colors.black,
    // secondary: Colors.black,
    // onSecondary: Colors.black,
    //     error: Colors.red,
    //     onError: Colors.redAccent,
    //     background: Colors.black,
    //     onBackground: Colors.black,
    //     onSurface: Colors.black,
    //     surface: Colors.black),
    // Define the default font family.
    fontFamily: FontFamily.leagueSpartan,

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
        displaySmall: TextStyle(//for App Bar TALKY.
            color: Colors.black,
            height: 80.hp,
            fontSize: 9.25.wp,
            fontWeight: FontWeight.w800),
        labelSmall: TextStyle(//for TAL KY space in appbar
          color: Colors.black,
          fontSize: 1.125.wp,),
        displayLarge: TextStyle( //For MAIN TALKY.
            color: Colors.black,
            height: 80.hp,
            fontSize: 37.5.wp,
            fontWeight: FontWeight.w700),

        bodyMedium: TextStyle(//for normal words
          color: Colors.black,
          fontSize: 10.25.wp,),
        bodyLarge: TextStyle(//for normal words but BOLD
            color: Colors.black,
            fontSize: 10.25.wp,
            fontWeight: FontWeight.w700),
        labelMedium: TextStyle(//for normal words 2nd screen
          color: Colors.black,
          fontSize: 12.5.wp,),
        titleMedium: TextStyle(//for normal words 2nd screen
            color: Colors.black,
            fontSize: 12.5.wp,fontWeight: FontWeight.w900),
        displayMedium: TextStyle(//for LETS GO & START TALKING
            color: Colors.black,
            fontSize: 50.h,
            fontWeight: FontWeight.w500),
        bodySmall: TextStyle(//for are you sure? YES and NO
            color: Colors.black,
            fontSize: 6.wp,
            fontWeight: FontWeight.w700),
        titleSmall: TextStyle(//for are you sure? do you want to exit TALKY
          color: Colors.black,
          fontSize: 6.wp,),

        labelLarge: TextStyle( //Nationality AGE Gender
          color: Colors.black,

          fontSize: 8.75.wp,),
        titleLarge: TextStyle(color: Colors.red,fontSize: 4.5.wp)
    ),
  );
