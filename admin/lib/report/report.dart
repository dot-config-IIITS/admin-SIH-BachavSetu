import 'package:flutter/material.dart';
import 'data.dart'; // Assuming ReportStructure is defined in data.dart

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<ReportStructure> rescueReports = [
    ReportStructure(lat: 12.345, lng: 67.890, type: 'Fire'),
    ReportStructure(lat: 23.456, lng: 45.678, type: 'Medical'),
    ReportStructure(lat: 34.567, lng: 56.789, type: 'Flood'),
    // Add more ReportStructure objects as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rescue'),
      ),
      body: ListView.builder(
        itemCount: rescueReports.length,
        itemBuilder: (context, index) {
          ReportStructure report = rescueReports[index];
          bool discarded = false;

          return Card(
            color: discarded ? Colors.red.shade400 : null,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Latitude: ${report.lat}'),
                      Text('Longitude: ${report.lng}'),
                      Text('Type: ${report.type}'),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Implement discard logic
                          setState(() {
                            discarded = true;
                          });
                          snack('Discard button pressed for rescue $index');
                        },
                        child: Text('Discard'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          // Implement send rescue logic
                          _showDeployDialog(context, index);
                          print('Send Rescue button pressed for rescue $index');
                        },
                        child: Text('Send Rescue'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showDeployDialog(BuildContext context, int reportIndex) async {
    String selectedRescueTeam = 'Kolkata Rescuers'; // Default value
    List<String> rescueTeams = [
      'Kolkata Rescuers',
      'Delhi Lifesavers',
      'Mumbai Guardians',
      'Chennai Resilience',
      'Hyderabad Saviors',
      'Random',
    ];

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deploy Rescue Team'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Rescue Team:'),
              DropdownButton<String>(
                value: selectedRescueTeam,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRescueTeam = newValue!;
                  });
                },
                items: rescueTeams.map((String team) {
                  return DropdownMenuItem<String>(
                    value: team,
                    child: Text(team),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement deploy rescue team logic
                snack(
                    'Deploying rescue team $selectedRescueTeam for rescue $reportIndex');
                Navigator.of(context).pop();
              },
              child: Text('Deploy'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }

  void snack(String msg) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          msg,
        ),
      ),
    );
  }
}
