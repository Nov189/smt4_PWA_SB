import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smtforflutter/pages/formbooking.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> lapangans = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    super.initState();
    fetchLapangans();
  }

  Future<void> fetchLapangans() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/lapangans'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          lapangans = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load lapangans';
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error: $error';
        isLoading = false;
      });
    }
  }

  Future<void> _saveSelectedField(String fieldName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedField', fieldName);
    
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Page"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 149, 12, 207),
      ),
      body: Column(
        children: [
          if (isLoading)
            CircularProgressIndicator() // Menampilkan indikator loading jika sedang memuat data
          else if (errorMessage.isNotEmpty)
            Text(
                errorMessage) // Menampilkan pesan kesalahan jika terjadi kesalahan
          else
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 1,
                      ),
                      itemCount: lapangans.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _saveSelectedField(lapangans[index]['nama']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingForm(),
                              ),
                            ).then((_) {
                              _clearSelectedField();
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      lapangans[index]['gambar'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  color: Colors.black.withOpacity(0.6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        lapangans[index]['nama'],
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Harga: ${lapangans[index]['harga']}/jam',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _clearSelectedField() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedField');
  }
}
