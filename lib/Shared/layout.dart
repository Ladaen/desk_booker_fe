import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/booking_history.dart';
import '../widgets/dashboard.dart';
import '../widgets/dashboard_admin.dart';
import '../widgets/desk_booking.dart';
import '../widgets/login.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/user_profile.dart';
import 'app_bar.dart';
import 'footer.dart';

final box = GetStorage();

class DefaultLayout extends StatefulWidget {
  final UserModel? user;
  DefaultLayout(this.user);

  @override
  _DefaultLayoutState createState() => _DefaultLayoutState(user);
}

class _DefaultLayoutState extends State<DefaultLayout> {
  UserModel? user;
  int selectedIndex = 0;
  String userRole = "Admin";
  List<Widget> screens = [];

  _DefaultLayoutState(this.user);

  void onClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) return LoginPage();
    userRole = user?.role ?? "User";
    screens.addAll([
      Dashboard(),
      DeskBooking(),
      BookingHistory(),
      UserProfile(user as UserModel),
    ]);
    if (userRole == "Admin") screens.add(AdminDashboard());
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: DefaultAppBar().build(),
        body: screens.elementAt(selectedIndex),
        //drawer: SideMenu(),
        bottomNavigationBar: Footer(
          selectedIndex: selectedIndex,
          onClicked: onClicked,
          isAdmin: userRole == "Admin",
        ));
  }
}
