import 'package:apsis_main/responden/history/historyRespo.dart';
import 'package:apsis_main/responden/homeRespo.dart';
import 'package:apsis_main/responden/settingRespo/settingRespo.dart';
import 'package:flutter/material.dart';

class mainRespo extends StatefulWidget {
  const mainRespo({super.key});

  @override
  State<mainRespo> createState() => _mainRespoState();
}

class _mainRespoState extends State<mainRespo> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    homeRespo(),
    historyRespo(),
    settingRespo(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color.fromRGBO(241, 237, 235, 1),
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.black,
            backgroundColor: Color.fromRGBO(217, 144, 4, 1),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Rumah"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: "Riwayat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Pengaturan")
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTap,
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          )),
    );
  }
}
