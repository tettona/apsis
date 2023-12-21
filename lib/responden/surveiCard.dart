import 'package:apsis_main/responden/model/survei.dart';
import 'package:apsis_main/responden/question/surveyRespo.dart';
import 'package:flutter/material.dart';

class SurveiCard extends StatelessWidget {
  final int idResponden;
  final Survei survey;

  const SurveiCard({
    required this.idResponden,
    required this.survey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => surveyRespo(
                  survey: survey,
                  idResponden: idResponden,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 15),
            width: 365,
            height: 120,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Align(
                  alignment: Alignment(-0.7, -0.4),
                  child: Text(
                    survey.judul,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-0.7, 0.1),
                  child: Text(
                    survey.pertanyaan.toString() + " PERTANYAAN",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 92,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(246, 190, 44, 1),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        survey.poin.toString() + " POIN",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.93, 0),
                  child: Icon(
                    Icons.navigate_next,
                    color: Colors.black.withOpacity(0.5),
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
