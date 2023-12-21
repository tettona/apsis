import 'package:apsis_main/login/responden/loginRespo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/loginRespo',
      routes: {
        '/loginRespo': (context) => loginRespo(),
        // ... (rute lainnya)
      },
      // Pastikan untuk menambahkan onUnknownRoute jika Anda tidak mengaturnya
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Rute tidak ditemukan: ${settings.name}'),
            ),
          ),
        );
      },
    );
  }
}
