import 'package:flutter/material.dart';
import '../widgets/app_sidebar.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const BaseLayout({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: const AppSidebar(), // 🔥 Sidebar otomatis dimuat
      body: child, // layar hanya mengirim konten
    );
  }
}
