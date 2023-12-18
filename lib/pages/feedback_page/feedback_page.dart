import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FeedbackForm(),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String selectedSource = 'User';

  List<FeedbackMessage> feedbackMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Your Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            DropdownButtonFormField<String>(
              value: selectedSource,
              onChanged: (value) {
                setState(() {
                  selectedSource = value!;
                });
              },
              items: ['User', 'Rescue Team']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Feedback Source'),
            ),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Feedback Message'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                submitFeedback();
              },
              child: Text('Submit Feedback'),
            ),
            SizedBox(height: 20),
            Text(
              'Feedback Messages:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: feedbackMessages.length,
                itemBuilder: (context, index) {
                  var feedback = feedbackMessages[index];
                  return ListTile(
                    title: Text('${feedback.source}: ${feedback.name}'),
                    subtitle: Text(feedback.message),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitFeedback() {
    setState(() {
      FeedbackMessage feedback = FeedbackMessage(
        name: nameController.text,
        email: emailController.text,
        source: selectedSource,
        message: messageController.text,
      );

      feedbackMessages.add(feedback);

      // Clear the form fields
      nameController.clear();
      emailController.clear();
      messageController.clear();
      selectedSource = 'User';
    });
  }
}

class FeedbackMessage {
  final String name;
  final String email;
  final String source;
  final String message;

  FeedbackMessage({
    required this.name,
    required this.email,
    required this.source,
    required this.message,
  });
}
