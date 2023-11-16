import 'package:dev_tesis/ui/components/buttons/pixel_large_bttn.dart';
import 'package:dev_tesis/ui/pages/screen_home/home_mobile.dart';
import 'package:dev_tesis/ui/pages/screen_home/home_web.dart';
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
