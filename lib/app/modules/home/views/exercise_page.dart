import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tebak_gambar_nusantara/app/modules/home/views/level_page.dart';

class ExercisePage extends StatefulWidget {
  final int levelId;

  ExercisePage({required this.levelId});

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int maxAttempts = 4;
  int attempts = 0;

  Future<Map<String, dynamic>> fetchExerciseData() async {
    final response = await http.get(
        Uri.parse('https://db.nyanhosting.id/game/api/?id=${widget.levelId}'));

    if (response.statusCode == 200) {
      return json.decode(response.body)[0];
    } else {
      throw Exception('Failed to load exercise data');
    }
  }

  Future<void> _updateLevelProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('completedLevel', widget.levelId);
  }

  Future<int> _getCompletedLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('completedLevel') ?? 0;
  }

  Future<int> _getStarRating(int attempts) async {
    if (attempts <= 2) {
      return 3;
    } else if (attempts <= 4) {
      return 2;
    } else {
      return 1;
    }
  }

  Future<void> _resetMaxAttempts() async {
    setState(() {
      maxAttempts = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchExerciseData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          Map<String, dynamic> exerciseData = snapshot.data!;
          return MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: Container(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 80),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Level ${exerciseData['level']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Galindo',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.05,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFCDBDE7),
                        ),
                        child: Image.network(
                          exerciseData['file'],
                          width: 330,
                          height: 300,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFCDBDE7),
                        ),
                        child: Text(
                          exerciseData['description'],
                          style: const TextStyle(
                            color: Color(0xFF1D1131),
                            fontFamily: 'Galindo',
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 10),
                        padding: const EdgeInsets.only(bottom: 130),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: TextField(
                                  onChanged: (value) {
                                    exerciseData['userAnswer'] = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFCDBDE7),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: 'Masukkan jawaban...',
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  style: const TextStyle(
                                    color: Color(0xFF1D1131),
                                    fontFamily: 'Galindo',
                                    fontSize: 24,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () async {
                                if (exerciseData['userAnswer']
                                        .toLowerCase() ==
                                    exerciseData['answer'].toLowerCase()) {
                                  await _updateLevelProgress();
                                  int completedLevel =
                                      await _getCompletedLevel();
                                  int starRating =
                                      await _getStarRating(attempts);

                                  _resetMaxAttempts();

                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Jawaban Benar!'),
                                        content: Column(
                                          children: [
                                            const Text(
                                              'Selamat! Jawaban Anda benar.',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List.generate(
                                                starRating,
                                                (index) => const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ulangi'),
                                          ),
                                          if (completedLevel >=
                                              widget.levelId)
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ExercisePage(
                                                            levelId: widget
                                                                    .levelId +
                                                                1),
                                                  ),
                                                );
                                              },
                                              child: const Text('Next Level'),
                                            ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LevelPage(),
                                                ),
                                              );
                                            },
                                            child: const Text('Home'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  attempts++;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Jawaban Salah'),
                                        content: const Text(
                                            'Maaf, jawaban Anda salah. Silakan coba lagi.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ulangi'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE3D8B5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Cek',
                                style: TextStyle(
                                  color: Color(0xFF1D1131),
                                  fontFamily: 'Galindo',
                                  fontSize: 32,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}