import 'package:flutter/material.dart';
import 'dashboard_admin.dart'; // Pastikan import sesuai dengan struktur proyek Anda

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
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
        const Text(
          "Book Desker",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const Text("Masukkan kredensial Anda untuk masuk"),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
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
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Tambahkan logika autentikasi di sini sebelum navigasi
            // Contoh sederhana: hanya navigasi tanpa autentikasi
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardAdmin()),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFF71D4FE), // Warna disesuaikan
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
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
}
