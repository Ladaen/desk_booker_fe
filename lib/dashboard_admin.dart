import 'package:flutter/material.dart';
import 'floor_mapping.dart';
import 'desk_mapping.dart';
import 'department_setup.dart';

class DashboardAdmin extends StatelessWidget {
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
        title: Text("Dashboard Admin"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin Tasks',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range, color: Colors.blue),
            label: 'Date',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class AdminTask extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  AdminTask({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.0),
          ),
          ElevatedButton(
            onPressed: onTap,
            child: Text('Choose'),
          ),
        ],
      ),
    );
  }
}
