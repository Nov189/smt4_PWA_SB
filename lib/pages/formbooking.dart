import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:smtforflutter/pages/booking.dart';
import 'dart:convert';

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final TextEditingController _dateController = TextEditingController();

  final String apiUrl = 'http://127.0.0.1:8000/api/tambahbooking';

  final List<TimeOfDay> slots = [
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 11, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 13, minute: 0),
    TimeOfDay(hour: 14, minute: 0),
  ];

  List<TimeOfDay> selectedSlots = [];
  final List<String> equipments = ["Raket", "Shuttlecock", "Net", "Sepatu"];
  List<String> selectedEquipments = [];

  String? username;
  String? selectedField;

  @override
  void initState() {
    super.initState();
    _getUsername();
    _getSelectedField();
  }

  void _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('email');
    });
  }

  void _getSelectedField() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedField = prefs.getString('selectedField');
    });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm(); // 'H:m' format
    return format.format(dt);
  }

  void _submitForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    if (accessToken != null) {
      if (selectedSlots.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pilih setidaknya satu slot waktu'),
          ),
        );
        return;
      }

      String email = prefs.getString('email') ?? '';
      String selectedField = prefs.getString('selectedField') ?? '';
      String date = _dateController.text;
      String equipments =
          selectedEquipments.isNotEmpty ? selectedEquipments.join(', ') : "-";

      var url = Uri.parse(apiUrl);

      try {
        var response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode({
            'nama_pengirim': email,
            'lapangan_dipilih': selectedField,
            'tanggal_bermain': date,
            'jam_dimulai': formatTimeOfDay(selectedSlots.first),
            'jam_diakhiri': formatTimeOfDay(selectedSlots.last),
            'equipment': equipments,
          }),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Pemesanan berhasil!'),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BookingPage()),
          );
        } else {
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Pemesanan gagal: ${response.body}'),
            ),
          );
        }
      } catch (e) {
        print("Error during booking: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan saat pemesanan: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Akses token tidak ditemukan, silahkan login kembali'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Penyewaan Lapangan'),
        backgroundColor: Color.fromARGB(255, 79, 54, 179),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Lapangan yang dipilih: $selectedField',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Tanggal Bermain',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        _dateController.text = formattedDate;
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pilih Waktu Bermain',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            MultiSelectBottomSheetField(
              initialChildSize: 0.4,
              listType: MultiSelectListType.CHIP,
              searchable: true,
              buttonText: Text("Pilih Slot Waktu"),
              title: Text("Slot Waktu"),
              items: slots
                  .map((slot) =>
                      MultiSelectItem<TimeOfDay>(slot, slot.format(context)))
                  .toList(),
              onConfirm: (values) {
                setState(() {
                  selectedSlots = values.cast<TimeOfDay>();
                });
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (value) {
                  setState(() {
                    selectedSlots.remove(value);
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pilih Peralatan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            MultiSelectBottomSheetField(
              initialChildSize: 0.4,
              listType: MultiSelectListType.CHIP,
              searchable: true,
              buttonText: Text("Pilih Peralatan"),
              title: Text("Peralatan"),
              items: equipments
                  .map((equipment) =>
                      MultiSelectItem<String>(equipment, equipment))
                  .toList(),
              onConfirm: (values) {
                setState(() {
                  selectedEquipments = values.cast<String>();
                });
              },
              chipDisplay: MultiSelectChipDisplay(
                onTap: (value) {
                  setState(() {
                    selectedEquipments.remove(value);
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 79, 54, 179),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
