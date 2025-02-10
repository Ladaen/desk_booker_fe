import 'package:flutter/material.dart';
import 'package:frondend_project_uas/helpers/date_helper.dart';
import 'package:frondend_project_uas/models/booking_model.dart';
import 'package:frondend_project_uas/services.dart';
import 'package:get_storage/get_storage.dart';

import 'desk_booking_stack.dart';

class DeskBookingChooseSeat extends StatefulWidget {
  DateTime bookingDate;
  DeskBookingChooseSeat(this.bookingDate);
  @override
  State<DeskBookingChooseSeat> createState() {
    return _DeskBookingChooseSeatState(bookingDate);
  }
}

class _DeskBookingChooseSeatState extends State<DeskBookingChooseSeat> {
  final _formKey = GlobalKey<FormState>();
  DateTime bookingDate;
  bool _isSending = false;
  late String seatFloor;
  late String seatCode;

  late Widget deskBookingStack;

  _DeskBookingChooseSeatState(this.bookingDate) {
    deskBookingStack = DeskBookingStack(bookingDate, _SeatButtonSelected);
  }

  TextEditingController seatCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    seatFloor = "10th Floor";

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Desk Booking",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      deskBookingStack,
                      SizedBox(height: 16.0),
                      Text(
                        'Booking Date',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.grey.withOpacity(0.5),
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                        style: TextStyle(),
                        initialValue: bookingDate.toFormattedString(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Choose Date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Floor',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.grey.withOpacity(0.5),
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                        style: TextStyle(),
                        initialValue: seatFloor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Choose a Floor';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Seat Number',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: seatCodeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.grey.withOpacity(0.5),
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                        style: TextStyle(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Choose a Desk to be Booked';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _isSending ? null : _submitBooking(),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Confirm Booking",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 26),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color.fromRGBO(
                                19, 15, 38, 1), // Warna disesuaikan
                          ),
                        ),
                      )
                    ],
                  ),
                ))));
  }

  void _submitBooking() async {
    if (!_isSending && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });

      BookingModel response;
      try {
        response = await BookingService().createBooking(new BookingModel(
            bookingBy: GetStorage().read("currentUser")["name"],
            seatCode: seatCode,
            bookingDate: bookingDate,
            createdBy: GetStorage().read("currentUser")["email"],
            updated: DateTime.now()));
      } catch (e) {
        // _showMyDialog();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        setState(() {
          _isSending = false;
        });

        return;
      }

      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Booking for " + bookingDate.toFormattedString() + " successfully created"),
      ));
      Navigator.pop(context);
    }
  }

  void _SeatButtonSelected(String selectedSeatCode) {
    setState(() {
      seatCode = selectedSeatCode;
    });
    seatCodeController.text = selectedSeatCode;
  }
}
