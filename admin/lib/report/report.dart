import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rescue'),
      ),
      body: ListView.builder(
        itemCount: 3, // Update based on actual data
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rescue Details'),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Implement discard logic
                          print('Discard button pressed for rescue $index');
                        },
                        child: Text('Discard'),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red),
                      ),
                      SizedBox(width: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          // Implement send rescue logic
                          print('Send Rescue button pressed for rescue $index');
                        },
                        child: Text('Send Rescue'),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blue),
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
}
