import 'package:flight_system/Search/search_bar.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

import 'Search/modal.dart';





class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _database = FirebaseDatabase.instance.reference();
  late final user;
  DateTime time_slot = DateTime.now();
  String time = "";
  String source = "";
  String dest = "";
  int passengers  = 0;
  String showTime = "";
  String date = "";
  List<Flight> _allResults = [];
  DateTime currentDate = DateTime.now();
  bool val = true;
  late bool loading;


  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });

    getNotices();
  }

  getNotices() async {
    List<Flight> list = [];

    final database = FirebaseDatabase.instance.reference();
    var snap = await database.child('notices').once();
    Map<dynamic, dynamic> result = snap.value;
    // print(result.length);
    result.forEach((key, value) {
      Map<dynamic, dynamic> map = value;
      list.add(Flight(
          time: map['time'],
          name: map['name'],
          source: map['source'],
          dest: map['dest'],
          date: map['date']));
    });

    setState(() {
      _allResults = list;
      loading = false;
    });
  }




  Future<void> _selectDate(BuildContext context) async {
    print("Time selected#############");
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null)
      setState(() {
        time_slot = pickedDate;
        showTime = DateFormat('dd MMMM yyyy').format(time_slot);
      });
  }


  Future<void> snackBarMssgs(String msg) async {

    String message = "";
    if (msg != null) {
      message = msg;
    }
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: '',
        onPressed: () {

        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Material(
        color: Colors.white,
        child: SafeArea(
            child: Column(
              children: [
                // <-----------------------------------------------Top Bar-------------------------------------------->
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22)),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Search your flight",
                          style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    height: size.height * .075,
                    width: size.width,
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(22),
                            bottomRight: Radius.circular(22))),
                  ),
                ),
                // <-----------------------------------------------Top Bar ends-------------------------------------------->

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //<-------------------------- Animation STARTS-------------------------->



                        //<-------------------------- Animation ENDS-------------------------->

                        Container(
                          padding: EdgeInsets.all(8),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    child: Center(
                                      child: Text('Event Form',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(

                                    decoration: InputDecoration(

                                      filled: true,
                                      hintText: "Enter source",
                                      border: InputBorder.none,
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(30)
                                    ],
                                    onChanged: (value) => setState(() {
                                      source = value;
                                    }),

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(

                                    decoration: InputDecoration(

                                      filled: true,
                                      hintText: "Enter destination",
                                      border: InputBorder.none,
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(30)
                                    ],
                                    onChanged: (value) => setState(() {
                                      dest = value;
                                    }),

                                  ),
                                ),


                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              _selectDate(context);
                                            },
                                            icon: Icon(
                                              Icons.calendar_today,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white10,
                                            ),
                                            child: Text(
                                              (showTime != "")
                                                  ? showTime
                                                  : "Select Date",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size.fromHeight(50)
                                          ),
                                          icon: Icon(Icons.arrow_back,size: 32,),
                                          label: Text(
                                            'Search',
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => SearchBar(
                          date: date,
                          allresult: _allResults,
                          time: time,
                          source: source,
                          dest: dest,
                        )));
                        },
                                        )
                                      ],
                                    )),


                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
