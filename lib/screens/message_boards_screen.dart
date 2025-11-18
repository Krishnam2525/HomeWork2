import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class MessageBoardsScreen extends StatelessWidget {
  const MessageBoardsScreen({super.key});

  final boards = const [
    {"name": "General", "icon": Icons.forum},
    {"name": "Sports", "icon": Icons.sports_soccer},
    {"name": "Tech", "icon": Icons.computer},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Message Boards")),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text("Menu", style: TextStyle(fontSize: 22)),
            ),
            ListTile(
              title: const Text("Message Boards"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text("Profile"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen())),
            ),
            ListTile(
              title: const Text("Settings"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen())),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: boards.length,
        itemBuilder: (_, i) {
          return ListTile(
            leading: Icon(boards[i]['icon'] as IconData),
            title: Text(boards[i]['name'] as String),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ChatScreen(boardName: boards[i]['name'] as String),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
