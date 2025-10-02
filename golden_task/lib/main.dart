import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'instagram_dashboard.dart';

void main() {
  runApp(const InstagramDashboardApp());
}

class InstagramDashboardApp extends StatelessWidget {
  const InstagramDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: DashboardPage(),
    );
  }
}