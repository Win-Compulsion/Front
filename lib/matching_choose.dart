import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:runwith/setting.dart';
import 'main_screen.dart';
import 'matching.dart';

class Matchingchoose extends StatefulWidget {
  Matchingchoose({super.key});

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

  void _showLoadingModal(int index) {
    print(index);
    // 여기에 백엔드 매칭 요청 보내기 추가, index 사용, 0은 1Km, 1은 3Km, 2는 5Km
    showDialog(
      context: context,
      barrierDismissible: true, // 사용자가 모달 외부를 터치하여 닫을 수 없도록 설정
      builder: (BuildContext context) {
        return  GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // 배경 클릭 시 모달을 닫습니다.
              _showLoadingEndModal(index);
        },
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(), // 로딩 이미지를 표시하는 위젯
              SizedBox(height: 50),
              Text(
                '매칭할 상대를 찾고 있습니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),


          ]),
        ),);
      },
    );
  }
  void _showLoadingEndModal(int index) {
    print(index);
    // 여기에 백엔드 매칭 요청 보내기 추가, index 사용, 0은 1Km, 1은 3Km, 2는 5Km
    showDialog(
      context: context,
      barrierDismissible: true, // 사용자가 모달 외부를 터치하여 닫을 수 없도록 설정
      builder: (BuildContext context) {
        return  GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // 배경 클릭 시 모달을 닫습니다.
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Matching(distance: index,),
              ),
            );
          },
          child: AlertDialog(
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
                  ),


                ]),
          ),);
      },
    );
  }
}
