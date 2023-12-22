import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                          'Level 1',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Galindo',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.05,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            'assets/BULB.png', 
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFCDBDE7),
                  ),
                  child: Image.asset(
                    'assets/Prambanan.jpeg',
                    width: 330,
                    height: 300,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFFCDBDE7),
                  ),
                  child: Text(
                    'Gambar di atas adalah candi ...',
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
                  margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  padding: EdgeInsets.only(bottom: 130),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 0),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFCDBDE7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: '_R______N',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10), 
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
                          // Fungsi yang akan dijalankan saat tombol ditekan
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
}
