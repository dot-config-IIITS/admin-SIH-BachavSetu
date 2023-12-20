import 'dart:convert';
import 'package:admin/init.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:admin/sockets/socketmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App logo or icon
                  Image.asset('assets/abc.png', height: 250.0),
                  const SizedBox(height: 32.0),
                  Text(
                    'Welcome back!',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16.0),
                  // TextFormField(
                  //   controller: _emailController,
                  //   decoration: InputDecoration(
                  //     hintText: 'Email',
                  //     filled: true,
                  //     fillColor: Colors.grey[200],
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your email address.';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 350,
                        height: 60,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
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
                                    selectedDistrict =
                                        districts[value]!.isNotEmpty
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
                      Container(
                        width: 350,
                        height: 60,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
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
                                items: districts[selectedStateName]
                                        ?.map((district) {
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
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: IconButton(
                        icon: _showPassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password.';
                      }
                      return null;
                    },
                    obscureText: _showPassword,
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      // Verification logic
                      // WARNING: It is yet to be verified, work in progress.

                      // if (_formKey.currentState!.validate()) {
                      //   IO.Socket socket = SocketManager.getSocket();
                      //   socket.emit("login", {
                      //     'state': selectedStateName,
                      //     'district': selectedDistrict,
                      //     'password': _passwordController.text
                      //   });
                      //   socket.on("login_result", (data) {
                      //     if (data['status'] == 'success') {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => HomePage()),
                      //       );
                      //     }
                      //   });
                      // }
                      IO.Socket socket = SocketManager.getSocket();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: const Text('Log In'),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {}, // Handle "Forgot Password?" link
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
