import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

import 'package:runwith/main_screen.dart'; // Import the dart async package for Timer

class Matching extends StatefulWidget {
  final int distance;
  Matching({Key? key, required this.distance}) : super(key: key);

  @override
  _MatchingState createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {
  late Timer _timer;
  Duration _elapsed = Duration();
  double _distanceCovered = 0.0;
  Position? _previousPosition;

  @override
  void initState() {
    super.initState();
    _startStopwatch();
    _requestLocationPermission();
  }

  void _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied || status.isRestricted) {
      await Permission.locationWhenInUse.request();
    }
    if (await Permission.locationWhenInUse.isGranted) {
      _startLocationTracking();
    }
  }

  void _startStopwatch() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed = _elapsed + Duration(seconds: 1);
      });
    });
  }

  void _startLocationTracking() {
    Geolocator.getPositionStream().listen((Position? position) {
      if (position != null && _timer.isActive) {
        if (_previousPosition != null) {
          double distanceInMeters = Geolocator.distanceBetween(
            _previousPosition!.latitude,
            _previousPosition!.longitude,
            position.latitude,
            position.longitude,
          );
          setState(() {
            _distanceCovered += distanceInMeters / 1000;
          });
        }
        _previousPosition = position;
      }

    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formattedElapsedTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(_elapsed.inMinutes.remainder(60));
    String seconds = twoDigits(_elapsed.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  String _formattedPace() {
    if (_distanceCovered == 0) return "00'00\"";
    double pace = _elapsed.inSeconds / _distanceCovered;
    int paceMinutes = (pace / 60).floor();
    int paceSeconds = (pace % 60).round();
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(paceMinutes)}'${twoDigits(paceSeconds)}\"";
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;

    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        body: Theme(
          data: ThemeData.light(),
          child: ListView(
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
                        decoration: BoxDecoration(color: Color(0xFFFBFAFA)),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 160,
                      top: 107,
                      child: Container(
                        width: 320,
                        height: 600,
                        decoration: ShapeDecoration(
                          color: Color(0xFF3B3B3B),
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
                      left: screenWidth / 2 - 160,
                      top: 107,
                      child: Container(
                        width: 320,
                        height: 100,
                        decoration: ShapeDecoration(
                          color: Color(0xFF5E5E5E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 150,
                      top: 150,
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Color(0xFF969696),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 145,
                      top: 155,
                      child: Container(
                        width: 20,
                        height: 30,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFC35A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 145,
                      top: 130,
                      child: Text(
                        '진행도',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 10,
                      top: 160,
                      child: Text(
                        '0%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 120,
                      top: 250,
                      child: Text(
                        _formattedElapsedTime(), // Use the formatted elapsed time
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 + 60,
                      top: 250,
                      child: Text(
                        _formattedPace(), // Use the formatted pace
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'NanumGothic',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 102,
                      top: 275,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset("assets/clock.png"),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 + 80,
                      top: 275,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset("assets/shoesgray.png"),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 70,
                      top: 320,
                      child: Text(
                        _distanceCovered.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                          fontFamily: 'Ranga',
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 + 10,
                      top: 380,
                      child: Text(
                        getDistance(widget.distance),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFBEBEBE),
                          fontSize: 45,
                          fontFamily: 'Ranga',
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 50,
                      top: 440,
                      child: Text(
                        'Kilometers',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFBEBEBE),
                          fontSize: 30,
                          fontFamily: 'Ranga',
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 159,
                      top: 527,
                      child: ClipPath(
                        clipper: CustomClipperPath(),
                        child: Container(
                          width: 320,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 20,
                      top: 550,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset("assets/Redhuman.png"),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 120,
                      top: 620,
                      child: Text(
                        '0.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3B3B3B),
                          fontSize: 30,
                          fontFamily: 'NanumGothic',
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 100,
                      top: 650,
                      child: Text(
                        'KM',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3B3B3B),
                          fontSize: 20,
                          fontFamily: 'Ranga',
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 + 30,
                      top: 620,
                      child: Text(
                        '00\'00"',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3B3B3B),
                          fontSize: 30,
                          fontFamily: 'NanumGothic',
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 + 65,
                      top: 652,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset("assets/darkgrayshoes.png"),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDistance(int index) {
    switch (index) {
      case 0:
        return '/1.00';
      case 1:
        return '/3.00';
      case 2:
        return '/5.00';
      default:
        return "/0.00";
    }
  }
}

class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 70); // top-left corner with padding
    path.lineTo(size.width / 2, 0); // top center (point)
    path.lineTo(size.width, 70); // top-right corner with padding
    path.lineTo(size.width, size.height); // bottom-right corner
    path.lineTo(0, size.height); // bottom-left corner
    path.close(); // close the path to the start point
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
