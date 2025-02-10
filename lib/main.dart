import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frondend_project_uas/Shared/layout.dart';
import 'package:frondend_project_uas/models/user_model.dart';
import 'package:frondend_project_uas/widgets/login.dart';
import 'widgets/dashboard_admin.dart'; // Pastikan import sesuai dengan struktur proyek Anda
import 'package:get_storage/get_storage.dart';

Future main() async {
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    UserModel? currentUser = null;
    final box = GetStorage();

    var storedUser = box.read("currentUser") as Map<String,dynamic>?;
    if (storedUser != null)
      currentUser =
          UserModel.fromJson(storedUser);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultLayout(currentUser),
    );
    // else
    //   return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: const LoginPage(),
    //   );
  }
}
