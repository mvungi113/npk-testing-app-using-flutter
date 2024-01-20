import 'package:flutter/material.dart';
import 'package:kilimo/authentication/google.dart';
import 'package:kilimo/authentication/loginpage.dart';
import 'package:kilimo/authentication/register.dart';
import 'package:kilimo/widget/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        right: false,
        left: false,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 17, 55, 38),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'RUTUBA YA UDONGO NPK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.zero,
               child: Image(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1587884934488-2c4044f0596c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHNvaWx8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
                  fit: BoxFit.cover,
                ), 
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(241, 54, 102, 179),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginpage()));
                      },
                      icon: Icon(
                        Icons.email,
                        color: Colors.amber,
                      ),
                      label: Text(
                        'Ingia Kilimo App',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
                //
              ),
              SizedBox(
                height: 10,
              ),
              
            ],
          ),
        ));
  }
}
