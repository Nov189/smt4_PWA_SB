import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final TextEditingController _dateController = TextEditingController();
  final String apiUrl = 'http://127.0.0.1:8000/api/bookings';

  final List<String> slots = [
    '08:00 - 09:00',
    '09:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 13:00',
    '13:00 - 14:00',
    '14:00 - 15:00',
  ];

  final List<String> bookedSlots = [];
  List<String> selectedSlots = [];
  final List<String> equipments = ["Raket", "Shuttlecock", "Net", "Sepatu"];
  List<String> selectedEquipments = [];

  String? username;

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  void _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
  }

  void _submitForm() async {
    String date = _dateController.text;
    String slots = selectedSlots.join(', ');
    String equipments = selectedEquipments.isNotEmpty
        ? selectedEquipments.join(', ')
        : "-";

    var data = {
      'nama_pengirim': username,
      'lapangan_dipilih': 'Lapangan A', // Ganti dengan lapangan yang dipilih oleh pengguna
      'tanggal_bermain': date,
      'jam_dimulai': selectedSlots.first,
      'jam_diakhiri': selectedSlots.last,
      'equipment': equipments,
    };

    var response = await http.post(Uri.parse(apiUrl), body: data);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pemesanan berhasil!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pemesanan gagal!'),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Tanggal',
                icon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 30)),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dateController.text =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                  });
                }
              },
            ),
            SizedBox(height: 20.0),
            MultiSelectDialogField(
              items: slots
                  .where((slot) => !bookedSlots.contains(slot))
                  .map((slot) => MultiSelectItem(slot, slot))
                  .toList(),
              title: Text("Pilih Jam"),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                border: Border.all(width: 2),
              ),
              buttonIcon: Icon(Icons.arrow_drop_down),
              buttonText: Text(
                "Pilih Jam",
                style: TextStyle(fontSize: 16),
              ),
              onConfirm: (results) {
                setState(() {
                  selectedSlots = results.cast<String>();
                });
              },
              initialValue: selectedSlots,
              chipDisplay: MultiSelectChipDisplay(
                items: selectedSlots.map((slot) {
                  return MultiSelectItem(slot, slot);
                }).toList(),
              ),
            ),
            SizedBox(height: 20.0),
            MultiSelectDialogField(
              items: equipments
                  .map((equipment) => MultiSelectItem(equipment, equipment))
                  .toList(),
              title: Text("Sewa Alat Bulutangkis (Opsional)"),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                border: Border.all(width: 2),
              ),
              buttonIcon: Icon(Icons.arrow_drop_down),
              buttonText: Text(
                "Sewa Alat",
                style: TextStyle(fontSize: 16),
              ),
              onConfirm: (results) {
                setState(() {
                  selectedEquipments = results.cast<String>();
                });
              },
              initialValue: selectedEquipments,
              chipDisplay: MultiSelectChipDisplay(
                items: selectedEquipments.map((equipment) {
                  return MultiSelectItem(equipment, equipment);
                }).toList(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: selectedSlots.isEmpty ? null : _submitForm,
              child: Text('Pesan Lapangan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 79, 54, 179),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
