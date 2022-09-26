
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

  const SearchBar({Key? key,required this.dest,required this.date, required this.source, required this.time, required this.allresult}): super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState( );
}

class _SearchBarState extends State<SearchBar> {

  late bool loading;



  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
  }





  // searchResultsList() {
  //   List<Flight> showResults = [];
  //
  //   if (_searchController.text != "") {
  //     for (var flight in _allResults) {
  //       // var title = Trip.fromSnapshot(tripSnapshot).title.toLowerCase();
  //       var name = flight.name.toLowerCase();
  //       var source = flight.source.toLowerCase();
  //       var dest = flight.dest.toLowerCase();
  //       var time = flight.time.toLowerCase();
  //       var date = flight.date.toLowerCase();
  //       var query = _searchController.text.toLowerCase();
  //       if (time.contains(query) || description.contains(query)) {
  //         showResults.add(notice);
  //       }
  //     }
  //   } else {
  //     showResults = List.from(_allResults);
  //   }
  //   setState(() {
  //     _resultsList = showResults;
  //   });
  // }



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
                    itemCount: widget.allresult.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildNotice(widget.allresult[index]),
                  )),
            ],
          ),
        ));
  }
}
