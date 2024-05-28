import 'package:flutter/material.dart';


class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> with SingleTickerProviderStateMixin {
  late int index;
  late TabController _tabController;

  // List of item titles
  final List<String> itemTitles = [
    'Lapangan 1',
    'Lapangan 2',
    'Lapangan 3',
    'Lapangan 4',
    'Lapangan 5',
    'Lapangan 6',
  ];

  // List of path gambar untuk setiap item
  final List<String> itemImages = [
    'assets/lapangan1.jpeg',
    'assets/lapangan2.jpeg',
    'assets/lapangan3.jpeg',
    'assets/lapangan4.jpeg',
    'assets/lapangan5.jpeg',
    'assets/lapangan6.jpg',
    // tambahkan path gambar lainnya sesuai kebutuhan
  ];

  // List of deskripsi lapangan
  final List<String> itemDescriptions = [
    'Harga: 20k/jam',
    'Harga: 20k/jam',
    'Harga: 20k/jam',
    'Harga: 20k/jam',
    'Harga: 20k/jam',
    'Harga: 20k/jam',
  ];

  @override
  void initState() {
    index = 1;
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
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
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Be Happy! Be Healthy!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Choose Your Battlefield!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text("HOME")),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2 / 1,
                    ),
                    itemCount: itemTitles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.pushNamed(context, '/detail1');
                          } else if (index == 1) {
                            Navigator.pushNamed(context, '/detail2');
                          } else if (index == 2) {
                            Navigator.pushNamed(context, '/detail3');
                          } else if (index == 3) {
                            Navigator.pushNamed(context, '/detail4');
                          } else if (index == 4) {
                            Navigator.pushNamed(context, '/detail5');
                          } else if (index == 5) {
                            Navigator.pushNamed(context, '/detail6');
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(itemImages[index]),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      itemTitles[index],
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      itemDescriptions[index],
                                      style: TextStyle(fontSize: 14, color: Colors.white),
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
                Center(child: Text("PROFILE")),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 149, 12, 207),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black26,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
            _tabController.index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "booking",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "profile",
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;

  const DetailPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
