import 'package:flutter/material.dart';

class FloorMapping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Floor Mapping"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Floor Mapping',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Image.asset(
                'assets/images/Kursi2.png', // Ganti dengan path gambar Anda
                width: 1000, // Atur lebar gambar sesuai kebutuhan
                height: 200, // Atur tinggi gambar sesuai kebutuhan
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Lantai',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: List.generate(6, (index) {
                return ElevatedButton(
                  onPressed: () {
                    // Tambahkan aksi untuk setiap tombol lantai
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Lantai ${index + 1}'),
                );
              }),
            ),
            SizedBox(height: 16.0),
            Text(
              'Departement',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: [
                _buildCheckbox('Design Grafis'),
                _buildCheckbox('Marketing'),
                _buildCheckbox('Programer'),
                _buildCheckbox('Data Entry'),
                _buildCheckbox('Accounting'),
                _buildCheckbox('All'),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan aksi untuk tombol submit
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('SUBMIT'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(value: false, onChanged: (bool? value) {}),
        Text(title),
      ],
    );
  }
}
