import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Subscription Status'),
              subtitle: const Text('Free Plan'),
              trailing: TextButton(
                onPressed: () {
                  // TODO: Implement subscription management
                },
                child: const Text('Upgrade'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Saved Recipes'),
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Recipe History'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
