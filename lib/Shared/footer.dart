import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final selectedIndex;
  final ValueChanged<int> onClicked;
  final isAdmin;
  Footer({this.selectedIndex, required this.onClicked, this.isAdmin});

  @override
  Widget build(BuildContext context) {
    var navItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.date_range),
        label: 'Book a Desk',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'Booking History',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];

    if (isAdmin)
      navItems.add(BottomNavigationBarItem(
        icon: Icon(Icons.admin_panel_settings),
        label: 'Admin',
      ));

    return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onClicked,
        backgroundColor: Colors.blue, // Warna latar belakang biru
        selectedItemColor: Colors.blue, // Warna ikon dipilih putih
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0)
            .withOpacity(0.6), // Warna ikon tidak dipilih dengan opacity
        items: navItems);
  }
}
