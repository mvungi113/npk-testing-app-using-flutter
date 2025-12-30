import 'package:flutter/material.dart';
import 'package:kilimo/widget/drawer.dart';
import 'package:kilimo/widget/pages/dashboard.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      right: false,
      bottom: false,
      left: false,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 177, 203, 178),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 17, 55, 38),
          title: Text(' Kilimo App'),
        ),
        drawer: SideNav(),
        body: MyDashboard(),
      ),
    );
  }
}
