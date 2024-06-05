import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String imageUrl;
  final String name;

  Profile({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                child: Image.network(imageUrl),
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
                name,
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
    );
  }
}
