import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'exercise_page.dart';

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
  int completedLevel = 0;

  @override
  void initState() {
    super.initState();
    fetchLevels();
    _getCompletedLevel();
  }

  Future<void> fetchLevels() async {
    final response = await http.get(
        Uri.parse('https://db.nyanhosting.id/game/api/?query=level'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        levels = data
            .map((item) => {
                  'id': item['id'].toString(),
                  'level': item['level'].toString(),
                })
            .toList();

        isLoading = false;
      });
    } else {
      throw Exception('Failed to load levels');
    }
  }

  Future<void> _getCompletedLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      completedLevel = prefs.getInt('completedLevel') ?? 0;
    });
  }

  Future<void> _refresh() async {
    await fetchLevels();
    _getCompletedLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFF301F40),
                  Color(0xFF46244C),
                ],
              ),
            ),
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
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
                        bool isLevelEnabled =
                            int.parse(level['level']!) == 1 ||
                                int.parse(level['level']!) <=
                                    completedLevel + 1;

                        return buildLevelContainer(
                          context,
                          'Level ${level['level']}',
                          getIconPath(int.parse(level['level']!)),
                          () {
                            if (isLevelEnabled) {
                              Get.to(() => ExercisePage(
                                  levelId: int.parse(level['id']!)));
                            }
                          },
                          isLevelEnabled ? Colors.white : Colors.black,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black,
              child: const Center(
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
      String? imagePath, VoidCallback onPressed, Color levelColor) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 45),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: levelColor,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                level,
                style: const TextStyle(
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
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
