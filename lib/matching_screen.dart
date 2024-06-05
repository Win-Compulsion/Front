import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MatchingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RUNWITH'),
      ),
      body: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        itemCount: 3,
        itemBuilder: (context, index) {
          return buildPage(index);
        },
      ),
    );
  }

  Widget buildPage(int index) {
    List<String> distances = ['1Km', '3Km', '5Km'];
    List<Color> colors = [Colors.purple, Colors.yellow, Colors.green];
    List<String> distanceParams = ['1km', '3km', '5km'];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey[200],
      child: Center(
        child: GestureDetector(
          onTap: () {
            requestMatch(distanceParams[index]);
          },
          child: Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                distances[index],
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void requestMatch(String distance) async {
    final url = Uri.parse('https://backend-url.com/match');
    final response = await http.post(
      url,
      body: {'distance': distance},
    );

    if (response.statusCode == 200) {
      // 요청 성공 시 처리
      print('Match requested successfully for $distance');
    } else {
      // 요청 실패 시 처리
      print('Failed to request match for $distance');
    }
  }
}
