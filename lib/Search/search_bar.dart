
import 'package:firebase_database/firebase_database.dart';
import 'package:flight_system/Search/modal.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class SearchBar extends StatefulWidget {
  final List<Flight> allresult;
  final String dest;
  final String source;
  final String time;
  final String date;
  final String test;

  const SearchBar({Key? key,required this.test,required this.dest,required this.date, required this.source, required this.time, required this.allresult}): super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState( );
}

class _SearchBarState extends State<SearchBar> {

  late bool loading;

late List<Flight> filterList;

  @override
  void initState() {
    super.initState();
    print("Search bar#############");
    print(widget.test+" "+widget.source+" "+widget.dest);
    setState(() {
      loading = true;
    });
    filter();
    loading = false;
  }
  void filter(){
    List<Flight>filter = [];
    print("kjhkjhj#############################");
    for(var flight in widget.allresult){

      if(flight.source.contains(widget.source) && flight.dest.contains(widget.dest) && flight.date.contains(widget.date)){
        filter.add(flight);
      }
    }
    setState(() {
      filterList = filter;
    });
  }









  Widget buildNotice(Flight book) => ListTile(
    title: Text(book.name),
    subtitle: Text(book.source + " " + book.dest + " " + book.time + " " + book.date),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Search"),
          ),
          body: loading
              ? Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          )
              : Column(
            children: <Widget>[

              Expanded(
                  child: ListView.builder(
                    itemCount: filterList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildNotice(filterList[index]),
                  )),
            ],
          ),
        ));
  }
}
