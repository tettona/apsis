import 'dart:convert';

import 'package:apsis_main/login/responden/loginRespo.dart';
import 'package:apsis_main/responden/history/historyCard.dart';
import 'package:apsis_main/responden/model/survei.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class historyRespo extends StatefulWidget {
  const historyRespo({super.key});

  @override
  State<historyRespo> createState() => _historyRespoState();
}

class _historyRespoState extends State<historyRespo> {
  late String _username;
  late int idResponden; // Sesuaikan tipe data dengan kebutuhan
  late int poin_responden;

  late Future<SharedPreferences> _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
    getUserName();
  }

// Function to log out the user
  void _logout(BuildContext context) async {
    // Show a confirmation dialog
    bool confirmLogout = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          backgroundColor: Color.fromRGBO(248, 248, 248, 1),
          title: Text('Konfirmasi Keluar'),
          content: Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(232, 232, 232, 1))),
              onPressed: () {
                // Jika pengguna memilih "Ya", set nilai true
                Navigator.of(context).pop(true);
              },
              child: Text('Ya', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromRGBO(232, 232, 232, 1))),
              onPressed: () {
                // Jika pengguna memilih "Tidak", set nilai false
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Tidak',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
    // Jika pengguna mengkonfirmasi keluar, hapus data login dan navigasikan ke halaman login
    if (confirmLogout == true) {
      final SharedPreferences prefs = await _prefs;
      prefs.remove('id_responden');
      prefs.remove('username');
      prefs.remove('poin_responden');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => loginRespo()),
      );
    }
  }

// Function to get user data from SharedPreferences
  getUserName() async {
    final SharedPreferences prefs = await _prefs;
    Map<String, dynamic> userData = {
      'id_responden': prefs.getInt('id_responden') ?? 0,
      'username': prefs.getString('username') ?? '',
      'poin_responden': prefs.getInt('poin_responden') ?? 0,
      // Add other user data if needed
    };

    // Initialize idResponden with the value from SharedPreferences
    setState(() {
      _username = userData['username'];
      idResponden = userData['id_responden'];
      poin_responden = userData['poin_responden'];
    });

    // Save user data in shared_preferences
    await prefs.setInt('id_responden', userData['id_responden']);
    await prefs.setString('username', userData['username']);
    await prefs.setInt('poin_responden', userData['poin_responden']);
    // Save other user data if needed

    // If you need to access this data on other pages, you can pass this data to those pages.
  }

  // method restApi
  Future getApiApsis() async {
    final SharedPreferences prefs = await _prefs;
    final _idResponden = prefs.getInt('id_responden');
    final String url = 'http://10.0.2.2:8000/api/riwayat/$_idResponden';
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(241, 237, 235, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(229, 225, 223, 1),
          title: Text(
            "RIWAYAT",
            style: TextStyle(color: Colors.black, letterSpacing: 1),
          ),
          actions: [
            IconButton(
                onPressed: () => _logout(context),
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ))
          ],
        ),
        body: FutureBuilder(
            future: getApiApsis(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                List<Survei> surveiList = (snapshot.data['data'] as List)
                    .map((data) => Survei.fromJson(data))
                    .toList();
                int totalPoin = surveiList.fold(0,
                    (previousValue, element) => previousValue + element.poin);
                return Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 0, 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 230,
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
                                    Text(
                                        "*Penukaran bisa melalui Gopay, Dana, dan Ovo",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.6)))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 31,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      shape: ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(70),
                                              topLeft: Radius.circular(70))),
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          margin: EdgeInsets.fromLTRB(
                                              10, 0, 10, 10),
                                          padding: EdgeInsets.all(30),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Tukar Poin',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 30),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  width: 100,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          246, 190, 44, 1),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20))),
                                                  child: Align(
                                                      alignment:
                                                          Alignment(0, 0),
                                                      child: Text(
                                                        "POIN " +
                                                            poin_responden
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 15, 5, 15),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    color: Color.fromRGBO(
                                                        229, 229, 229, 1)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Detail Poin",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "○ Rp.100 /1 Poin",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Penukaran bisa melalui Gopay, Dana, dan Ovo",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Text("Jumlah Tukar"),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: 160,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  Colors.red,
                                                                  Color
                                                                      .fromRGBO(
                                                                          232,
                                                                          173,
                                                                          19,
                                                                          1)
                                                                ],
                                                                transform:
                                                                    GradientRotation(
                                                                        4),
                                                                begin: Alignment
                                                                    .bottomLeft,
                                                                end: Alignment
                                                                    .topRight),
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20))),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(6),
                                                              child: Image(
                                                                  image: AssetImage(
                                                                      "assets/images/logoapsis.png"),
                                                                  height: 40),
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Dapatkan saldo",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "Rp.5.000",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 160,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                            color:
                                                                Color.fromRGBO(
                                                                    229,
                                                                    229,
                                                                    229,
                                                                    1)),
                                                        child: Align(
                                                          alignment: Alignment(
                                                              -0.75, 0),
                                                          child: Text(
                                                            "50 POIN",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: 160,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  Colors.red,
                                                                  Color
                                                                      .fromRGBO(
                                                                          232,
                                                                          173,
                                                                          19,
                                                                          1)
                                                                ],
                                                                transform:
                                                                    GradientRotation(
                                                                        4),
                                                                begin: Alignment
                                                                    .bottomLeft,
                                                                end: Alignment
                                                                    .topRight),
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20))),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(6),
                                                              child: Image(
                                                                  image: AssetImage(
                                                                      "assets/images/logoapsis.png"),
                                                                  height: 40),
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Dapatkan saldo",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Text(
                                                                  "Rp.10.000",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 160,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                            color:
                                                                Color.fromRGBO(
                                                                    229,
                                                                    229,
                                                                    229,
                                                                    1)),
                                                        child: Align(
                                                          alignment: Alignment(
                                                              -0.75, 0),
                                                          child: Text(
                                                            "100 POIN",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                height: 55,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Color.fromRGBO(232,
                                                                173, 19, 1),
                                                        shape: ContinuousRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Tukar",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    )),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(246, 190, 44, 1),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      child: Align(
                                          alignment: Alignment(0, 0),
                                          child: Text(
                                            "POIN " + poin_responden.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          )),
                                    ),
                                    Container(
                                      width: 70,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(171, 128, 15, 1),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              bottomRight:
                                                  Radius.circular(25))),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Tukar",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment(-0.85, 0),
                          child: Text(
                            "RIWAYAT",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.64,
                      child: ListView.builder(
                          itemCount: surveiList.length,
                          itemBuilder: (context, index) {
                            return historyCard(
                                idResponden: idResponden,
                                survey: surveiList[index]);
                          }),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Text("No data");
              }
            }));
  }
}
