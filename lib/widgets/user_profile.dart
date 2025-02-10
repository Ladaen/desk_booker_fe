import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frondend_project_uas/widgets/login.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_model.dart';

class UserProfile extends StatelessWidget {
  UserModel user;

  UserProfile(this.user);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150, // Menggunakan lebar layar penuh
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // border: Border.all(color: Colors.grey, width: 4),
            image: DecorationImage(
              image: AssetImage('assets/images/profile user.png'),
              fit: BoxFit.cover, // Menutupi kontainer
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(user.name ?? "", style: TextStyle(fontSize: 18.0)),
        Text(user.department ?? "", style: TextStyle(fontSize: 18.0)),
        Text(user.role ?? "", style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 20),
        Text(user.email ?? "", style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: () => {},
            //   child: Text(
            //     "Change Password",
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     shape: const StadiumBorder(),
            //     backgroundColor:
            //         Color.fromARGB(255, 132, 132, 132), // Warna disesuaikan
            //   ),
            // ),
            // SizedBox(width: 40),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.red, // Warna disesuaikan
              ),
            )
          ],
        )
      ],
    );
  }

  void _logout(BuildContext context) async {
    final box = GetStorage();
    box.remove("currentUser");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
