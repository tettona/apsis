import 'dart:convert';

import 'package:apsis_main/responden/mainRespo.dart';
import 'package:apsis_main/responden/model/survei.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class soalRespo extends StatefulWidget {
  const soalRespo({
    Key? key,
    required this.id_responden,
    required this.survey,
  }) : super(key: key);
  final Survei survey;
  final int id_responden;
  @override
  State<soalRespo> createState() => _soalRespoState();
}

class _soalRespoState extends State<soalRespo> {
  late Future<SharedPreferences> _prefs;

  Future<void> _updatePoinUser(int poinBaru) async {
    final SharedPreferences prefs = await _prefs;

    int? poinAwal = await prefs.getInt('poin') ?? 0;
    int poinAkhir;

    poinAkhir = poinAwal + poinBaru;
    await prefs.setInt("poin", poinAkhir);
  }

  Future _simpanSurveiTerjawab() async {
    final String url = 'http://10.0.2.2:8000/api/surveiTerjawab';
    Map<String, dynamic> data = {
      'id_survei': widget.survey.id_survei,
      'id_responden': widget.id_responden,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Berhasil menyimpan hasil survei: ${response.body}');
        // Tambahkan logika atau navigasi lain jika diperlukan setelah penyimpanan berhasil
      } else {
        print(
            'Gagal menyimpan hasil survei. Status: ${response.statusCode}, Body: ${response.body}');
        // Tambahkan logika penanganan kesalahan jika diperlukan
      }
    } catch (error) {
      print('Error: $error');
      // Tambahkan logika penanganan kesalahan jika diperlukan
    }
  }

  // Move this function outside the _simpanHasilSurvei function
  void showConfirmationDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(60)),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/iconCheck.png'),
                SizedBox(
                  height: 20,
                ),
                Text("Selesai",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Berhasil mendapatkan ${widget.survey.poin} poin",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(140, 135, 135, 1)),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _simpanHasilSurvei(List<int> jawaban) async {
    final String url = 'http://10.0.2.2:8000/api/hasilSurvei';

    // Sesuaikan dengan struktur data yang diperlukan oleh API
    Map<String, dynamic> data = {
      'id_pertanyaan': widget.survey.id_survei,
      'id_responden':
          widget.id_responden, // Langsung tetapkan nilai id_responden
      'jawaban': jawaban,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Berhasil menyimpan hasil survei: ${response.body}');
        // Tambahkan logika atau navigasi lain jika diperlukan setelah penyimpanan berhasil
      } else {
        print(
            'Gagal menyimpan hasil survei. Status: ${response.statusCode}, Body: ${response.body}');
        // Tambahkan logika penanganan kesalahan jika diperlukan
      }
    } catch (error) {
      print('Error: $error');
      // Tambahkan logika penanganan kesalahan jika diperlukan
    }
  }

  late String url;
  List<int> _values = [];
  Future? _dataFuture;

  Future<void> _initializePrefs() async {
    _prefs = SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initializePrefs();
    url = 'http://10.0.2.2:8000/api/pertanyaan/${widget.survey.id_survei}';
    _dataFuture = getApiApsis();
  }

  // method restApi
  Future getApiApsis() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 237, 235, 1),
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          "SURVEY",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(229, 225, 223, 1),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    Color.fromRGBO(246, 190, 44, 1), // Background Color
              ),
              child: const Text("Selesai"),
              onPressed: () {
                if (_values.contains(0)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: const Text(
                        'Pilih salah satu opsi sebelum menekan tombol Selesai.',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else {
                  _simpanSurveiTerjawab();
                  _simpanHasilSurvei(_values);
                  _updatePoinUser(widget.survey.poin);
                  // Show the AlertDialog here
                  showConfirmationDialog(context);

                  // Kembali ke homeRespo.dart dan hapus semua halaman di atasnya
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => mainRespo(),
                    ),
                    (route) =>
                        false, // Hapus semua halaman di atas homeRespo.dart
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: WillPopScope(
          onWillPop: () async {
            // Menampilkan konfirmasi alert
            bool confirm = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
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
                          child:
                              Text('Ya', style: TextStyle(color: Colors.red)),
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
                    ));
            return confirm ??
                false; // Kembali true jika dikonfirmasi, false jika dibatalkan
          },
          child: FutureBuilder(
            future: _dataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (context, index) {
                      if (_values.length <= index) {
                        _values.add(0); // Inisialisasi nilai default
                      }
                      return Card(
                        margin: EdgeInsets.all(22),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 10, 7),
                              child: Text(
                                snapshot.data['data'][index]['pertanyaan']
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            RadioListTile(
                              value: 1,
                              groupValue: _values[index],
                              title:
                                  Text(snapshot.data['data'][index]['opsi_1']),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _values[index] = value;
                                  });
                                }
                              },
                            ),
                            RadioListTile(
                              value: 2,
                              groupValue: _values[index],
                              title:
                                  Text(snapshot.data['data'][index]['opsi_2']),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _values[index] = value;
                                  });
                                }
                              },
                            ),
                            RadioListTile(
                              value: 3,
                              groupValue: _values[index],
                              title:
                                  Text(snapshot.data['data'][index]['opsi_3']),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _values[index] = value;
                                  });
                                }
                              },
                            ),
                            RadioListTile(
                              value: 4,
                              groupValue: _values[index],
                              title:
                                  Text(snapshot.data['data'][index]['opsi_4']),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _values[index] = value;
                                  });
                                }
                              },
                            ),
                            RadioListTile(
                              value: 5,
                              groupValue: _values[index],
                              title:
                                  Text(snapshot.data['data'][index]['opsi_5']),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _values[index] = value;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Text("No data");
              }
            },
          )),
    );
  }
}
