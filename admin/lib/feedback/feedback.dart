import 'package:admin/feedback/structure.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Feed> feedbacks = [
      // Replace with actual data fetching or API calls
      Feed(
          name: 'Ashok Kumar',
          state: 'Andhra Pradeh',
          district: 'Guntur',
          feedback: 'The app is very helpful!'),
      Feed(
          name: 'Ranjith Kumar',
          state: 'Tamil Nadu',
          district: 'Chennai',
          feedback: 'I wish there were more features.'),
      Feed(
          name: 'Sushila Rani',
          state: 'Telengana',
          district: 'Hyderabad',
          feedback: 'Overall, a great experience!'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: ListView.builder(
        itemCount: feedbacks.length,
        itemBuilder: (context, index) {
          final feedback = feedbacks[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(feedback.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text('State: ${feedback.state}'),
                      SizedBox(width: 10.0),
                      Text('District: ${feedback.district}'),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text(feedback.feedback),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
