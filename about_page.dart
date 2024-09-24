import 'package:flutter/material.dart';
import 'package:login3/sidemenu.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
        backgroundColor: Colors.lightBlue,
      ),
      body: const Center(
        child: Text(
          'Ini adalah halaman about',
          style: TextStyle(
            fontSize: 18, // Menyesuaikan ukuran font
            color: Colors.black,
          ),
        ),
      ),
      drawer: const Sidemenu(),
    );
  }
}
