// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool isDarkMode = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadTheme();
//   }

//   Future<void> _loadTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isDarkMode = prefs.getBool('isDarkMode') ?? false;
//     });
//   }

//   Future<void> _toggleTheme(bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isDarkMode = value;
//       prefs.setBool('isDarkMode', value);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: ListView(
//         children: [
//           ListTile(
//             title: Text('Pengaturan Tampilan'),
//             subtitle: Text(isDarkMode ? 'Gelap' : 'Terang'),
//             trailing: Switch(
//               value: isDarkMode,
//               onChanged: (value) {
//                 _toggleTheme(value);
//                 if (value) {
//                   MyApp.of(context)?.changeTheme(ThemeData.dark());
//                 } else {
//                   MyApp.of(context)?.changeTheme(ThemeData.light());
//                 }
//               },
//             ),
//           ),
//           ListTile(
//             title: Text('Informasi Pribadi'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PersonalInfoPage()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('Pengaturan Akun'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AccountSettingsPage()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('Logout'),
//             onTap: () {
//               // Tambahkan logika logout di sini
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyApp extends StatefulWidget {
//   static _MyAppState of(BuildContext context) =>
//       context.findAncestorStateOfType<_MyAppState>();

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   ThemeData _themeData = ThemeData.light();

//   void changeTheme(ThemeData themeData) {
//     setState(() {
//       _themeData = themeData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: _themeData,
//       home: DashboardPage(),
//     );
//   }
// }

// class PersonalInfoPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Informasi Pribadi'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Nomor HP'),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Deskripsi'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Tambahkan logika untuk menyimpan informasi pribadi
//               },
//               child: Text('Simpan'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AccountSettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pengaturan Akun'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // Tambahkan logika untuk mengubah password
//               },
//               child: Text('Ganti Password'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Tambahkan logika untuk menghapus akun
//               },
//               child: Text('Hapus Akun'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }
