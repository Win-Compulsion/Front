import 'package:flutter/material.dart';
import 'package:runwith/setting.dart';
import 'main_screen.dart';
import 'matching.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Matchingchoose extends StatefulWidget {
  String? email;
  Matchingchoose({super.key, this.email});

  @override
  _MatchingChooseState createState() => _MatchingChooseState();
}

class _MatchingChooseState extends State<Matchingchoose> {
  final bool _isDarkTheme = isDarkTheme; // 다크 테마 여부를 나타내는 변수
  final PageController _pageController = PageController(viewportFraction: 0.7);
  bool _isMatching = false; // 매칭 요청 진행 여부를 나타내는 변수

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

  void _showLoadingModal(int index) async {
    if (_isMatching) return; // 이미 매칭 중이면 함수 종료

    setState(() {
      _isMatching = true; // 매칭 요청 시작
    });

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

    try {
      final response = await _sendMatchingRequest(index);
      print(response['status']);

      if (response['status'] == 'waiting') {
        // 서버가 대기 중 상태를 반환하면 폴링 시작
        await _pollMatchingStatus(response['queueId'], index);
      } else if (response['status'] == 'success') {
        Navigator.of(context, rootNavigator: true).pop(); // 로딩 모달 닫기
        _showLoadingEndModal(index);
      } else {
        throw Exception(response['status'] ?? '알 수 없는 오류가 발생했습니다.');
      }
    } catch (e) {
      print("매칭 오류: $e");
      Navigator.of(context, rootNavigator: true).pop(); // 로딩 모달 닫기
      _showErrorModal("매칭에 실패했습니다: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isMatching = false; // 매칭 상태 초기화
        });
      }
    }
  }

  Future<Map<String, dynamic>> _sendMatchingRequest(int index) async {
    final uri = Uri.parse("http://10.0.2.2:8080/match/request"); // 백엔드 엔드포인트
    final body = jsonEncode({'distance': _getDistanceForIndex(index).toString(), 'email': widget.email});

    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to request matching');
    }
  }

// 상태 폴링 함수
  Future<void> _pollMatchingStatus(String queueId, int index) async {
    const pollingInterval = Duration(seconds: 5);
    const timeoutDuration = Duration(minutes: 2); // 2분 타임아웃
    final startTime = DateTime.now();

    while (true) {
      if (DateTime.now().difference(startTime) > timeoutDuration) {
        throw Exception("매칭 시간이 초과되었습니다.");
      }

      try {
        final status = await _checkMatchingStatus(queueId);

        if (status['status'] == 'success') {
          Navigator.of(context, rootNavigator: true).pop(); // 로딩 모달 닫기
          _showLoadingEndModal(index);
          return;
        } else if (status['status'] == 'failed') {
          throw Exception("매칭에 실패했습니다.");
        }
      } catch (e) {
        print("상태 확인 오류: $e");
      }

      await Future.delayed(pollingInterval); // 대기 후 다시 상태 확인
    }
  }

  Future<Map<String, dynamic>> _checkMatchingStatus(String queueId) async {
    final uri = Uri.parse('http://10.0.2.2:8080/match/status?queueId=$queueId');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to check matching status');
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

  void _showErrorModal(String errorMessage) {
    showDialog(
      context: context,
      barrierDismissible: true, // 사용자가 모달 외부를 터치하여 닫을 수 있도록 설정
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.redAccent,
          title: const Text(
            '매칭 실패',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 에러 모달 닫기
              },
              child: const Text('확인', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showLoadingEndModal(int index) {
    int secondsLeft = 3; // 카운트다운 시작 시간

    // 카운트다운 모달 띄우기
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // 카운트다운 진행
            Future.delayed(const Duration(seconds: 1), () {
              if (secondsLeft > 1) {
                setState(() {
                  secondsLeft--;
                });
              } else {
                Navigator.of(context).pop(); // 모달 닫기
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Matching(distance: index),
                  ),
                );
              }
            });

            return AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '상대를 찾았습니다. \n${secondsLeft}초 후 대전이 시작됩니다!',
                    style: const TextStyle(
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
      },
    );
  }
}
