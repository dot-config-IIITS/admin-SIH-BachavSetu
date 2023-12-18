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
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disaster Management Admin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateTeamPage()),
                );
              },
              child: Text('Create New Rescue Team'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateTeamPage()),
                );
              },
              child: Text('Update Existing Rescue Team'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Rescue Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TeamForm(),
      ),
    );
  }
}

class UpdateTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Existing Rescue Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TeamForm(),
      ),
    );
  }
}

class TeamForm extends StatefulWidget {
  @override
  _TeamFormState createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  final TextEditingController leaderNameController = TextEditingController();
  final TextEditingController leaderPhoneNumberController =
      TextEditingController();
  final TextEditingController leaderAadharNumberController =
      TextEditingController();
  final TextEditingController teamTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: leaderNameController,
          decoration: InputDecoration(labelText: 'Team Leader Name'),
        ),
        TextField(
          controller: leaderPhoneNumberController,
          decoration: InputDecoration(labelText: 'Leader Phone Number'),
          keyboardType: TextInputType.phone,
        ),
        TextField(
          controller: leaderAadharNumberController,
          decoration: InputDecoration(labelText: 'Leader Aadhar Number'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: teamTypeController,
          decoration: InputDecoration(labelText: 'Team Type'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Implement logic to save or update team details
            // For simplicity, just print the entered details for now
            print('Leader Name: ${leaderNameController.text}');
            print('Leader Phone Number: ${leaderPhoneNumberController.text}');
            print('Leader Aadhar Number: ${leaderAadharNumberController.text}');
            print('Team Type: ${teamTypeController.text}');
          },
          child: Text('Save Team Details'),
        ),
      ],
    );
  }
}
