import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final UserService _userService = UserService();
  final _nameController = TextEditingController();
  String? _selectedRole;
  List<User> _users = [];
  bool _isLoading = true;
  final List<String> _roles = ['admin', 'viewer'];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);
    try {
      final users = await _userService.getUsers();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load users: $e')));
    }
  }

  Future<void> _addUser() async {
    final name = _nameController.text.trim();
    if (name.isEmpty || _selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter name and select role')),
      );
      return;
    }

    try {
      await _userService.addUser(name, _selectedRole!, 'user@example.com');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User added successfully')));
      _nameController.clear();
      _selectedRole = null;
      await _loadUsers();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add user: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Users')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'User Name'),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      hint: const Text('Select Role'),
                      items: _roles
                          .map(
                            (role) => DropdownMenuItem(
                              value: role,
                              child: Text(role.toUpperCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _selectedRole = val),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _addUser,
                      child: const Text('Add User'),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 30),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: _users.isEmpty
                        ? const Center(child: Text('No users found.'))
                        : ListView.builder(
                            itemCount: _users.length,
                            itemBuilder: (context, index) {
                              final user = _users[index];
                              return Card(
                                child: ListTile(
                                  title: Text(user.username),
                                  trailing: Chip(
                                    label: Text(user.role.toUpperCase()),
                                    backgroundColor: user.role == 'admin'
                                        ? Colors.blue.shade100
                                        : Colors.green.shade100,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
