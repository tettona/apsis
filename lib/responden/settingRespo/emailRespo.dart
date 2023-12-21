import 'package:flutter/material.dart';

class emailRespo extends StatelessWidget {
  const emailRespo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 237, 235, 1),
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Color.fromRGBO(229, 225, 223, 1),
        title: Text(
          "EMAIL",
          style: TextStyle(color: Colors.black),
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
        margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 350,
                  height: 200,
                  child: CircleAvatar(
                    child: Icon(
                      Icons.alternate_email,
                      size: 130,
                      color: Color.fromRGBO(217, 144, 4, 1),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text(
                  "EMAIL",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 70,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  fillColor: Color.fromRGBO(248, 234, 208, 1),
                  filled: true,
                  hintText: "SHASA_ZHANIA@GMAIL.COM",
                  hintStyle: TextStyle(fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(22))),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 350,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Ubah",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(188, 122, 0, 1),
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
