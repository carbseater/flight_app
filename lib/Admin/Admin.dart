// import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flight_system/Admin/AdminFlight.dart';
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title:Text("Admin Dashboard"),

      ),
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFlights(name: "Madhav mishra",)),
              ),
              child:  Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.onPrimary,
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(child: Text('Add Flights')),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => null,
              child:  Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.onPrimary,
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(child: Text('View Flights')),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => null,
              child:  Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.onPrimary,
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(child: Text('Remove Flights')),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}