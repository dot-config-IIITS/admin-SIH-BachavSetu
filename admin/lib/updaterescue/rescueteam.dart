import 'dart:convert';
import 'package:admin/sockets/socketmanager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:admin/init.dart';
import 'package:admin/updaterescue/team.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ManageRescueTeamPage extends StatefulWidget {
  @override
  _ManageRescueTeamPageState createState() => _ManageRescueTeamPageState();
}

class _ManageRescueTeamPageState extends State<ManageRescueTeamPage> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? _selectedLeader;
  String? _selectedType;

  // Define a list to store created teams
  List<RescueTeam> _createdTeams = [];

  final List<String> _rescueMembers = [
    'Member 1',
    'Member 2',
    'Member 3',
    'Member 4',
    'Member 5',
    'Member 6',
    'Member 7',
    'Member 8',
    'Member 9',
    'Member 10',
  ];

  final List<String> _teamTypes = [
    'Fire Station',
    'Police Station',
    'Hospital',
    'NGO',
    'DM Team',
    'Coast Guard',
  ];

  late List<String> stateNames;
  Map<String, List<String>> districts = {};
  late String selectedStateName;
  late String selectedDistrict;
  String feedback = '';

  @override
  void initState() {
    super.initState();
    selectedStateName = 'xd';
    selectedDistrict = '';
    stateNames = [];
    _loadStatesAndDistricts();
  }

  Future<void> _loadStatesAndDistricts() async {
    final String data =
        await rootBundle.loadString('assets/states_districts.json');
    final Map<String, dynamic> statesData = json.decode(data);

    statesData.forEach((key, value) {
      stateNames.add(value['name']);
      districts[value['name']] = List<String>.from(value['districts']);
    });

    setState(() {
      selectedStateName = stateNames.isNotEmpty ? stateNames[0] : '';
      selectedDistrict = districts[selectedStateName]!.isNotEmpty
          ? districts[selectedStateName]![0]
          : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Rescue Team'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create New Rescue Team',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _teamNameController,
                decoration: const InputDecoration(
                  labelText: 'Rescue Team Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a team name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedLeader,
                hint: const Text('Select Team Leader'),
                items: _rescueMembers.map((member) {
                  return DropdownMenuItem<String>(
                    value: member,
                    child: Text(member),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedLeader = value),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a team leader';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Contact Details',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact details';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedType,
                hint: const Text('Select Team Type'),
                items: _teamTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedType = value),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a team type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              Container(
                // width: 350,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select State',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        value: selectedStateName,
                        onChanged: (value) {
                          setState(() {
                            selectedStateName = value!;
                            selectedDistrict = districts[value]!.isNotEmpty
                                ? districts[value]![0]
                                : '';
                          });
                        },
                        items: stateNames.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(
                              option,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Container(
                // width: 350,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select District',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        value: selectedDistrict,
                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value!;
                          });
                        },
                        items: districts[selectedStateName]?.map((district) {
                              return DropdownMenuItem<String>(
                                value: district,
                                child: Text(district),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Create a new RescueTeam object
                    RescueTeam newTeam = RescueTeam(
                      name: _teamNameController.text,
                      leader: _selectedLeader!,
                      type: _selectedType!,
                      phone: '9876543210',
                      state: selectedStateName,
                      district: selectedDistrict,
                    );

                    IO.Socket socket = SocketManager.getSocket();
                    socket.emit("add_rescue_team", {
                      'name': _teamNameController.text,
                      'type': _selectedType!,
                      'phone': '9876543210'
                    });

                    // Add the new team to the list
                    _createdTeams.add(newTeam);

                    // Handle team creation and storage here
                    print(
                        'Team created: ${newTeam.name}, Leader: ${newTeam.leader}, Type: ${newTeam.type}');

                    // Navigate to HomePage with the updated _createdTeams list
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  }
                },
                child: const Text('Create Team'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
