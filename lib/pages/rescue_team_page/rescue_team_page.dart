import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rescue Team Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RescueTeamPage(),
    );
  }
}

class RescueTeamPage extends StatefulWidget {
  @override
  _RescueTeamPageState createState() => _RescueTeamPageState();
}

class _RescueTeamPageState extends State<RescueTeamPage> {
  // Sample data for demonstration purposes
  List<RescueTeam> rescueTeams = [
    RescueTeam(name: 'Team 1', leader: 'Leader 1', phoneNumber: '1234567890'),
    RescueTeam(name: 'Team 2', leader: 'Leader 2', phoneNumber: '9876543210'),
    // Add more teams as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rescue Teams'),
      ),
      body: ListView.builder(
        itemCount: rescueTeams.length,
        itemBuilder: (context, index) {
          var team = rescueTeams[index];
          return ListTile(
            title: Text(team.name),
            subtitle:
                Text('Leader: ${team.leader}\nPhone: ${team.phoneNumber}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TeamChatPage(team: team)),
              );
            },
          );
        },
      ),
    );
  }
}

class RescueTeam {
  final String name;
  final String leader;
  final String phoneNumber;

  RescueTeam(
      {required this.name, required this.leader, required this.phoneNumber});
}

class TeamChatPage extends StatefulWidget {
  final RescueTeam team;

  TeamChatPage({required this.team});

  @override
  _TeamChatPageState createState() => _TeamChatPageState();
}

class _TeamChatPageState extends State<TeamChatPage> {
  final TextEditingController messageController = TextEditingController();
  List<String> chatMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.team.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatMessages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() {
    setState(() {
      chatMessages.add(messageController.text);
      messageController.clear();
    });
  }
}
