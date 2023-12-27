import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExercisePage extends StatelessWidget {
  final int levelId;

  ExercisePage({required this.levelId});

  Future<Map<String, dynamic>> fetchExerciseData() async {
    final response = await http.get(
        Uri.parse('https://db.nyanhosting.id/game/api/?id=$levelId'));

    if (response.statusCode == 200) {
      return json.decode(response.body)[0];
    } else {
      throw Exception('Failed to load exercise data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchExerciseData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
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
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Level ${exerciseData['level']}',
                                style: TextStyle(
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
                        margin: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFCDBDE7),
                        ),
                        child: Image.network(
                          exerciseData['file'],
                          width: 330,
                          height: 300,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFCDBDE7),
                        ),
                        child: Text(
                          exerciseData['description'],
                          style: TextStyle(
                            color: Color(0xFF1D1131),
                            fontFamily: 'Galindo',
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 25, horizontal: 10),
                        padding: EdgeInsets.only(bottom: 130),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 0),
                                child: TextField(
                                  onChanged: (value) {
                                    exerciseData['userAnswer'] = value;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFCDBDE7),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    hintText: 'Masukkan jawaban...',
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  style: TextStyle(
                                    color: Color(0xFF1D1131),
                                    fontFamily: 'Galindo',
                                    fontSize: 24,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                if (exerciseData['userAnswer'].toLowerCase() ==
                                    exerciseData['answer'].toLowerCase()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Jawaban Benar!'),
                                        content: Text(
                                            'Selamat! Jawaban Anda benar.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cek'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Jawaban Salah'),
                                        content: Text(
                                            'Maaf, jawaban Anda salah. Silakan coba lagi.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cek'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFE3D8B5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
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
