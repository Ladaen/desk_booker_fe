import 'package:flutter/material.dart';
import 'floor_mapping.dart';
import 'desk_mapping.dart';
import 'department_setup.dart';

class AdminTask extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  AdminTask({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18.0)),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Text(
                    'Admin Tasks',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
          ),
        ),
        SizedBox(height: 16.0),
        AdminTask(
          title: 'Floor Mapping',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FloorMapping()),
            );
          },
        ),
        AdminTask(
          title: 'Desk Mapping',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeskMapping()),
            );
          },
        ),
        AdminTask(
          title: 'Department Setup',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DepartmentSetup()),
            );
          },
        ),
      ],
    );
  }
}
