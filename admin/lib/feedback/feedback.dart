import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Feedback> feedbacks = [
      // Replace with actual data fetching or API calls
      Feedback(
          name: 'John Doe',
          state: 'California',
          district: 'Los Angeles',
          feedback: 'The app is very helpful!'),
      Feedback(
          name: 'Jane Smith',
          state: 'Texas',
          district: 'Dallas',
          feedback: 'I wish there were more features.'),
      Feedback(
          name: 'Alex White',
          state: 'Florida',
          district: 'Miami',
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

class Feedback {
  final String name;
  final String state;
  final String district;
  final String feedback;

  Feedback(
      {required this.name,
      required this.state,
      required this.district,
      required this.feedback});
}
