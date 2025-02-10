import 'package:flutter/material.dart';
import 'package:frondend_project_uas/helpers/date_helper.dart';
import 'package:get_storage/get_storage.dart';

import '../models/booking_model.dart';
import '../services.dart';

class BookingHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final userEmail = GetStorage().read("currentUser")["email"] as String;
    final screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: BookingService.getBookingHistory(userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }

        if (snapshot.data == null) {
          return const Center(child: Text('No items added yet.'));
        }

        var bookingModel = snapshot.data as List<BookingModel>;
        
        if (bookingModel.length == 0) {
          return const Center(child: Text('No booking history yet.'));
        }

        var firstBooking = bookingModel.first;
    
        return ListView.builder(
            itemCount: bookingModel.length,
            itemBuilder: (ctx, index) => Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(right: 10, left:10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color.fromRGBO(19, 15, 38, 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            index == 0 ? Container(
                              width:
                                  screenWidth, // Menggunakan lebar layar penuh
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/image.png'),
                                    fit: BoxFit.cover, // Menutupi kontainer
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                            ) : SizedBox(height: 5,),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 10, left: 10, bottom: 5),
                              child: ListBody(
                                children: [
                                  Text(
                                    'Booked Desk: ' +
                                        bookingModel[index].seatCode,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  Text(
                                    bookingModel[index]
                                        .bookingDate
                                        .toFormattedString(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ));
      },
    );
  }
}
