
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
 late final user;

late List<Flight> filterList;

  @override
  void initState() {
    super.initState();
    user=FirebaseAuth.instance.currentUser;
    print("Search bar#############" + user.uid);
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

 final _database=FirebaseDatabase.instance.reference();

int checker(String ch){
    if(ch=="0") return 0;
    else if(ch=="1") return 1;
    else if(ch=="2") return 2;
    else if(ch=="3") return 3;
    else if(ch=="4") return 4;
    else if(ch=="5") return 5;
    else if(ch=="6") return 6;
    else if(ch=="7") return 7;
    else if(ch=="8") return 8;
    else if(ch=="9") return 9;










    return 0;
}

int sol(String num){
    int ans=0;
    for(int i=0;i<num.length;i++){
      ans=ans*10 + checker(num[i]);
    }

    return ans;
}



  Widget buildNotice(Flight book) =>  Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,

      child:Container(


        height: MediaQuery.of(context).size.height / 3,
        alignment:Alignment.centerLeft,
        child: Column(

          children: [
            ListTile(

              title:  Center(child: Text("Flight Name : "+book.name)),
              subtitle: Center(child: Text("Soure: "+book.source+" Destination:  "+book.dest)),
            ),
            Text("Flight Number: "+book.flightNumber),
            Text("Scheduled Departure: "+book.time),
            Text("Fare: "+book.fare),
            Text("Available Seats: "+book.seats),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(

                onPressed: ()async{
                  // int ans=sol(book.seats);
                  // if(ans==0){
                  //
                  // }
                  // else{
                  //   ans--;
                  //   await _database.child('/users').child(user.uuid).push()
                  //
                  // }
                  //
                  //
                  //


                },
                child: Text("Book Flight")
            )

          ],
        ),
      )
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
              : Container(
            color: Colors.blueGrey,
                child: Column(
            children: <Widget>[

                Expanded(
                    child: ListView.builder(
                      itemCount: filterList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildNotice(filterList[index]),
                    )),
            ],
          ),
              ),
        ));
  }
}
