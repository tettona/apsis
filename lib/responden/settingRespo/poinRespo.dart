import 'package:flutter/material.dart';

class poinRespo extends StatelessWidget {
  const poinRespo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 237, 235, 1),
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Color.fromRGBO(229, 225, 223, 1),
        title: Text(
          "POIN",
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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 240,
                      height: 100,
                      padding: EdgeInsets.fromLTRB(15, 12, 15, 5),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(229, 229, 229, 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Detail poin",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              )),
                          Text("○ Rp. 100 / 1 Poin",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text("*Penukaran bisa melalui Gopay, Dana, dan Ovo",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6)))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 31,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(246, 190, 44, 1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Align(
                              alignment: Alignment(0, 0),
                              child: Text(
                                "POIN 35",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )),
                        ),
                        Container(
                          width: 70,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(171, 128, 15, 1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(25))),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Tukar",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment(-0.85, 0),
                child: Text(
                  "RIWAYAT",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text("10 agustus 2023",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 12),
                  width: 365,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                          alignment: Alignment(-0.7, -0.4),
                          child: Text(
                            "Perkuliahan",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                      Align(
                          alignment: Alignment(-0.7, 0.1),
                          child: Text(
                            "3 PERTANYAAN",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5)),
                          )),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            width: 92,
                            height: 22,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(246, 190, 44, 1),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "10 POIN",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ))),
                      ),
                      Align(
                          alignment: Alignment(0.93, 0),
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.black.withOpacity(0.5),
                            size: 40,
                          )),
                    ],
                  ),
                ),
                // layer ke 2
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text("6 agustus 2023",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  width: 365,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                          alignment: Alignment(-0.7, -0.4),
                          child: Text(
                            "Perkuliahan",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                      Align(
                          alignment: Alignment(-0.7, 0.1),
                          child: Text(
                            "3 PERTANYAAN",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5)),
                          )),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            width: 92,
                            height: 22,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(246, 190, 44, 1),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "10 POIN",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ))),
                      ),
                      Align(
                          alignment: Alignment(0.93, 0),
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.black.withOpacity(0.5),
                            size: 40,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
