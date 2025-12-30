import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kilimo/data/data.dart';
import 'package:kilimo/widget/drawer.dart';

class AllResult extends StatefulWidget {
  const AllResult({super.key});

  @override
  State<AllResult> createState() => _AllResultState();
}

class _AllResultState extends State<AllResult> {
  bool error = false, dataloaded = false;
  dynamic data;
  String dataurl = "http://192.168.43.23/soil-npk-test/allresult.php";
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
        title: Text('Matokeo ya Majaribio'),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 17, 55, 38),
      ),
      drawer: SideNav(),
      body: ListView(children: [
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

          // if data is loaded then show table
          // border: TableBorder.all(width: 1, color: Colors.black),
          children: namelist.map(
        (nameone) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  // borderRadius:BorderRadius.circular(30),

                  color: Color.fromARGB(255, 177, 203, 178),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 17, 55, 38),
                      child: Text(nameone.sn,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('NITROGEN',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('${nameone.potassium}ppm',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PHOSPHORUS',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('${nameone.phosphorus}ppm',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('POTASSIUM',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text('${nameone.potassium}ppm',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ).toList());
    }
  }
}
