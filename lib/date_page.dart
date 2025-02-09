import 'package:flutter/material.dart';

class DatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text('Date Page'),
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman Date',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}