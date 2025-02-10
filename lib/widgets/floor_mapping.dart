import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FloorMapping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Floor Mapping"),
        ),
        body: Stack(
          children: [
            SizedBox(width: screenWidth, height: screenHeight),
            SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          width: screenWidth, // Menggunakan lebar layar penuh
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/kantor.JPEG'),
                              fit: BoxFit.cover, // Menutupi kontainer
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
            )),
            Positioned(
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FloorAdd()),
                  )
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 50,
                  weight: 500,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen, shape: CircleBorder()),
              ),
              bottom: 30,
              right: 0,
            )
          ],
        ));
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

  Widget _setUpMapping() {
    return Padding(
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
    );
  }
}

class FloorAdd extends StatefulWidget {
  @override
  _FloorAddState createState() => _FloorAddState();
}

class _FloorAddState extends State<FloorAdd> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Floor Mapping - Add New"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                  child: Text('UPLOAD FILE'), onPressed: () => _PickFile())
            ]),
      )),
    );
  }

  late Uint8List? uploadedImage;

  void _PickFile() async {
    var picked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'svg', 'jpeg']);

    var uploadedFile = picked?.files.first;
    if (picked == null) {
      return;
    }
    uploadedImage = uploadedFile!.bytes;
    print(uploadedFile!.name);
  }
}
