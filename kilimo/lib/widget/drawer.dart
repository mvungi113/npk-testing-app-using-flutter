import 'package:flutter/material.dart';
import 'package:kilimo/authentication/authentication.dart';
import 'package:kilimo/authentication/register.dart';
import 'package:kilimo/data/testresult.dart';
import 'package:kilimo/data/view_allresult.dart';
import 'package:kilimo/main.dart';
import 'package:kilimo/widget/pages/home.dart';

class SideNav extends StatelessWidget {
  const SideNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFB1CBB2),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Color.fromARGB(255, 17, 55, 38),
              child: DrawerHeader(
                  child: Container(
                padding: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image(
                        image: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/128/1177/1177568.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    )),
                    Text(
                      'ROGASIAN MVUNGI',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'test@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserHomePage()));
                },
                child: Text('Nyumbani'),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResultView()));
                },
                child: Text('Vipimo Vya Muda Huu'),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllResult()));
                },
                child: Text('Vipimo Vya Zamani'),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                child: Text('Sajili'),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: ElevatedButton(
                    onPressed: () {
                      final navigator = Navigator.of(context);
                      Authentication().signOut().then((_) =>
                          navigator.pushReplacement(MaterialPageRoute(
                              builder: (context) => const MyApp())));
                    },
                    child: Text(
                      'Ondoka',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
