import 'dart:convert';

import 'package:apsis_main/login/responden/registerRespo.dart';
import 'package:apsis_main/login/services/auth_services.dart';
import 'package:apsis_main/login/services/global.dart';
import 'package:apsis_main/responden/mainRespo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class loginRespo extends StatefulWidget {
  const loginRespo({super.key});

  @override
  State<loginRespo> createState() => _loginRespoState();
}

class _loginRespoState extends State<loginRespo> {
  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username',
            userData['user']['username']); // Simpan informasi pengguna
        prefs.setInt('id_responden',
            userData['user']['id_responden']); // Simpan ID pengguna
        prefs.setInt('poin', userData['user']['poin']);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const mainRespo(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'Masukkan email dan password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 144, 4, 1),
      body: Center(
          child: ListView(
        padding: EdgeInsets.fromLTRB(25, 50, 25, 10),
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 100),
              padding: EdgeInsets.only(top: 50, bottom: 20),
              child: Image(image: AssetImage("assets/images/logoapsis.png"))),
          TextField(
            decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.account_circle_outlined),
                prefixIconColor: Colors.black,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                fillColor: Color.fromRGBO(248, 234, 208, 1),
                hintText: 'Email'),
            maxLines: 1,
            onChanged: (value) {
              _email = value;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              filled: true,
              prefixIcon: Icon(Icons.key),
              prefixIconColor: Colors.black,
              suffixIconColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              fillColor: Color.fromRGBO(248, 234, 208, 1),
              hintText: 'Kata sandi',
            ),
            maxLines: 1,
            obscureText:
                !_isPasswordVisible, // Use obscureText with the toggle state
            onChanged: (value) {
              _password = value;
            },
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 55,
            child: ElevatedButton(
              onPressed: () => loginPressed(),
              child: Text(
                "Masuk",
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
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 4, 25, 20),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
                "--------------------------- Atau ---------------------------",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.white)),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const registerRespo(),
                    ));
              },
              child: Text(
                "Buat Akun",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(235, 188, 100, 1),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
            ),
          ),
        ],
      )),
    );
  }
}
