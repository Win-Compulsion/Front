import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import 'main_screen.dart';

String email = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initNotiSetting(); // Local Notification 초기 설정
  runApp(MaterialApp(
    title: 'Runwith',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: "NanumGothic",
    ),
    home: MyApp(),
  ));
}

Future<void> _initNotiSetting() async {
  // Notification 플러그인 객체 생성
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // 안드로이드 초기 설정
  final AndroidInitializationSettings initSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  // Notification에 위에서 설정한 안드로이드, IOS 초기 설정 값 삽입
  final InitializationSettings initSettings = InitializationSettings(
    android: initSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
  );
  // Notification 초기 설정
  // onSelectNotification 옵션을 넣어서 메세지를 누르면 작동되는 콜백 함수를 생성 할 수 있다.(안써도됨)
  // 안쓰게되면 해당 노티 클릭시 앱을 그냥 실행한다.
  // await flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification:[콜백] );
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
                      child: Image.asset("assets/runwith_high_resolution_logo_transparent_12.png"),
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
      // 로그인 성공 후 페이지 이동
      email = googleUser.email;
      final response = await http.get(
        Uri.parse('https://httpbin.org/get?email=$email'),
      );
      if (response.statusCode == 200) {
        if(response.body == "{1}"){return;}

        await _showGenderInputBottomSheet();
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Main(data: googleUser.photoUrl, name: googleUser.displayName)),
      );
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
      _saveGender(selectedGender);
    }
  }

  void _saveGender(String gender) {
    http.post(
      Uri.parse('https://httpbin.org/get?gender=$gender'),
    );
    print('성별 저장: $gender');
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
