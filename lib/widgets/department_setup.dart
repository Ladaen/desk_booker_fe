import 'package:flutter/material.dart';

class DepartmentSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Departement Karyawan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Departement Karyawan',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.blue),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Nama',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('ID Card',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Departement',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ],
                ),
                _buildTableRow('Daeng Ahmad', '123456789', 'Finance', context),
                _buildTableRow(
                    'Dodik Firmansah', '543654321', 'Marketing', context),
                _buildTableRow(
                    'Akrom Hakiki', '675653323', 'Accounting', context),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(
      String name, String idCard, String department, BuildContext context) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(idCard),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(department),
              Spacer(),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _showEditDialog(context, name, idCard, department);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showEditDialog(
      BuildContext context, String name, String idCard, String department) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'EDIT DATA',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Nama'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: name,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('ID Card'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: idCard,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Departement'),
                  Wrap(
                    children: [
                      _buildCheckbox('Design Grafis'),
                      _buildCheckbox('Marketing'),
                      _buildCheckbox('Programer'),
                      _buildCheckbox('Data Entry'),
                      _buildCheckbox('Accounting'),
                      _buildCheckbox('All'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
          ),
        );
      },
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
