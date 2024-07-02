// test/services_test.dart

import 'dart:ffi';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:frondend_project_uas/services.dart'; // Import your actual service files
import 'package:frondend_project_uas/data_models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await DotEnv().load(fileName: "./.env");
  group('FloorService', () {
    final floorService = FloorService();
    bool hasItErrorYet = false;
    test('Fetch floor by ID', () async {
      final floorId = 12301230;
      try {
        final floor = await floorService.getFloorById(floorId);
      } on HttpException catch (Exception) {
        hasItErrorYet = true;
      }
      expect(hasItErrorYet, true);
    });
    // Add more test cases for other methods
  });

  group('BookingService', () {
    final bookingService = BookingService();

    test('Create booking', () async {
      final newBooking = Booking(
        bookingBy: 'John Doe',
        seatCode: 'A2',
        bookingDate: DateTime.parse('2023-07-11 14:30:00'),
        isActive: true,
        createdBy: 'Admin',
        updated: DateTime.now(),
      );
      final createdBooking = await bookingService.createBooking(newBooking);
      expect(createdBooking.bookingBy, newBooking.bookingBy);
    });

    // Add more test cases for other methods
  });
}
