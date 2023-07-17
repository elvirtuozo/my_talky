import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talky/ui/first_screen.dart';
import 'package:talky/ui/fourth_screen.dart';
import 'third_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:size_config/size_config.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class MySecondScreen extends StatefulWidget {
  const MySecondScreen({Key? key}) : super(key: key);

  @override
  State<MySecondScreen> createState() => _MySecondScreenState();
}

class _MySecondScreenState extends State<MySecondScreen> {
  final List<String> nationalities = [
    'Algerian',
    'Bahraini',
    'Comorian',
    'Djiboutian',
    'Egyptian',
    'Emirati',
    'Iraqi',
    'Jordanian',
    'Kuwaiti',
    'Lebanese',
    'Libyan',
    'Mauritanian',
    'Moroccan',
    'Omani',
    'Palestinian',
    'Qatari',
    'Saudi',
    'Somali',
    'Sudanese',
    'Syrian',
    'Tunisian',
    'Yemeni',
  ];
  final List ages = [
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
    '60',
    '61',
    '62',
    '63',
    '64',
    '65',
    '66',
    '67',
    '68',
    '69',
    '70',
    '71',
    '72',
    '73',
    '74',
    '75',
    '76',
    '77',
    '78',
    '79',
    '80',
    '81',
    '82',
    '83',
    '84',
    '85',
  ];
  final List genders = [
    'Male',
    'Female',
  ];
  bool N = true;
  bool A = true;
  bool G = true;
  String? selectedNationality;
  String? selectedAge;
  String? selectedGender;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List items) {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Center(
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights(List items) {
    List<double> itemsHeights = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(50);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(5);
      }
    }
    return itemsHeights;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 0, 10.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                    text: "Please fill these\n",
                    style: Theme.of(context).textTheme.labelMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: "before we ",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      TextSpan(
                        text: 'Start!',
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ])),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Center(
                      child: Text(
                        'Nationality',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    items: _addDividersAfterItems(nationalities),
                    customItemsHeights: _getCustomItemsHeights(nationalities),
                    value: selectedNationality,
                    onChanged: (value) {
                      setState(() {
                        selectedNationality = value as String;
                      });
                    },
                    buttonDecoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    buttonHeight: 70,
                    dropdownMaxHeight: 300,
                    buttonWidth: 360,
                    itemPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.s),
                  child: Center(
                      child: Text(
                    !N ? "Please select your Nationality" : "",
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Center(
                      child: Text(
                        ' Age',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    items: _addDividersAfterItems(ages),
                    customItemsHeights: _getCustomItemsHeights(ages),
                    value: selectedAge,
                    onChanged: (value) {
                      setState(() {
                        selectedAge = value as String;
                      });
                    },
                    buttonDecoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    buttonHeight: 70,
                    dropdownMaxHeight: 700,
                    buttonWidth: 360,
                    itemPadding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.s),
                  child: Center(
                      child: Text(
                    !A ? "Please select your Age" : "",
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Center(
                      child: Text(
                        'Gender',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    items: _addDividersAfterItems(genders),
                    customItemsHeights: _getCustomItemsHeights(genders),
                    value: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value as String;
                      });
                    },
                    buttonDecoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    buttonHeight: 70,
                    dropdownMaxHeight: 200,
                    buttonWidth: 360,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.s),
                  child: Center(
                      child: Text(
                    !G ? "Please select your Gender" : "",
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                ),
              ],
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(250.w, 100.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0.s)),
                  side: BorderSide(width: 3.w, color: Colors.black),
                ),
                onPressed: () async {
                  if (selectedNationality == null) {
                    setState(() {
                      N = false;
                    });
                  } else {
                    N = true;
                  }
                  if (selectedAge == null) {
                    setState(() {
                      A = false;
                    });
                  } else {
                    A = true;
                  }
                  if (selectedGender == null) {
                    setState(() {
                      G = false;
                    });
                  } else {
                    G = true;
                  }

                  if (N == true && G == true && A == true) {
                    try {
                      UserCredential userCredential =
                          await FirebaseAuth.instance.signInAnonymously();
                      print(userCredential.user?.uid);
                      final prefs = await SharedPreferences.getInstance();

                      await prefs.setBool('Allow', false);
                      await prefs.setString('Age', selectedAge.toString());
                      await prefs.setString(
                          'Nationality', selectedNationality.toString());
                      await prefs.setString(
                          'Gender', selectedGender.toString());
                      await prefs.setInt('Counter', 1);
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyThirdScreen()),
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                  } else {
                    print("NOT ALL ARE TRUE");
                  }
                },
                child: Text(
                  "Start Talking ",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
