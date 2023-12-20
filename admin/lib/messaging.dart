import 'dart:async';

import 'package:admin/msgSkl.dart';
import 'package:admin/sockets/socketmanager.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<Msg> _messages = [];

  IO.Socket socket = SocketManager.getSocket();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${_messages[index].sender}: ${_messages[index].message}'),
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
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    _sendMessage();
                    socket.on(
                        "message", (data) => _receiveMessage(data['message']));
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String message = _textController.text.trim();
    if (message.isNotEmpty) {
      IO.Socket socket = SocketManager.getSocket();
      socket.emit("send_message_to_rescue", {'message': message});
      setState(() {
        _messages.add(Msg('Admin', message));
        _textController.clear();
      });
    }
  }

  void _receiveMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        _messages.add(Msg('Rescue', message));
      });
    }
  }
}
