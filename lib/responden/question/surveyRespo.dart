import 'package:apsis_main/responden/model/survei.dart';
import 'package:apsis_main/responden/question/soalRespo.dart';
import 'package:flutter/material.dart';

class surveyRespo extends StatelessWidget {
  final Survei survey;
  final int idResponden; // tambahkan deklarasi id_responden
  const surveyRespo({Key? key, required this.survey, required this.idResponden})
      : super(key: key);

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
      body: Container(
          margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
          padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(survey.judul,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(survey.pertanyaan.toString() + " PERTANYAAN",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.6))),
                  SizedBox(
                    height: 10,
                  ),
                  Text(survey.deskripsi,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.wallet),
                      SizedBox(
                        width: 8,
                      ),
                      Text(survey.poin.toString() + " POIN",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment(0, 0.75),
                child: Container(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Color.fromRGBO(246, 190, 44, 1)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => soalRespo(
                                  survey: survey,
                                  id_responden:
                                      idResponden, // Ganti dengan data pengguna yang sesuai
                                ),
                              ));
                        },
                        child: Text("Kerjakan"))),
              )
            ],
          )),
    );
  }
}
