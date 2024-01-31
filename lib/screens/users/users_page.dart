import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                context.go('/users/participants');
              },
              child: Card(
                child: ListTile(
                  title: Text('Participants'),
                  subtitle: Text(''),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Ambassadors'),
                subtitle: Text(''),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Partners'),
                subtitle: Text(''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
