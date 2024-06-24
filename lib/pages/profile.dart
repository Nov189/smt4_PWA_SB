import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileUserPage extends StatefulWidget {
  @override
  _ProfileUserPageState createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  bool _isEditing = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _noTelpController = TextEditingController();
  String _password = '********';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Token not found, please login again')),
      );
      return;
    }

    try {
      var response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var user = jsonDecode(response.body);
        setState(() {
          _usernameController.text = user['username'] ?? '';
          _emailController.text = user['email'] ?? '';
          _noTelpController.text = user['no_telp'] ?? '';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to load profile: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print("Error loading profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading profile: $e')),
      );
    }
  }

  Future<void> _updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Token not found, please login again')),
      );
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/profile/update'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'username': _usernameController.text,
          'no_telp': _noTelpController.text,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _isEditing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
                color: Color.fromARGB(255, 67, 68, 151),
              ),
            ),
            SizedBox(height: 20),
            _buildProfileField('Nama Pengguna', _usernameController),
            _buildProfileField('Email', _emailController, enabled: false),
            _buildProfileField(
                'Password', TextEditingController(text: _password),
                enabled: false),
            _buildProfileField('No Telp', _noTelpController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isEditing
                  ? _updateProfile
                  : () => setState(() => _isEditing = true),
              child: Text(_isEditing ? 'Simpan' : 'Edit Profil'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            enabled: _isEditing && enabled,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
