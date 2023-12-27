import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tebak_gambar_nusantara/app/modules/home/views/exercise_page.dart';

void main() {
  runApp(GetMaterialApp(
    home: LevelPage(),
  ));
}

class LevelPage extends StatefulWidget {
  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  List<Map<String, String>> levels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLevels();
  }

  Future<void> fetchLevels() async {
    final response = await http.get(
        Uri.parse('https://db.nyanhosting.id/game/api/?query=level'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        levels = data.map((item) => {
          'id': item['id'].toString(),
          'level': item['level'].toString(),
        }).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load levels');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
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
            child: SingleChildScrollView(
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
                  Column(
                    children: levels.map((level) {
                      return buildLevelContainer(
                        context,
                        'Level ${level['level']}',
                        getIconPath(int.parse(level['level']!)),
                        () {
                          Get.to(() =>
                              ExercisePage(levelId: int.parse(level['id']!)));
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  String getIconPath(int level) {
    int iconIndex = (level - 1) % 3 + 1;
    return 'assets/icon$iconIndex-wow.png';
  }

  Widget buildLevelContainer(BuildContext context, String level,
      String? imagePath, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
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
                  color: Color.fromRGBO(40, 18, 75, 0.776),
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
                child: imagePath != null
                    ? Image.asset(
                        imagePath,
                        width: 50,
                        height: 50,
                      )
                    : SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}