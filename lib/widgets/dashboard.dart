import 'package:flutter/material.dart';
import 'package:frondend_project_uas/services.dart';
import 'package:frondend_project_uas/widgets/booking_feed.dart';
import 'package:get_storage/get_storage.dart';
import '../Shared/app_bar.dart';
import '../Shared/footer.dart';
import '../models/booking_model.dart';
import 'news_feed.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    List<Widget> DashboardChildren = [];

    final userEmail = GetStorage().read("currentUser")["email"] as String;
    return FutureBuilder(
        future: BookingService.getBookingHistory(userEmail),
        builder: (ctx, snapshot) {
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

          var bookingData = snapshot.data as List<BookingModel>;

          if (bookingData.length > 0)
            DashboardChildren.addAll(
                [SizedBox(height: 20), BookingFeed(bookingData)]);

          DashboardChildren.addAll([SizedBox(height: 20), NewsFeed()]);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                    Container(
                      width: screenWidth, // Menggunakan lebar layar penuh
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/kantor.JPEG'),
                          fit: BoxFit.cover, // Menutupi kontainer
                        ),
                      ),
                    )
                  ] +
                  DashboardChildren,
            ),
          );
        });
  }
}
