import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'main_screen.dart';
import 'navi.dart';
import 'profile.dart';

class Setting extends StatefulWidget {
  final String imageUrl;
  final String name;

  const Setting({Key? key, required this.imageUrl, required this.name}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  bool _isDarkTheme = false; // 다크 테마 여부를 나타내는 변수

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight - 90,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: screenWidth,
                      height: screenHeight - 90,
                      decoration: BoxDecoration(color: Color(0xFFFBFAFA)),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 160,
                    top: 107,
                    child: Container(
                      width: 320,
                      height: 582,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(27),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0xFF000000),
                            blurRadius: 0,
                            offset: Offset(2, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 90,
                    top: 40,
                    child: Container(
                      width: 248,
                      height: 37,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0xFF000000),
                            blurRadius: 0,
                            offset: Offset(2, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 160,
                    top: 40,
                    child: Profile(imageUrl: widget.imageUrl, name: widget.name), // Profile 위젯 사용
                  ),
                  Positioned(
                    left: screenWidth / 2 - 20,
                    top: 50,
                    child: SizedBox(
                      width: 105,
                      height: 17,
                      child: Image.asset("assets/runwith_high_resolution_logo_transparent_12.png"),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 158,
                    top: 120,
                    child: Text(
                      '기본 설정',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 158,
                    top: 158,
                    child: Container(
                      width: 318,
                      height: 53,
                      decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 158,
                    top: 212,
                    child: Container(
                      width: 318,
                      height: 53,
                      decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 154,
                    top: 170,
                    child: Text(
                      '언어',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 + 90,
                    top: 170,
                    child: Text(
                      '한국어',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 154,
                    top: 224,
                    child: Text(
                      '테마',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 154,
                    top: 265,
                    child: Text(
                      '권한 설정',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 158,
                    top: 303,
                    child: Container(
                      width: 318,
                      height: 53,
                      decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 158,
                    top: 357,
                    child: Container(
                      width: 318,
                      height: 53,
                      decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 154,
                    top: 315,
                    child: Text(
                      '알림',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 154,
                    top: 369,
                    child: Text(
                      '위치',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 154,
                    top: 410,
                    child: Text(
                      '기타',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 158,
                    top: 448,
                    child: Container(
                      width: 318,
                      height: 53,
                      decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 158,
                    top: 502,
                    child: Container(
                      width: 318,
                      height: 53,
                      decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 158,
                    top: 556,
                    child: Container(
                      width: 318,
                      height: 53,
                      decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 154,
                    top: 460,
                    child: Text(
                      '도움말(FAQ)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 154,
                    top: 514,
                    child: Text(
                      '로그아웃',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 154,
                    top: 568,
                    child: Text(
                      '버전',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 + 90,
                    top: 568,
                    child: Text(
                      'v1.2.1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 20,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 + 120,
                    top: 514,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/forward.png"),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 + 120,
                    top: 460,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/forward.png"),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 + 120,
                    top: 369,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/forward.png"),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 + 120,
                    top: 315,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/forward.png"),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 + 90,
                    top: 215,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Switch(
                          value: _isDarkTheme,
                          onChanged: (value) {
                            setState(() {
                              _isDarkTheme = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
          child: MyBottomNavigationBar(
            selectedIndex: 2,
            onItemTapped: (int index) {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Main(data: widget.imageUrl, name: widget.name)),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
