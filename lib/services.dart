import 'dart:io';
import 'dart:typed_data';
import 'package:frondend_project_uas/models/floor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart' as p;

import 'models/booking_model.dart';
import 'models/seat_model.dart';
import 'models/user_model.dart';

class ServicesInfo {
  static final String baseUrl =
      dotenv.env['SERVICE_URI'] as String; // Your API base URL
}

class LoginService {
  String baseUrl = ServicesInfo.baseUrl;

  Future<UserModel> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed. Invalid credentials.');
    }
  }
}

class BookingService {
  static String baseUrl = ServicesInfo.baseUrl;

  Future<BookingModel> createBooking(BookingModel booking) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(booking.toJson()),
    );

    if (response.statusCode == 201) {
      return BookingModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create booking, ' + response.body);
    }
  }

  static Future<List<BookingModel>> getAllBookings() async {
    final response = await http.get(Uri.parse('$baseUrl/booked-seats'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => BookingModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch bookings');
    }
  }

  static Future<List<BookingModel>> getBookingHistory(String email) async {
    final queryParameters = {'email': email};

    final uri = Uri.http(
        baseUrl.replaceAll("http://", ""), '/booking-history', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => BookingModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch bookings');
    }
  }

  static Future<List<BookingModel>> getActiveBooking(String email) async {
    final queryParameters = {'email': email};

    final uri = Uri.http(baseUrl.replaceAll("http://", ""),
        '/last-booking-history', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
            final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => BookingModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch bookings');
    }
  }

  // Implement update and delete methods similarly
}

Future<void> saveImageToFile(Uint8List imageBytes, String fileName) async {
  final directory =
      Directory('floor_layouts'); // Path to the "floor_layouts" folder
  if (!directory.existsSync()) {
    directory.createSync();
  }

  final file = File('${directory.path}/$fileName');
  await file.writeAsBytes(imageBytes);
  print('Image saved to ${file.path}');
}

class FloorService {
  String baseUrl = ServicesInfo.baseUrl;

  Future<FloorModel> createFloor(FloorModel floor) async {
    final response = await http.post(
      Uri.parse('$baseUrl/floors'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(floor.toJson()),
    );

    if (response.statusCode == 201) {
      return FloorModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create floor');
    }
  }

  Future<FloorModel> getFloorById(int floorId) async {
    final response = await http.get(Uri.parse('$baseUrl/floors/$floorId'));

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      final floor = FloorModel.fromJson(json);

      final directory = Directory('floor_layouts');
      final fileName = p.basename(floor.floorPlanPath);
      final fullFileName = File('${directory.path}/${fileName}');
      DateTime floorPlanLastModified = await fullFileName.lastModified();

      if (floor.floorPlanLastModified != floorPlanLastModified) {
        // Fetch floor plan image
        final imageResponse =
            await http.get(Uri.parse('$baseUrl/floors/$floorId/image'));
        if (imageResponse.statusCode == 200) {
          final imageBytes = imageResponse.bodyBytes;
          saveImageToFile(imageBytes, fileName);
        }
      }

      return floor;
    } else if (response.statusCode == 404) {
      throw HttpException('Floor not found');
    } else {
      throw Exception('Failed to fetch floor');
    }
  }

  Future<List<FloorModel>> getAllFloors() async {
    final response = await http.get(Uri.parse('$baseUrl/floors'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => FloorModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch floors');
    }
  }

  Future<void> updateFloor(FloorModel floor) async {
    final response = await http.put(
      Uri.parse('$baseUrl/floors/${floor.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(floor.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update floor');
    }
  }

  Future<void> uploadFloorLayout(File imageFile) async {
    final url = Uri.parse(
        '$baseUrl/upload-floor-layout'); // Replace with your actual API endpoint

    final request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Floor layout uploaded successfully!');
      } else {
        print(
            'Failed to upload floor layout. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading floor layout: $e');
    }
  }

  Future<void> deleteFloor(int floorId) async {
    final response = await http.delete(Uri.parse('$baseUrl/floors/$floorId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete floor');
    }
  }
}

class SeatService {
  String baseUrl = ServicesInfo.baseUrl;

  Future<SeatModel> createSeat(SeatModel seat) async {
    final response = await http.post(
      Uri.parse('$baseUrl/seats'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(seat.toJson()),
    );

    if (response.statusCode == 201) {
      return SeatModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create seat');
    }
  }

  Future<SeatModel> getSeatById(int seatId) async {
    final response = await http.get(Uri.parse('$baseUrl/seats/$seatId'));

    if (response.statusCode == 200) {
      return SeatModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch seat');
    }
  }

  Future<List<SeatModel>> getAllSeats(
      DateTime bookingDate, int floor, String department) async {
    final queryParameters = {
      'bookingDate': bookingDate.toIso8601String(),
      'department': department,
      'floor': floor.toString()
    };

    final uri = Uri.http(
        baseUrl.replaceAll("http://", ""), '/combined-seats', queryParameters);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<SeatModel> availableSeats =
          (result["availableSeats"] as List<dynamic>)
              .map((json) => SeatModel.fromJson(json))
              .toList();
      final List<SeatModel> bookedSeats =
          (result["bookedSeats"] as List<dynamic>)
              .map((json) => SeatModel.fromJson(json))
              .toList();
      bookedSeats.forEach((element) {
        element.isActive = false;
      });
      return availableSeats + bookedSeats;
    } else {
      throw Exception('Failed to fetch seats');
    }
  }

  Future<void> updateSeat(SeatModel seat) async {
    final response = await http.put(
      Uri.parse('$baseUrl/seats/${seat.seatCode}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(seat.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update seat');
    }
  }

  Future<void> deleteSeat(int seatId) async {
    final response = await http.delete(Uri.parse('$baseUrl/seats/$seatId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete seat');
    }
  }
}
