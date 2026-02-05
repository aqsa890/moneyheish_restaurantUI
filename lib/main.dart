import 'package:flutter/material.dart';
import 'ui/theme.dart';
import 'ui/pages/heist_menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bella Ciao Bistro',
      debugShowCheckedModeBanner: false,
      theme: HeistTheme.theme(),
      home: const HeistMenuPage(),
    );
  }
}
