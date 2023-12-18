import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disaster Management Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StatisticsPage(),
    );
  }
}

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  // Sample data for demonstration purposes
  Map<String, bool> teamAvailability = {
    'Team 1': true,
    'Team 2': false,
    'Team 3': true,
    // Add more teams as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics Page'),
      ),
      body: ListView.builder(
        itemCount: teamAvailability.length,
        itemBuilder: (context, index) {
          var teamName = teamAvailability.keys.elementAt(index);
          var isTeamAvailable = teamAvailability[teamName] ?? false;

          return ListTile(
            title: Text(teamName),
            subtitle: Text(
                'Availability: ${isTeamAvailable ? 'Available' : 'Not Available'}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement logic for allocating team
                    setState(() {
                      teamAvailability[teamName] = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '$teamName has been allocated for a disaster.'),
                      ),
                    );
                  },
                  child: Text('Allocate'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Implement logic for deallocating team
                    setState(() {
                      teamAvailability[teamName] = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$teamName has been deallocated.'),
                      ),
                    );
                  },
                  child: Text('Deallocate'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
