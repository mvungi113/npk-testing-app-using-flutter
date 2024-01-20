import 'package:flutter/material.dart';
import 'package:kilimo/authentication/loginpage.dart';
import 'package:kilimo/widget/drawer.dart';
import 'package:kilimo/widget/pages/home.dart';

import 'authentication.dart';

class registerpage extends StatelessWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    String? email;
    String? password;
    final pass = new TextEditingController();

    return SafeArea(
      top: false,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 17, 55, 38),
          title: Text(
            'Andikisha Akaunti Mpya',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        drawer: SideNav(),
        backgroundColor: Color.fromARGB(255, 195, 237, 218),
        body: ListView(
          children: [
            SizedBox(height: 70),
            Form(
              key: _formKey,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 177, 203, 178),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            icon: Icon(Icons.email),
                            enabledBorder: InputBorder.none,
                          ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tafadhali ingiza maandishi';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        email = val;
                      },
                        ),
                      ),
                    ),
                  
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 177, 203, 178),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Neno Siri',
                            icon: Icon(Icons.lock_clock_rounded),
                            enabledBorder: InputBorder.none,
                          ),
                           validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tafadhali ingiza maandishi';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        password = val;
                      },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 17, 55, 38),
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: () {
                              if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            Authentication()
                                .signup(email: email!, password: password!)
                                .then((result) {
                              if (result == null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserHomePage()));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(result),
                                ));
                              }
                            });
                          }
                          },
                          child: Text('SAJILI',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
