import 'package:dev_tesis/ui/pages/screen_home/home_mobile_screen.dart';
import 'package:dev_tesis/ui/pages/screen_home/home_web_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth >= 900) {
        // Versión de escritorio
        return const HomeWeb();
      } else {
        // Versión móvil
        return const HomeMobile();
      }
    });
  }
}
