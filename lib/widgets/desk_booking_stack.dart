import 'package:flutter/material.dart';
import 'package:frondend_project_uas/models/seat_model.dart';
import 'package:frondend_project_uas/services.dart';

class DeskBookingStack extends StatelessWidget {
  DateTime bookingDate;
  late int floor = 10;
  late String department = "HR";
  int? selectedSeatIndex;
  void Function(String) onClickButton;

  DeskBookingStack(this.bookingDate, this.onClickButton);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // FutureBuilder(
    //     future: FloorService().getFloorById(bookingDate,floor,department),
    //     builder: (context, snapshot) {

    //     });
    return FutureBuilder(
        future: SeatService().getAllSeats(bookingDate, floor, department),
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

          var seatModels = snapshot.data as List<SeatModel>;
          return Stack(
            children: <Widget>[
                  // Background image placed in the center of Stack
                  Center(
                    child: Image.asset(
                      'assets/images/Lantai Baru.png', // Ganti dengan path gambar Anda
                      width: screenWidth, // Atur lebar gambar sesuai kebutuhan
                    ),
                  ),
                  // Blue container 50x50 placed on the top of an image
                ] +
                _GetSeats(context, seatModels),
          );
        });
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.green;
    }
    return Colors.blue;
  }

  List<Widget> _GetSeats(BuildContext context, List<SeatModel> seats) {
    List<Widget> widgetList = <Widget>[];
    if (seats.length == 0) {
      seats = <SeatModel>[];
      seats.addAll([
        SeatModel(xCor: 0, yCor: 1, seatCode: "A1"),
        SeatModel(xCor: 200, yCor: 1, seatCode: "A2"),
        SeatModel(xCor: 0, yCor: 21, seatCode: "A3"),
      ]);
    }

    var defButtonStyle = ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(0),
        backgroundColor: Colors.red);

    for (var i = 0; i < seats.length; i++) {
      MaterialStateProperty<Color?>? color =
          MaterialStateProperty.resolveWith(getColor);
      if (!seats[i].isActive) color = defButtonStyle.backgroundColor;
      widgetList.add(new Positioned(
          key: UniqueKey(),
          left: seats[i].xCor.toDouble(),
          top: seats[i].yCor.toDouble(),
          child: SizedBox(
            child: ElevatedButton(
              onPressed: () => seats[i].isActive
                  ? _onPressedButton(
                      i,
                      context,
                      seats[i].seatCode,
                    )
                  : null,
              child: Container(width: 0, height: 0),
              style: ButtonStyle(
                  shape: defButtonStyle.shape,
                  padding: defButtonStyle.padding,
                  backgroundColor: color),
            ),
            height: 30,
            width: 30,
          )));
    }

    return widgetList;
  }

  void _onPressedButton(int index, BuildContext context, String seatCode) {
    onClickButton(seatCode);
  }
}
