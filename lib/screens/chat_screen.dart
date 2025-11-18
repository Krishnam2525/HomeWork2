import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class ChatScreen extends StatefulWidget {
  final String boardName;

  const ChatScreen({super.key, required this.boardName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgCtrl = TextEditingController();
  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.boardName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: db.getMessages(widget.boardName),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return ListView(
                  padding: const EdgeInsets.all(12),
                  children: docs.map((d) {
                    final data = d.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['message']),
                      subtitle: Text(
                          "${data['name']} • ${data['timestamp'].toDate()}"),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgCtrl,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    db.sendMessage(widget.boardName, "User", msgCtrl.text);
                    msgCtrl.clear();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
