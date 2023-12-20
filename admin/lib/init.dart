import 'package:admin/log/log.dart';
import 'package:admin/login/login.dart';
import 'package:admin/map/map.dart';
import 'package:admin/messaging.dart';
import 'package:admin/report/report.dart';
import 'package:admin/updaterescue/rescueteam.dart';
import 'package:admin/updaterescue/team.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import './feedback/feedback.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RescueTeam> createdTeams = [
    RescueTeam(
      name: 'Kolkata Rescuers',
      leader: 'Member 1',
      type: 'NGO',
      phone: '9876543210',
      state: 'West Bengal',
      district: 'Kolkata',
    ),
    RescueTeam(
      name: 'Delhi Lifesavers',
      leader: 'Member 4',
      type: 'Medical',
      phone: '9871234567',
      state: 'Delhi',
      district: 'New Delhi',
    ),
    RescueTeam(
      name: 'Mumbai Guardians',
      leader: 'Member 6',
      type: 'Fire Station',
      phone: '8765432109',
      state: 'Maharashtra',
      district: 'Mumbai',
    ),
    RescueTeam(
      name: 'Chennai Resilience',
      leader: 'Member 8',
      type: 'NGO',
      phone: '9876549876',
      state: 'Tamil Nadu',
      district: 'Chennai',
    ),
    RescueTeam(
      name: 'Hyderabad Saviors',
      leader: 'Member 7',
      type: 'Medical',
      phone: '9876789012',
      state: 'Telangana',
      district: 'Hyderabad',
    ),
    RescueTeam(
      name: 'Random',
      leader: 'Member 10',
      type: 'Medical',
      phone: '9999999999',
      state: 'Andhra Pradesh',
      district: 'Guntur',
    ),
  ];

  void updateTeams(RescueTeam newTeam) {
    setState(() {
      createdTeams.add(newTeam);
    });
  }

  @override
  Widget build(BuildContext context) {
    int numberOfTeams = createdTeams.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 74, 75, 75),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Ionicons.chatbox_ellipses),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Ionicons.map),
              title: const Text('Map'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Ionicons.flag),
              title: const Text('User Report'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Ionicons.flag),
              title: const Text('Chat With Rescue Team'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Ionicons.medical),
              title: const Text('Manage Rescue Team'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ManageRescueTeamPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Ionicons.list_circle),
              title: const Text('Log'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Ionicons.log_out),
              iconColor: Colors.red,
              title: const Text('Logout'),
              onTap: () {
                // Handle logout
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Number of Created Teams: $numberOfTeams',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: createdTeams.length,
                itemBuilder: (context, index) {
                  RescueTeam team = createdTeams[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Team ${index + 1}', // Display team number dynamically
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            team.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
