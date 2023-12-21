import 'dart:convert';

import 'package:apsis_main/login/responden/loginRespo.dart';
import 'package:apsis_main/login/services/auth_services.dart';
import 'package:apsis_main/login/services/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class registerRespo extends StatefulWidget {
  const registerRespo({super.key});

  @override
  State<registerRespo> createState() => _registerRespoState();
}

class _registerRespoState extends State<registerRespo> {
  String _email = '';
  String _password = '';
  String _username = '';
  String _konfirm = '';
  bool _isPasswordVisible = false;

  bool isPasswordStrong(String password) {
    // Minimal 8 karakter, mengandung angka, huruf besar, huruf kecil, dan simbol
    return password.length >= 8 &&
        password.contains(RegExp(r'\d')) &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  createAccountPressed() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);

    if (emailValid) {
      if (_password == _konfirm) {
        if (isPasswordStrong(_password)) {
          // Periksa apakah kata sandi cocok dan cukup kuat
          http.Response response =
              await AuthServices.register(_username, _email, _password);
          Map responseMap = jsonDecode(response.body);
          if (response.statusCode == 200) {
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
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
                        Text("Berhasil",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Berhasil membuat akun baru",
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
          } else {
            errorSnackBar(context, responseMap.values.first[0]);
          }
        } else {
          errorSnackBar(context,
              'Password harus mengandung angka, huruf besar, huruf kecil, dan simbol.');
        }
      } else {
        errorSnackBar(context, 'Kata sandi tidak cocok');
      }
    } else {
      errorSnackBar(context, 'Email tidak berlaku');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(217, 144, 4, 1),
      body: Center(
          child: ListView(
        padding: EdgeInsets.fromLTRB(25, 30, 25, 10),
        children: [
          Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Image(image: AssetImage("assets/images/logoapsis.png"))),
          SizedBox(
            height: 30,
          ),
          TextField(
            decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.account_circle_outlined),
                prefixIconColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                fillColor: Color.fromRGBO(248, 234, 208, 1),
                hintText: 'Username'),
            maxLines: 1,
            onChanged: (value) {
              _username = value;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.alternate_email),
                prefixIconColor: Colors.black,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black, // Set the icon color as needed
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
              hintText: 'Kata Sandi',
            ),
            maxLines: 1,
            obscureText: !_isPasswordVisible, // Toggle password visibility
            onChanged: (value) {
              _password = value;
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black, // Set the icon color as needed
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
              hintText: 'Ketik Ulang Kata Sandi',
            ),
            maxLines: 1,
            obscureText: !_isPasswordVisible, // Toggle password visibility
            onChanged: (value) {
              _konfirm = value;
            },
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 55,
            child: ElevatedButton(
              onPressed: () => createAccountPressed(),
              child: Text(
                "Buat Akun",
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
          SizedBox(
            height: 20,
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
                      builder: (context) => const loginRespo(),
                    ));
              },
              child: Text(
                "Masuk",
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
