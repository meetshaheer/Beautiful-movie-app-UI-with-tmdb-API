import 'package:flutter/material.dart';
import 'package:tubi/Screens/home-view.dart';

void main(List<String> args) {
  runApp(const tubi());
}

class tubi extends StatelessWidget {
  const tubi({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppView(),
      title: "Tubi",
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
