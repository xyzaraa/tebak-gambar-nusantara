import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
      });
    } else {
      throw Exception('Failed to load levels');
    }
  }

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
              for (var level in levels)
                buildLevelContainer(
                  context,
                  'Level ${level['level']}',
                  getIconPath(int.parse(level['level']!)),
                  () {
                    // Menggunakan fungsi Get.to untuk navigasi ke ExercisePage dengan parameter level ID
                    Get.to(() => ExercisePage(levelId: int.parse(level['id']!)));
                  },
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
      BuildContext context, String level, String? imagePath, VoidCallback onPressed) {
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

class ExercisePage extends StatelessWidget {
  final int levelId;

  ExercisePage({required this.levelId});

  @override
  Widget build(BuildContext context) {
     return Container();
  }
}
