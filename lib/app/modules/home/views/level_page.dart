import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    home: LevelPage(),
  ));
}

class LevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFF301F40),
                Color(0xFF46244C),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60), 
              Text(
                'Tentukan Levelmu!',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'Galindo',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              for (int i = 1; i <= 20; i++)
                buildLevelContainer(
                  context,
                  'Level $i',
                  getIconPath(i),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String getIconPath(int level) {
    int iconIndex = (level - 1) % 3 + 1;
    return 'assets/icon$iconIndex-wow.png';
  }

  Widget buildLevelContainer(
      BuildContext context, String level, String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 45),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFCDBDE7),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              level,
              style: TextStyle(
                color: Color.fromRGBO(29, 17, 49, 0.78),
                fontFamily: 'Galindo',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.35,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
