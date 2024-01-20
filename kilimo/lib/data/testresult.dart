import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kilimo/authentication/authentication.dart';
import 'package:kilimo/data/data.dart';
import 'package:kilimo/main.dart';
import 'package:kilimo/widget/drawer.dart';

class resultview extends StatefulWidget {
  const resultview({Key? key}) : super(key: key);

  @override
  State<resultview> createState() => _resultviewState();
}

class _resultviewState extends State<resultview> {
  bool error = false, dataloaded = false;
  var data;
  String dataurl = "http://192.168.43.23/soil-npk-test/json.php";
  // php script url

  @override
  void initState() {
    loaddata();
    // call loading of data
    super.initState();
  }

  void loaddata() {
    Future.delayed(Duration.zero, () async {
      var res = await http.post(Uri.parse(dataurl));

      if (res.statusCode == 200) {
        setState(() {
          data = json.decode(res.body);
          dataloaded = true;
          // we set dataloaded to true
          // so that we can build a list only
          // on data load
        });
      } else {
        // when there is error
        setState(() {
          error = true;
        });
        //
      }
    });
    // we use Future.delay because there is async function inside it.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 243, 244, 243),
      appBar: AppBar(
        title: Text('Matokeo ya Majaribio  '),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 17, 55, 38),
      ),
      drawer: SideNav(),
      body: ListView(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          // check if the data is loaded
          // if loaded then show the data list
          child: dataloaded
              ? datalist()
              : Center(
                  // if data is not loaded then show the progress
                  child: CircularProgressIndicator(),
                ),
        ),
      ]),
    );
  }

  Widget datalist() {
    if (data['error']) {
      return Text(data['errmsg']);
      // print error message from server
    } else {
      List<NameOne> namelist = List<NameOne>.from(data['data'].map((i) {
        return NameOne.fromJSON(i);
      }));
      // prasing data list to model
      return Column(
        children: [
          Column(

              // if data is loaded then show table
              // border: TableBorder.all(width: 1, color: Colors.black),
              children: namelist.map((nameone) {
                return Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(30),
                  color: Color.fromARGB(255, 177, 203, 178),
                  ),
                  child: Column(
                  
                    children: [
                      CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 17, 55, 38),
                           child:Text(nameone.sn, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,)),

                          ),
                      SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('NITROGEN',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                        Text(nameone.potassium +'ppm',
                       style: TextStyle(
                          fontSize: 16,
                           color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                      ],
                    ),
                    SizedBox(height: 10,),

                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      Text('PHOSPHORUS',
                      style: TextStyle(
                          fontSize: 16,
                           color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                       Text(nameone.phosphorus +'ppm',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                           color: Colors.white
                        )),
                     ],
                   ),SizedBox(height: 10,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('POTASSIUM',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold, color: Colors.white
                        )),
                      Text(nameone.potassium +'ppm',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold, color: Colors.white
                        )),
                    ],
                  ),
              SizedBox(height: 10,),


                      

                    ],
                  ),
                );
          }).toList()),
          SizedBox(height: 20,),
          Container(
            child: Column(
              children: [
                Text('Vigezo Vya Uchambuzi Wa Udongo', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,),),
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        color:Color.fromARGB(255, 17, 55, 38),
                        child: Text('Ukosefu au Upunguvu', style: TextStyle(color: Colors.white, fontSize: 18),),
                      ),
                      Container(
                        width: double.infinity,
                        color:Color.fromARGB(255, 177, 203, 178),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Text('Nitrogen Chini ya 50 ppm (N < 50 ppm)', style: TextStyle(color: Colors.white, fontSize: 16),),
                            SizedBox(height: 5,),
                            Text('Phosphorus Chini ya 4 ppm (P < 4 ppm)', style: TextStyle(color: Colors.white, fontSize: 16),),
                            SizedBox(height: 5,),
                            Text('Potassium Chini ya 50 ppm (K < 50 ppm)',
                             style: TextStyle(color: Colors.white, fontSize: 16),),
                            SizedBox(height: 10,),
                        ],
                        ),
                      ),
                      

                    ],
                  ),
                ),
                SizedBox(height: 10,),

                  Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        color:Color.fromARGB(255, 17, 55, 38),
                        child: Text('Virutubisho Bora', style: TextStyle(color: Colors.white, fontSize: 18),),
                      ),
                      Container(
                        width: double.infinity,
                        color:Color.fromARGB(255, 177, 203, 178),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Text('Nitrogen 50 - 200 ppm', style: TextStyle(color: Colors.white, fontSize: 16),),
                            SizedBox(height: 5,),
                            Text('Phosphorus 4 - 14 ppm', style: TextStyle(color: Colors.white, fontSize: 16),),
                            SizedBox(height: 5,),
                            Text('Potassium 50 - 200 ppm',
                             style: TextStyle(color: Colors.white, fontSize: 16),),
                            SizedBox(height: 10,),
                        ],
                        ),
                      ),
                      SizedBox(height: 10,),
                       Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        color:Color.fromARGB(255, 17, 55, 38),
                        child: Text('Kupita Kiasi', style: TextStyle(color: Colors.white, fontSize: 18),),
                      ),
                      Container(
                        width: double.infinity,
                        color:Color.fromARGB(255, 177, 203, 178),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Text('Nitrogen Kubwa Zaidi ya 200 ppm (N > 50 ppm)', style: TextStyle(color: Colors.white, fontSize: 16),),
                            SizedBox(height: 5,),
                            Text('Phosphorus Kubwa Zaidi ya 14 ppm (P > 4 ppm)', style: TextStyle(color: Colors.white, fontSize: 16),),
                            SizedBox(height: 5,),
                            Text('Potassium Kubwa Zaidi ya 200 ppm (K > 50 ppm)',
                             style: TextStyle(color: Colors.white, fontSize: 16),),
                            SizedBox(height: 10,),
                        ],
                        ),
                      ),

                      

                      
                      

                    ],
                  ),
                ),
              ],
            ),
          )
        ],
            )
          )
        ]
      );
    }
  }
}
