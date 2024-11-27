import 'package:flutter/material.dart';
import 'setting.dart';
import 'matching_choose.dart';
import 'package:flutter_image/flutter_image.dart';

String nameAll = "";
String dataAll = "";
bool isDarkTheme = false;
class Main extends StatelessWidget {
  final String? data;
  final String? name;
  final String? email;

  Main({super.key, required this.data, required this.name, this.email});

  @override
  Widget build(BuildContext context) {
    String dataConvert = data ?? "https://i.pinimg.com/736x/d6/64/b2/d664b27cca7eaf4d64c41622b5bb9b6c.jpg";
    String nameConvert = name ?? "닉네임";
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    final PageController pageController = PageController(initialPage: 0);

    int selectedIndex = 0;

    void onItemTapped(int index) {
      nameAll = nameConvert;
      dataAll = dataConvert;
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
        );
      } else if (index == 1){
        // Handle other navigation items here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Matchingchoose(email: email)),
        );
      }
    }

    return MaterialApp(
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(), // _isDarkTheme 값에 따라 테마 설정
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight - 90,
              clipBehavior: Clip.hardEdge,
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
                    left: screenWidth / 2 - 240,
                    top: 400,
                    child: SizedBox(

                        width: 475,
                        height: 383,
                        child: Image.asset("assets/image_3.png",opacity:const AlwaysStoppedAnimation(.2),)

                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 180,
                    top: 0,
                    child: Container(
                      width: 360,
                      height: 459,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 88,
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
                    top: 109,
                    child: Container(
                      width: 320,
                      height: 209,
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
                    left: screenWidth / 2 - 156 ,
                    top: 346,
                    child: InkWell(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
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
                          const SizedBox(width: 13),
                          Container(
                            width: 70,
                            height: 70,
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
                          const SizedBox(width: 13),
                          Container(
                            width: 70,
                            height: 70,
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
                          const SizedBox(width: 13),

                          Container(
                            width: 70,
                            height: 70,
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
                        ],
                      ),
                    ),),
                  Positioned(
                    left: screenWidth / 2 - 156 ,
                    top: 346,
                    child: InkWell(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset("assets/win.png"),
                          ),
                          const SizedBox(width: 13),
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset("assets/lose.png"),
                          ),
                          const SizedBox(width: 13),
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset("assets/lose.png"),
                          ),
                          const SizedBox(width: 13),
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset("assets/win.png"),
                          ),
                        ],
                      ),
                    ),),
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
                                    child: Image(image: NetworkImage(dataConvert)
                                    )
                                )
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
                                nameConvert,
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
                    left: screenWidth / 2 - 111,
                    top: 485,
                    child: SizedBox(
                      width: 222,
                      height: 500,
                      child: PageView(
                        controller: pageController,
                        children: [
                          SizedBox(
                            width: 222,
                            height: 134,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 47,
                                  top: 0,
                                  child: SizedBox(
                                      width: 130,
                                      height: 58,
                                      child: DefaultTextStyle(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.w100,
                                          height: 0,
                                        ),
                                        child:Text(
                                          '1Km',
                                          textAlign: TextAlign.center,
                                        ),
                                      )

                                  ),
                                ),
                                Positioned(
                                  left: 1,
                                  top: 118,
                                  child: Container(
                                    width: 141,
                                    height: 14,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFDFEF81),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 1,
                                  top: 93,
                                  child: Container(
                                    width: 159,
                                    height: 14,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF96FFDC),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 1,
                                  top: 117,
                                  child: Container(
                                    width: 221,
                                    height: 16,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 1),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 92,
                                  child: Container(
                                    width: 221,
                                    height: 16,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 1),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: 19,
                                    top: 91,
                                    child: DefaultTextStyle(style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                      child:Text(
                                        '550/800',
                                        textAlign: TextAlign.center,

                                      ),
                                    )

                                ),
                                Positioned(
                                  left: 4,
                                  top: 93,
                                  child: SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: Image.asset("assets/crown.png"),
                                  ),
                                ),
                                Positioned(
                                    left: 19,
                                    top: 116,
                                    child: DefaultTextStyle(style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                      child:Text(
                                        '68%',
                                        textAlign: TextAlign.center,

                                      ),
                                    )

                                ),
                                Positioned(
                                  left: 4,
                                  top: 118,
                                  child: SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: Image.asset("assets/graph.png"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 222,
                            height: 134,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 47,
                                  top: 0,
                                  child: SizedBox(
                                      width: 130,
                                      height: 58,
                                      child: DefaultTextStyle(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.w100,
                                          height: 0,
                                        ),
                                        child:Text(
                                          '3Km',
                                          textAlign: TextAlign.center,
                                        ),
                                      )

                                  ),
                                ),
                                Positioned(
                                  left: 1,
                                  top: 118,
                                  child: Container(
                                    width: 141,
                                    height: 14,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFDFEF81),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 1,
                                  top: 93,
                                  child: Container(
                                    width: 159,
                                    height: 14,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFD9D9D9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 1,
                                  top: 117,
                                  child: Container(
                                    width: 221,
                                    height: 16,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 1),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 92,
                                  child: Container(
                                    width: 221,
                                    height: 16,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 1),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: 19,
                                    top: 91,
                                    child: DefaultTextStyle(style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                      child:Text(
                                        '550/800',
                                        textAlign: TextAlign.center,

                                      ),
                                    )

                                ),
                                Positioned(
                                  left: 4,
                                  top: 93,
                                  child: SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: Image.asset("assets/crown.png"),
                                  ),
                                ),
                                Positioned(
                                    left: 19,
                                    top: 116,
                                    child: DefaultTextStyle(style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                      child:Text(
                                        '68%',
                                        textAlign: TextAlign.center,

                                      ),
                                    )

                                ),
                                Positioned(
                                  left: 4,
                                  top: 118,
                                  child: SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: Image.asset("assets/graph.png"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 222,
                            height: 134,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 47,
                                  top: 0,
                                  child: SizedBox(
                                      width: 130,
                                      height: 58,
                                      child: DefaultTextStyle(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontFamily: 'Oswald',
                                          fontWeight: FontWeight.w100,
                                          height: 0,
                                        ),
                                        child:Text(
                                          '5Km',
                                          textAlign: TextAlign.center,
                                        ),
                                      )

                                  ),
                                ),
                                Positioned(
                                  left: 1,
                                  top: 118,
                                  child: Container(
                                    width: 141,
                                    height: 14,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFDFEF81),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 1,
                                  top: 93,
                                  child: Container(
                                    width: 159,
                                    height: 14,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF21E8A6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 1,
                                  top: 117,
                                  child: Container(
                                    width: 221,
                                    height: 16,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 1),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 92,
                                  child: Container(
                                    width: 221,
                                    height: 16,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 1),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: 19,
                                    top: 91,
                                    child: DefaultTextStyle(style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                      child:Text(
                                        '550/800',
                                        textAlign: TextAlign.center,

                                      ),
                                    )

                                ),
                                Positioned(
                                  left: 4,
                                  top: 93,
                                  child: SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: Image.asset("assets/crown.png"),
                                  ),
                                ),
                                Positioned(
                                    left: 19,
                                    top: 116,
                                    child: DefaultTextStyle(style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Oswald',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                      child:Text(
                                        '68%',
                                        textAlign: TextAlign.center,

                                      ),
                                    )

                                ),
                                Positioned(
                                  left: 4,
                                  top: 118,
                                  child: SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: Image.asset("assets/graph.png"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 + 130,
                    top: 567,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/forward.png"),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 20 ,
                    top: 50,
                    child: SizedBox(
                      width: 105,
                      height: 17,
                      child: Image.asset("assets/runwith_high_resolution_logo_transparent_12.png"),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 - 115,
                    top: 91,
                    child: SizedBox(
                      width: 230,
                      height: 215,
                      child: PageView(
                        controller: pageController,
                        children: [
                          Image.asset("assets/image_4.png"),
                          Image.asset("assets/image_5.png"),
                          Image.asset("assets/image_6.png"),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth / 2 + 120,
                    top: 196,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/forward.png"),
                    ),
                  ),
                ],
              ),
            ),
          ],),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
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
              currentIndex: selectedIndex,
              onTap: onItemTapped
          ),
        ),
      ),
    );
  }
}