import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:size_config/size_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:loading_indicator/loading_indicator.dart';

import 'reviewing.dart';

// import 'package:talky/common.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talky/ui/first_screen.dart';
import 'package:talky/ui/fourth_screen.dart';
import 'package:talky/ui/second_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef _Fn = void Function();

const theSource = AudioSource.microphone;

class MyThirdScreen extends StatefulWidget {
  const MyThirdScreen({Key? key}) : super(key: key);

  @override
  State<MyThirdScreen> createState() => _MyThirdScreenState();
}

class _MyThirdScreenState extends State<MyThirdScreen> {
  IconData startRecordIcon = Icons.fiber_manual_record;
  IconData stopRecordIcon = Icons.stop;

  // int isRecording = -1;

  Codec _codec = Codec.pcm16WAV;
  String _mPath = '/data/user/0/com.example.talky/app_flutter/talky.wav';

  // FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();

  // bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;

  // bool _mplaybackReady = false;
  int currentCounter = 0;
  String age = " ";
  String nationality = " ";
  String gender = " ";
  late int length = arabicCommands.length;
  String audioUrl = " ";
  bool _allow = false;
  bool uploading = false;
  bool reviewing = false;
  bool isRecording = false;
  Timer t = Timer(const Duration(seconds: 4), () {});
  List<String> arabicCommands = [
    '',
    'للأعلى',
    'للأسفل',
    'إلى الأعلى',
    'إلى الأسفل',
    'ثَبّت',
    'تَحَرّك',
    'للأمام',
    'للخلف',
    'لليمين',
    'لليسار',
    'سلام',
    'مرحبا',
    'شكرا',
    'لا',
    'نعم',
    'إلى',
    'من',
    'عند',
    'بين',
    'حول',
    'عبر',
    'فوق',
    'تحت',
    'بعد',
    'قبل',
    'خلال',
    'بينما',
    'إذا',
    'عندما',
    'حتى',
    'أثناء',
    'ضع',
    'تأكيد',
    'تابع',
    'استمر',
    'صفر',
    'واحد',
    'اثنان',
    'ثلاثة',
    'أربعة',
    'خمسة',
    'ستة',
    'سبعة',
    'ثمانية',
    'تسعة',
    'عشرة',
    'عشرون',
    'ثلاثون',
    'أربعون',
    'خمسون',
    'ستون',
    'سبعون',
    'ثمانون',
    'تسعون',
    'مئة',
    'إعادة',
    'إلغاء',
    'حذف',
    'إضافة الى',
    "العودة",
    "تغيير",
    "اتصل",
    "الوضع",
    "الوظيفة",
    "الساعة",
    "مؤقت",
    "إفتح",
    "اغلق",
    "ابدء",
    "تثبيت",
    "تشغيل",
    "إلغاء",
    "إعدادات",
    "المزيد",
    "إضافة",
    "ضَبِطَ",
    "أَحمَر",
    "أَخضَر",
    "أَزرَق",
    "أَسوَد",
    "أَبيَض",
    "بُرتُقَالِيّ",
    "أُرجُوَانيّ",
    "تعيين اللون",
    "تجنب",
    "اذهب",
    "اتبع",
    "فحص",
    "كشف",
    "تحديد",
    "التقاط",
    "امسك",
    "أطلق",
    "اضغط",
    "اسحب",
    "أقفل",
    "تفعيل",
    "تخطي",
    "تسجيل",
    "حفظ",
    "تحميل",
    "حذف",
    'مسح',
    'انسخ',
    'الصق',
    'تراجع',
    'بحث',
    'إعادة',
    'قراءة',
    'تحدث',
    'ترجمة',
    'تحويل',
    'احسب',
    'عرض',
    'إخفاء',
    'تكبير',
    'تصغير',
    'اكتب',
    'نوم',
    'استيقظ',
    'تأجيل',
    'اتصل',
    'الرد',
    "العودة إلى الخلف",
    "كتم الصوت",
    "ارفع الصوت",
    "خفض الصوت",
    "إنهاء المكالمة",
    "إيقاف مؤقت",
    "ضَبِطَ الحرارة",
    'إعادة التشغيل',
    'إرسال رسالة',
    'استلام الرسائل',
    'إعادة توجيه الرسائل',
    'الرد على الرسائل',
    'إرسال بريد إلكتروني',
    'استلام البريد الإلكتروني',
    'إعادة توجيه البريد الإلكتروني',
    'الرد على البريد الإلكتروني',
    'كيف هو الطقس',
    'كم الساعة الآن',
    'تاريخ اليوم',
    'تشغيل الإضاءة',
    'إيقاف الإضاءة',
    'إضافة',
  ];

