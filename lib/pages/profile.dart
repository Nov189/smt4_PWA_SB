import 'package:flutter/material.dart';
import 'package:smtforflutter/pages/home.dart';

class ProfileUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [Color(0xFF17123A), Color.fromARGB(255, 79, 54, 179)],
              ),
            ),
            width: double.infinity,
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Color.fromARGB(255, 67, 68, 151),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Nama Pengguna',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  datadiri('Nama', 'Nama Lengkap'),
                  datadiri('Email', 'email@example.com'),
                  datadiri('Tanggal Masuk', '13 Mei 2024'),
                  datadiri('Status', 'Aktif'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget datadiri(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label + ':',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
