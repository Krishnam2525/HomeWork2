import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final first = TextEditingController();
  final last = TextEditingController();
  final role = TextEditingController();

  final auth = AuthService();
  final db = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
                controller: first,
                decoration: const InputDecoration(labelText: "First Name")),
            TextField(
                controller: last,
                decoration: const InputDecoration(labelText: "Last Name")),
            TextField(
                controller: role,
                decoration: const InputDecoration(labelText: "Role")),
            TextField(
                controller: email,
                decoration: const InputDecoration(labelText: "Email")),
            TextField(
                controller: password,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Register"),
              onPressed: () async {
                final user = await auth.register(
                    email.text.trim(), password.text.trim());
                if (user != null) {
                  await db.saveUser(user.uid, first.text, last.text, role.text);
                }
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
