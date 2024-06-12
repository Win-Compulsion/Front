import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'main_screen.dart';

String email = "";

Future<void> clearAllPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
} //테스트용, SharedPreferences에 있는 로컬 정보 제거용 함수

Future<void> signOutGoogle() async {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  await googleSignIn.signOut();
}//테스트용, 구글 로그아웃 함수


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await clearAllPreferences();
  await signOutGoogle();


  await _initNotiSetting(); // Local Notification 초기 설정

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedEmail = prefs.getString('email');
  String? savedGender = prefs.getString('gender');

  runApp(MaterialApp(
    title: 'Runwith',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: "NanumGothic",
    ),
    home: savedEmail != null && savedGender != null
        ? Main(data: savedEmail, name: savedGender)
        : MyApp(),
  ));
}

Future<void> _initNotiSetting() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initSettings = InitializationSettings(
    android: initSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 150, 255, 220),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: screenWidth,
                      height: screenHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-0.18, -0.98),
                          end: Alignment(0.48, 1.98),
                          colors: [Colors.black.withOpacity(0), Colors.black],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 124,
                    top: 276,
                    child: SizedBox(
                      width: 248,
                      height: 248,
                      child: Image.asset("assets/image_1.png"),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 138,
                    top: 261,
                    child: SizedBox(
                      width: 276,
                      height: 44,
                      child: Image.asset(
                          "assets/runwith_high_resolution_logo_transparent_12.png"),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 143.5,
                    top: 655,
                    child: SignInButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInButton extends StatefulWidget {
  const SignInButton({super.key});

  @override
  SignInButtonState createState() => SignInButtonState();
}

class SignInButtonState extends State<SignInButton> {
  Future<void> _handleSignIn() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // 사용자가 로그인을 취소함
        return;
      }

      PermissionStatus status = await Permission.notification.request();
      if (status != PermissionStatus.granted) {
        // 사용자가 알림 권한을 거부한 경우
        return;
      }
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 사용자가 위치 권한을 거부함
        return;
      }

      // 로그인 성공 후 이메일을 백엔드로 보내서 사용자가 등록되어 있는지 확인
      email = googleUser.email;
      final response = await http.get(
        Uri.parse('https://httpbin.org/get?email=$email'),
      );//에러테스트 http://noneurl.com/get?email=$email

      if (response.statusCode == 200) {
        await _showGenderInputBottomSheet();
        // 사용자 등록되어 있으면 메인 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Main(data: googleUser.photoUrl, name: googleUser.displayName)),
        );
      } else if (response.statusCode == 404) {
        // 사용자 등록되어 있지 않으면 성별 입력 받기
        await _showGenderInputBottomSheet();
      }else {
        print('연결 오류: ${response.statusCode}');
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', googleUser.email);

      print("로그인 성공: ${googleUser.email}"
          "${googleUser.displayName}"
          "${googleUser.photoUrl}");
    } catch (e) {
      print("로그인 오류: $e");
    }
  }

  Future<void> _showGenderInputBottomSheet() async {
    String? selectedGender = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('성별을 입력해주세요', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              ListTile(
                title: Text('남성'),
                onTap: () {
                  Navigator.pop(context, '남성');
                },
              ),
              ListTile(
                title: Text('여성'),
                onTap: () {
                  Navigator.pop(context, '여성');
                },
              ),
            ],
          ),
        );
      },
    );

    if (selectedGender != null) {
      await _saveGender(selectedGender);
    }
  }

  Future<void> _saveGender(String gender) async {
    // 성별을 백엔드로 저장 요청
    final response = await http.post(
      Uri.parse('https://httpbin.org/save-gender'),
      body: {'email': email, 'gender': gender},
    );//에러테스트 http://noneurl.com/save-gender

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('gender', gender);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Main(data: email, name: gender)),
      );

      print('성별 저장: $gender');
    } else {
      print('성별 저장 실패: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleSignIn,
      child: SizedBox(
        width: 287,
        height: 51,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 287,
                height: 51,
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(43),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 61,
              top: 13,
              child: SizedBox(
                width: 25,
                height: 25,
                child: Image.asset("assets/image_2.png"),
              ),
            ),
            Positioned(
              left: 61,
              top: 14,
              child: SizedBox(
                width: 194,
                height: 24,
                child: Text(
                  'Google로 로그인',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Istok Web',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
