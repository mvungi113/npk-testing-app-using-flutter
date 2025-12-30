import 'package:flutter/material.dart';
import 'package:kilimo/data/testresult.dart';
import 'package:kilimo/data/view_allresult.dart';

class MyDashboard extends StatelessWidget {
  const MyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: Image(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1587884934488-2c4044f0596c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHNvaWx8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AllResult()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_box_rounded,
                          color: Color.fromRGBO(10, 196, 63, 1),
                          size: 50.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Vipimo Vyote \nVya Udongo',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ))),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 28, 210, 134),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ResultView()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.read_more,
                      color: Colors.amber,
                      size: 50.0,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Kipimo Cha\n Udongo',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
