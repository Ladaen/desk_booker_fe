import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frondend_project_uas/helpers/date_helper.dart';

import 'desk_booking_choose_seat.dart';

class DeskBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Choose Date',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _DatePressed(context, DateTime.now()),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Text(
                  "Book For Today",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Text(
                  DateTime.now().toFormattedString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor:
                  Color.fromRGBO(19, 15, 38, 1), // Warna disesuaikan
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _DatePressed(
                context, DateTime.now().add(const Duration(days: 1))),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Text(
                  "Book For Tomorrow",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Text(
                  DateTime.now()
                      .add(const Duration(days: 1))
                      .toFormattedString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor:
                  Color.fromRGBO(19, 15, 38, 1), // Warna disesuaikan
            ),
          ),
        ],
      ),
    ));
  }

  void _DatePressed(BuildContext context, DateTime bookingDate) {
    bookingDate = bookingDate.subtract(Duration(
        hours: bookingDate.hour,
        minutes: bookingDate.minute,
        seconds: bookingDate.second,
        milliseconds: bookingDate.millisecond));
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeskBookingChooseSeat(bookingDate))
            );
  }
}
