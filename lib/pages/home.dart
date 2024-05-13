import 'package:flutter/material.dart';
import 'package:smtforflutter/pages/profile.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // nambah fungsi notif nya
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF17123A), Color.fromARGB(255, 79, 54, 179)],
                ),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileUserPage()));
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      // child: Icon(
                      //   Icons.person,
                      //   size: 50,
                      //   color: Color.fromARGB(255, 67, 68, 151),
                      // ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Ingin Memesan sesuatu ?',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  kotakdashboard(
                      'tambah yoo', Color.fromARGB(255, 168, 177, 255)),
                  kotakdashboard(
                      'tambah yoo', Color.fromARGB(255, 168, 177, 255)),
                  kotakdashboard(
                      'ini pisan', Color.fromARGB(255, 168, 177, 255)),
                  kotakdashboard(
                      'terus ini', Color.fromARGB(255, 168, 177, 255)),
                  kotakdashboard(
                      'ini juga', Color.fromARGB(255, 168, 177, 255)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardFeature(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {},
    );
  }

  Widget kotakdashboard(String title, Color color) {
    return Container(
      width: 300,
      height: 150,
      margin: EdgeInsets.all(8),
      color: color,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
