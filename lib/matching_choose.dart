import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:runwith/setting.dart';
import 'main_screen.dart';
import 'matching.dart';
import 'package:http/http.dart' as http;

class Matchingchoose extends StatefulWidget {
  final String? email;
  Matchingchoose({super.key, this.email});

  @override
  _MatchingChooseState createState() => _MatchingChooseState();
}

class _MatchingChooseState extends State<Matchingchoose> {
  final bool _isDarkTheme = isDarkTheme; // 다크 테마 여부를 나타내는 변수
  final PageController _pageController = PageController(viewportFraction: 0.7);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return MaterialApp(
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        body: Theme(
          data: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
          child: ListView(
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
                        height: 400,
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
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 4,
                              top: 2,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFD9D9D9),
                                  shape: OvalBorder(side: BorderSide(width: 1)),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0xFF000000),
                                      blurRadius: 1,
                                      offset: Offset(2, 2),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 3,
                              top: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                child: SizedBox(
                                  width: 37,
                                  height: 37,
                                  child: Image(image: NetworkImage(dataAll)),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 32,
                              child: Container(
                                width: 44,
                                height: 12,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF96FFDC),
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
                              left: 7,
                              top: 33,
                              child: SizedBox(
                                width: 28,
                                height: 9,
                                child: Text(
                                  nameAll,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 9,
                                    fontFamily: 'NanumGothic',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                    // PageView 추가
                    Positioned(
                      left: screenWidth/2 - 160,
                      top: 150,
                      child: Container(
                        width: 320,
                        height: 300,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                              animation: _pageController,
                              builder: (context, child) {
                                double value = 1.0;
                                if (_pageController.position.haveDimensions) {
                                  value = _pageController.page! - index;
                                  value = (1 - (value.abs() * 0.4)).clamp(0.0, 0.9);
                                }
                                return GestureDetector(
                                    onTap: () {
                                  _showLoadingModal(index);
                                },
                                child:Transform.scale(
                                  scale: Curves.easeOut.transform(value),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    width: 70,
                                    height: 180,
                                    decoration: ShapeDecoration(
                                      color: getColorForIndex(index),
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          getTextForIndex(index),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          getDiscriptionIndex(index),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,

                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),

                                  ),
                                ));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          child: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: Colors.black),
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            backgroundColor: Color(0xFFD9D9D9),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_run),
                label: '러닝',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '설정',
              ),
            ],
            onTap: (int index) {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Main(data: dataAll, name: nameAll),
                  ),
                );
              } else if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Setting()),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Color getColorForIndex(int index) {
    switch (index) {
      case 0:
        return Color(0xFFA28EF4);
      case 1:
        return Color(0xFFF2F48E);
      case 2:
        return Color(0xFF9CF48D);
      default:
        return Colors.black;
    }
  }

  String getTextForIndex(int index) {
    switch (index) {
      case 0:
        return '1Km';
      case 1:
        return '3Km';
      case 2:
        return '5Km';
      default:
        return '';
    }
  }
  
  String getDiscriptionIndex(int index) {
    switch (index) {
      case 0:
        return '86Kcal \n약 5분 소요';
      case 1:
        return '320Kcal \n약 15분 소요';
      case 2:
        return '640Kcal \n약 25분 소요';
      default:
        return '';
    }
  }

  // 백엔드 매칭 요청 메서드
  Future<void> _sendMatchingRequest(int distanceIndex) async {
    final uri = Uri.parse("http://10.0.2.2:8080/match/request"); // 백엔드 엔드포인트
    final body = jsonEncode({'distance': _getDistanceForIndex(distanceIndex).toString(), 'email': widget.email});

    try {
      final response = await http.post(uri, headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        print("매칭 요청 성공: ${response.body}");
        _showLoadingEndModal(distanceIndex); // 매칭 성공 후 완료 모달 표시
      } else {
        print("매칭 요청 실패: ${response.statusCode} - ${response.body}");
        _showErrorModal();
      }
    } catch (e) {
      print("매칭 요청 중 에러 발생: $e");
      _showErrorModal();
    }
  }

  int _getDistanceForIndex(int index) {
    switch (index) {
      case 0:
        return 1;
      case 1:
        return 3;
      case 2:
        return 5;
      default:
        return 0;
    }
  }

  void _showErrorModal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('오류'),
          content: Text('매칭 요청 중 문제가 발생했습니다. 다시 시도해주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // 로딩 모달 표시 메서드
  void _showLoadingModal(int index) async {
    // 백엔드 매칭 요청 먼저 처리
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 50),
              Text(
                '매칭할 상대를 찾고 있습니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );

    // 매칭 요청 실행
    await _sendMatchingRequest(index);
  }
  // 매칭 완료 모달 표시 및 페이지 전환
  void _showLoadingEndModal(int index) {
    // 로딩 모달 닫기
    Navigator.of(context).pop();

    // 완료 모달 띄우기
    showDialog(
      context: context,
      barrierDismissible: false, // 모달 외부를 클릭해도 닫히지 않도록 설정
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                '상대를 찾았습니다. \n3초 후 대전이 시작됩니다!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );

    // 3초 후 Matching 페이지로 전환
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop(); // 완료 모달 닫기
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Matching(distance: index), // Matching 페이지로 이동
        ),
      );
    });
  }

}
