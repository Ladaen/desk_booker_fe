import 'package:flutter/material.dart';
import 'package:frondend_project_uas/helpers/date_helper.dart';
import 'package:frondend_project_uas/models/booking_model.dart';

import '../services.dart';

class BookingFeed extends StatelessWidget {
  List<BookingModel> bookings;
  late double screenWidth;

  BookingFeed(this.bookings);

  static List<Widget> GetBookingFeedBox(
      BuildContext context, BookingModel bookingModel, double screenWidth) {
    var result = [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color.fromRGBO(19, 15, 38, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth, // Menggunakan lebar layar penuh
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/image.png'),
                    fit: BoxFit.cover, // Menutupi kontainer
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10, bottom: 5),
              child: ListBody(
                children: [
                  Text(
                    'Booked Desk: ' + bookingModel.seatCode,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    'Date',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(
                    bookingModel.bookingDate.toFormattedString(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => cancelBookingConfirmation(
                          context,
                          bookingModel.bookingDate.toFormattedString(),
                          bookingModel.id.toString()),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 10)
    ];
    return result;
  }

  @override
  Widget build(BuildContext context) {
    this.screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Text(
                'My Booking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10)
            ] +
            GetBookingFeedBox(context, bookings.first, screenWidth),
      ),
    );
  }

  static cancelBookingConfirmation(
      BuildContext context, String bookingDate, String BookingId) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes, cancel it"),
      onPressed: () async {
        BookingService.cancelActiveBooking(BookingId)
            .then((value) => {Navigator.of(context).pop()})
            .onError((error, stackTrace) => {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(error.toString()),
                  ))
                });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are You Sure?"),
      content: Text("You like to cancel the booking for " + bookingDate),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
