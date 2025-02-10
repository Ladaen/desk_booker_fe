import 'package:flutter/material.dart';

class DefaultAppBar extends AppBar {
  AppBar build() {
    // TODO: implement build
    return AppBar(
      backgroundColor: Colors.lightBlueAccent,
      automaticallyImplyLeading: false,
      title: ListBody(
        children: [
          Text(
            'Book',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Quicksand"),
          ),
          Text(
            'Desker',
            style: TextStyle(
                fontSize: 20,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontFamily: "Quicksand"),
          ),
        ],
      ),
      // actions: [
      //   IconButton(
      //     icon: Icon(
      //       Icons.notifications,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       // Aksi ketika tombol notifikasi ditekan
      //     },
      //   ),
      // ],
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(4.0),
      //   child: Container(
      //     color: Colors.white,
      //     height: 4.0,
      //   ),
      // ),
    );
  }
}
