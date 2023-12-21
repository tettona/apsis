import 'package:flutter/material.dart';

class AlertApsis extends StatefulWidget {
  const AlertApsis({Key? key}) : super(key: key);

  @override
  _AlertApsisState createState() => _AlertApsisState();
}

class _AlertApsisState extends State<AlertApsis> {
  bool _isDialogVisible = true;

  @override
  void initState() {
    super.initState();
    // Memulai timer ketika widget diinisialisasi
    startTimer();
  }

  // Metode untuk memulai timer
  void startTimer() {
    Future.delayed(Duration(seconds: 2), () {
      if (_isDialogVisible) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(60)),
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
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            SizedBox(
              height: 20,
            ),
            Text(
              "Survei telah dikerjakan",
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
  }

  @override
  void dispose() {
    // Set nilai _isDialogVisible menjadi false saat widget dihapus
    _isDialogVisible = false;
    super.dispose();
  }
}
