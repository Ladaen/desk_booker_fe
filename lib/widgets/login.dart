import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frondend_project_uas/helpers/string_helper.dart';
import 'package:frondend_project_uas/models/user_model.dart';
import 'package:get_storage/get_storage.dart';
import '../Shared/layout.dart';
import '../services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});
  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = "";
  var _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(113, 212, 254, 1),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 60),
              _header(context),
              _inputField(context),
              // _forgotPassword(context),
              // _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(
            maxHeight: 200.0,
            maxWidth: double.infinity,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset(
            'assets/images/Logo.png',
            fit: BoxFit.cover,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Book',
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Quicksand"),
            ),
            Text(
              'Desker',
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Quicksand"),
            ),
          ],
        ),
        const Text("Masukkan kredensial Anda untuk masuk"),
        SizedBox(height: 10,)
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || !value.isValidEmail()) {
                return 'Please enter a valid email';
              }
              return null;
            },
            onSaved: (value) {
              _enteredEmail = value!;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.lock),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
            onSaved: (value) {
              _enteredPassword = value!;
            },
          ),
          const SizedBox(height: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ElevatedButton(
              onPressed: () => _isSending ? null : _loginForm(),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF71D4FE), // Warna disesuaikan
              ),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ])
        ],
      ),
    );
  }

  void _loginForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });

      final box = GetStorage();

      UserModel loginResult;
      try {
        loginResult =
            await LoginService().loginUser(_enteredEmail, _enteredPassword);
      } catch (e) {
        _showMyDialog(e.toString());
        setState(() {
          _isSending = false;
        });

        return;
      }

      box.write("currentUser", loginResult.toJson());

      if (!context.mounted) {
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DefaultLayout(loginResult)),
      );
    }
  }

  Widget _forgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Tambahkan fungsi untuk lupa kata sandi di sini
      },
      child: const Text(
        "Lupa kata sandi?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Belum punya akun? "),
        TextButton(
          onPressed: () {
            // Tambahkan fungsi untuk navigasi ke halaman pendaftaran di sini
          },
          child: const Text(
            "Daftar",
            style: TextStyle(color: Colors.purple),
          ),
        )
      ],
    );
  }

  Future<void> _showMyDialog(String errorMessage) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
    ));
  }
}
