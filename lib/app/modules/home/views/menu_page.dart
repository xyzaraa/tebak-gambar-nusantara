import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tebak_gambar_nusantara/app/modules/home/views/level_page.dart';

void main() {
  runApp(GetMaterialApp(
    home: MenuPage(),
  ));
}

class MenuPage extends StatelessWidget {
  final MenuController menuController = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/menu-background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 230.0, left: 10.0), // Sesuaikan dengan kebutuhan Anda
                    child: Text(
                      'Tebak \nGambar Nusantara',
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Galindo',
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 236, 227, 227),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Jelajahi Pengetahuan Nusantara dengan game tebak gambar seru! Pecahkan teka-teki visual dan temukan keajaiban budaya Indonesia.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Galindo',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(
                                LevelPage()); // Navigate to the next screen using GetX
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: Text(
                            'START',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Galindo',
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