  @override
  void initState() {
    // _mPlayer!.openPlayer().then((value) {
    //   setState(() {
    //     _mPlayerIsInited = true;
    //   });
    // });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });

    super.initState();
    setState(() {
      _loadData();
    });
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentCounter = prefs.getInt('Counter')!;
      age = prefs.getString('Age')!;
      nationality = prefs.getString('Nationality')!;
      gender = prefs.getString('Gender')!;
      _allow = prefs.getBool('Allow')!;
    });
  }

  @override
  void dispose() {
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.

    // _mPlayer!.closePlayer();
    // _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      setState(() {});
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

// ----------------------  Here is the code for recording and playback -------

  String formatCounter(int counter) {
    switch (counter) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
      case 8:
      case 9:
        return '0$counter';
      default:
        return '$counter';
    }
  }

  Future uploadAudio() async {
    String formattedCounter = formatCounter(currentCounter);
    print(formattedCounter); // Output: "05"

    final storageRef = FirebaseStorage.instance.ref();
    final audioRef = storageRef.child(
        "commands/$formattedCounter ${arabicCommands[currentCounter]}/Talky.$formattedCounter"
        "_"
            "${FirebaseAuth.instance.currentUser?.uid.substring(0, 7)}.wav");
    final wordsAudioRef = storageRef.child(
        "audios/commands/$formattedCounter ${arabicCommands[currentCounter]}/Talky.$formattedCounter"
            "_"
            "${FirebaseAuth.instance.currentUser?.uid.substring(0, 7)}.wav");
    assert(audioRef.name == wordsAudioRef.name);
    assert(audioRef.fullPath != wordsAudioRef.fullPath);
    String filePath = '/data/user/0/com.example.talky/app_flutter/talky.wav';
    File file = File(filePath);

    try {
      final TaskSnapshot snapshot = await audioRef.putFile(file);

      final downloadUrl = await snapshot.ref.getDownloadURL();

      // String hi =
      //     await task.ref.getDownloadURL();
      setState(() {
        audioUrl = downloadUrl;
      });
    } on firebase_core.FirebaseException catch (e) {
      var snackBar = SnackBar(
        content: Text("FirebaseCore Error $e"),
        duration: Duration(seconds: 10),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("PROBLEEEEEEEEEEEEEEEEEEEEEEM \n \n $e");
    } catch (e) {
      var snackBar =
          SnackBar(content: Text("~Error $e"), duration: Duration(seconds: 10));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future saveToFirestore() async {
    String formattedCounter = formatCounter(currentCounter);
    print(formattedCounter); // Output: "05"

    final wordRef = FirebaseFirestore.instance
        .collection('$formattedCounter ${arabicCommands[currentCounter]}')
        .doc('Talky.$formattedCounter'
            '_'
            '${FirebaseAuth.instance.currentUser?.uid.substring(0, 7)}');
    bool notVerified = false;
    await wordRef.set({
      'audio_url': audioUrl,
      'user_id': FirebaseAuth.instance.currentUser?.uid,
      'audio_id': 'Talky.$formattedCounter'
          '_'
          '${FirebaseAuth.instance.currentUser?.uid.substring(0, 7)}',
      'nationality': nationality,
      'user_gender': gender,
      'user_age': age,
      'verified': notVerified
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Counter', currentCounter + 1);
    setState(() {
      currentCounter = prefs.getInt('Counter')!;
    });
    if (currentCounter == 146) {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyFourthScreen()),
      );
    }
  }

  void noth() {
    setState(() {});
  }

  void onReview() async {
    setState(() {
      uploading = true;
      reviewing = false;
    });
    await uploadAudio();
    await saveToFirestore();
    setState(() {
      uploading = false;
    });
  }

  void record() {
    setState(() {
      isRecording = true;
    });
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {
        if(currentCounter<125){
        t = Timer(const Duration(seconds: 4), () {
          if (isRecording == true) {
            setState(() {
              isRecording = false;
            });
            stopRecorder();
          }
        });}
        else{
          t = Timer(const Duration(seconds: 6), () {
            if (isRecording == true) {
              setState(() {
                isRecording = false;
              });
              stopRecorder();
            }
          });

        }
      });
    });

    setState(() {});
  }

  void stopRecorder() async {
    setState(() {
      t.cancel();
    });
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        // _mplaybackReady = true;
      });
    });
    setState(() {
      reviewing = true;
    });
    // await uploadAudio();
    // await saveToFirestore();
    // setState(() {
    //   uploading = false;
    // });
  }

  // void play() {
  //   assert(_mPlayerIsInited &&
  //       _mplaybackReady &&
  //       _mRecorder!.isStopped &&
  //       _mPlayer!.isStopped);
  //   _mPlayer!
  //       .startPlayer(
  //           fromURI: _mPath,
  //           //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
  //           whenFinished: () {
  //             setState(() {});
  //           })
  //       .then((value) {
  //     print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii $_mPath");
  //     setState(() {});
  //   });
  // }

  // void stopPlayer() {
  //   _mPlayer!.stopPlayer().then((value) {
  //     setState(() {});
  //   });
  // }

  // _Fn? getPlaybackFn() {
  //   if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
  //     return null;
  //   }
  //   return _mPlayer!.isStopped ? play : stopPlayer;
  // }

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited
        // || !_mPlayer!.isStopped
        ) {
      return null;
    }
    return reviewing
        ? onReview
        : uploading
            ? noth
            : _mRecorder!.isStopped
                ? record
                : stopRecorder;
  }

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
          centerTitle: true,
            title:Text("$currentCounter / 145",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
              //   child: OutlinedButton(
              //     child: const Icon(Icons.logout),
              //     onPressed: () async {
              //       await FirebaseAuth.instance.signOut();
              //       // ignore: use_build_context_synchronously
              //       Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const MySecondScreen()),
              //       );
              //     },
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10.h, 15.w, 0),
                child: SizedBox(
                    child: Image(
                  image: const AssetImage("assets/talky2.png"),
                  height: 5.h,
                )),

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
        floatingActionButton: FloatingActionButton.large(
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            splashColor: Colors.redAccent,
            onPressed: getRecorderFn(),
            child: reviewing
                ? Icon(
                    Icons.check_rounded,
                    size: 11.25.wp,
                    color: Colors.red,
                  )
                : uploading
                    ? LoadingIndicator(
                        indicatorType: Indicator.ballClipRotateMultiple,
                        colors: const [Colors.red],
                        strokeWidth: 1.25.wp,
                        pathBackgroundColor: Colors.black45,
                      )
                    : Icon(
                        _mRecorder!.isRecording
                            ? stopRecordIcon
                            : startRecordIcon,
                        size: 11.25.wp,
                        color: Colors.red,
                      )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: EdgeInsets.all(10.s),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: currentCounter == 1
                    ? RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Your ",
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: <TextSpan>[
                              TextSpan(
                                text: "First word ",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextSpan(
                                text:
                                    // 'number $currentCounter '
                                    'is',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ]))
                    : RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Next ",
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: <TextSpan>[
                              TextSpan(
                                text: "word ",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextSpan(
                                text:
                                    // 'number $currentCounter '
                                    'is',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            ])),
              ),
              Text(
                "\" ${arabicCommands[currentCounter]} \"",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              _mRecorder!.isStopped
                  ? SizedBox(
                      height: 70.h,
                    )
                  : Center(
                      child: SizedBox(
                        height: 70.h,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 13.wp,
                            ),
                            LoadingIndicator(
                                indicatorType: Indicator.lineScaleParty,
                                colors: const [Colors.red, Colors.black],
                                strokeWidth: 4.sp,
                                pathBackgroundColor: Colors.black),
                            SizedBox(
                              width: 2.wp,
                            ),
                            LoadingIndicator(
                                indicatorType: Indicator.lineScaleParty,
                                colors: const [Colors.red, Colors.black],
                                strokeWidth: 4.sp,
                                pathBackgroundColor: Colors.black),
                            SizedBox(
                              width: 2.wp,
                            ),
                            LoadingIndicator(
                                indicatorType: Indicator.lineScaleParty,
                                colors: const [Colors.red, Colors.black],
                                strokeWidth: 4.sp,
                                pathBackgroundColor: Colors.black),
                            SizedBox(
                              width: 2.wp,
                            ),
                            LoadingIndicator(
                                indicatorType: Indicator.lineScaleParty,
                                colors: const [Colors.red, Colors.black],
                                strokeWidth: 4.sp,
                                pathBackgroundColor: Colors.black),
                          ],
                        ),
                      ),
                    ),
              reviewing == false
                  ? SizedBox(height: 80.h)
                  : Container(
                      margin: EdgeInsets.all(2.wp),
                      padding: EdgeInsets.all(2.wp),
                      // height: 80.h,
                      // width: 85.wp,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Review(),
                          IconButton(
                            icon: const Icon(Icons.delete_forever),
                            color: Colors.red,
                            iconSize: 10.wp,
                            onPressed: () {
                              setState(() {
                                reviewing = false;
                              });
                            },
                          ),
                        ],
                      )),
              SizedBox(
                height: 1.wp,
              )
              // SizedBox(height: 1.h,)
              // Container(
              //   margin: const EdgeInsets.all(3),
              //   padding: const EdgeInsets.all(3),
              //   height: 80,
              //   width: double.infinity,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     color: Color(0xFFFAF0E6),
              //     border: Border.all(
              //       color: Colors.indigo,
              //       width: 3,
              //     ),
              //   ),
              //   child: Row(children: [
              //     ElevatedButton(
              //       onPressed: getPlaybackFn(),
              //       //color: Colors.white,
              //       //disabledColor: Colors.grey,
              //       child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
              //     ),
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     Text(_mPlayer!.isPlaying
              //         ? 'Playback in progress'
              //         : 'Player is stopped'),
              //   ]),
              // ),
              // ElevatedButton(
              //   onPressed: () async {
              //     try {
              
              //       await uploadAudio();
              //       await saveToFirestore();
              //     } catch (e) {
              //       print(" $e \n  \n \n");
              //     }
              //   },
              //   child: const Text('Upload Audio'),
              // ),
              // const SizedBox(
              //   height: 50,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
