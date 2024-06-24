import 'package:flutter/material.dart';
import 'package:smtforflutter/pages/home.dart'; // Pastikan import ini benar
import 'register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk jsonDecode
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
  String email = emailController.text;
  String password = passwordController.text;

  var url = Uri.parse('http://127.0.0.1:8000/api/loginpelanggan');

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        String accessToken = responseData['access_token'];

        // Simpan access_token dan email dalam SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('email', email);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login berhasil'),
        ));

        // Navigasi ke halaman dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login gagal, coba lagi. Status code: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      print("Error during login: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform(
            transform:
                Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF17123A), Color(0xFF6A5AAA)],
                ),
              ),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/nebula.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Login Dengan Akun!',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Column(
                          children: <Widget>[
                            inputText('Email', emailController),
                            SizedBox(height: 10.0),
                            inputText('Password', passwordController,
                                isPassword: true)
                          ],
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.login, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: Text(
                            'Belum punya akun? Daftar di sini',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget inputText(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white10.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.amberAccent),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        ),
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.amberAccent),
      ),
    );
  }
}
