import 'package:apsis_main/responden/history/historyRespo.dart';
import 'package:apsis_main/responden/settingRespo/emailRespo.dart';
import 'package:apsis_main/responden/settingRespo/passwordRespo.dart';
import 'package:apsis_main/responden/settingRespo/userRespo.dart';
import 'package:flutter/material.dart';

class settingRespo extends StatelessWidget {
  const settingRespo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 237, 235, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(229, 225, 223, 1),
        title: Text(
          "PENGATURAN",
          style: TextStyle(color: Colors.black, letterSpacing: 1),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        width: 420,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const userRespo(),
                    ));
              },
              child: Container(
                  width: 380,
                  height: 52,
                  color: Color.fromRGBO(241, 237, 235, 1),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                          alignment: Alignment(-0.92, 0),
                          child: Icon(
                            Icons.account_circle_outlined,
                            size: 30,
                            color: Color.fromRGBO(217, 144, 4, 1),
                          )),
                      Align(
                          alignment: Alignment(-0.4, 0),
                          child: Text(
                            "Username",
                            style: TextStyle(fontSize: 17),
                          )),
                      Align(
                          alignment: Alignment(0.95, 0),
                          child: Icon(
                            Icons.navigate_next,
                            size: 30,
                            color: Colors.black.withOpacity(0.5),
                          )),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const emailRespo(),
                    ));
              },
              child: Container(
                  width: 380,
                  height: 52,
                  color: Color.fromRGBO(241, 237, 235, 1),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                          alignment: Alignment(-0.92, 0),
                          child: Icon(
                            Icons.alternate_email,
                            size: 30,
                            color: Color.fromRGBO(217, 144, 4, 1),
                          )),
                      Align(
                          alignment: Alignment(-0.45, 0),
                          child: Text(
                            "Email",
                            style: TextStyle(fontSize: 17),
                          )),
                      Align(
                          alignment: Alignment(0.95, 0),
                          child: Icon(
                            Icons.navigate_next,
                            size: 30,
                            color: Colors.black.withOpacity(0.5),
                          )),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const passwordRespo(),
                    ));
              },
              child: Container(
                  width: 380,
                  height: 52,
                  color: Color.fromRGBO(241, 237, 235, 1),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                          alignment: Alignment(-0.92, 0),
                          child: Icon(
                            Icons.key,
                            size: 30,
                            color: Color.fromRGBO(217, 144, 4, 1),
                          )),
                      Align(
                          alignment: Alignment(-0.4, 0),
                          child: Text(
                            "Kata Sandi",
                            style: TextStyle(fontSize: 17),
                          )),
                      Align(
                          alignment: Alignment(0.95, 0),
                          child: Icon(
                            Icons.navigate_next,
                            size: 30,
                            color: Colors.black.withOpacity(0.5),
                          )),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const historyRespo(),
                    ));
              },
              child: Container(
                  width: 380,
                  height: 52,
                  color: Color.fromRGBO(241, 237, 235, 1),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                          alignment: Alignment(-0.92, 0),
                          child: Icon(
                            Icons.wallet,
                            size: 30,
                            color: Color.fromRGBO(217, 144, 4, 1),
                          )),
                      Align(
                          alignment: Alignment(-0.48, 0),
                          child: Text(
                            "Poin",
                            style: TextStyle(fontSize: 17),
                          )),
                      Align(
                          alignment: Alignment(0.95, 0),
                          child: Icon(
                            Icons.navigate_next,
                            size: 30,
                            color: Colors.black.withOpacity(0.5),
                          )),
                    ],
                  )),
            ),
            Container(
                width: 380,
                height: 52,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Align(
                        alignment: Alignment(-0.92, 0),
                        child: Icon(
                          Icons.restore_from_trash,
                          size: 30,
                          color: Color.fromRGBO(217, 144, 4, 1),
                        )),
                    Align(
                        alignment: Alignment(-0.35, 0),
                        child: Text(
                          "Hapus Akun",
                          style: TextStyle(fontSize: 17),
                        )),
                    Align(
                        alignment: Alignment(0.95, 0),
                        child: Icon(
                          Icons.navigate_next,
                          size: 30,
                          color: Colors.black.withOpacity(0.5),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
