import 'dart:io';
import 'dart:typed_data';
import 'package:frondend_project_uas/data_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart' as p;

class ServicesInfo {
  static final String baseUrl =
      dotenv.env['SERVICE_URI'] as String; // Your API base URL
}

class LoginService {
  String baseUrl = ServicesInfo.baseUrl;

  Future<User> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed. Invalid credentials.');
    }
  }
}

class BookingService {
  String baseUrl = ServicesInfo.baseUrl;

  Future<Booking> createBooking(Booking booking) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(booking.toJson()),
    );

    if (response.statusCode == 201) {
      return Booking.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create booking');
    }
  }

  Future<List<Booking>> getAllBookings() async {
    final response = await http.get(Uri.parse('$baseUrl/bookings'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Booking.fromJson(json)).toList();
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

  Future<Floor> createFloor(Floor floor) async {
    final response = await http.post(
      Uri.parse('$baseUrl/floors'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(floor.toJson()),
    );

    if (response.statusCode == 201) {
      return Floor.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create floor');
    }
  }

  Future<Floor> getFloorById(int floorId) async {
    final response = await http.get(Uri.parse('$baseUrl/floors/$floorId'));

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      final floor = Floor.fromJson(json);

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
    } else {
      throw Exception('Failed to fetch floor');
    }
  }

  Future<List<Floor>> getAllFloors() async {
    final response = await http.get(Uri.parse('$baseUrl/floors'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Floor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch floors');
    }
  }

  Future<void> updateFloor(Floor floor) async {
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

  Future<Seat> createSeat(Seat seat) async {
    final response = await http.post(
      Uri.parse('$baseUrl/seats'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(seat.toJson()),
    );

    if (response.statusCode == 201) {
      return Seat.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create seat');
    }
  }

  Future<Seat> getSeatById(int seatId) async {
    final response = await http.get(Uri.parse('$baseUrl/seats/$seatId'));

    if (response.statusCode == 200) {
      return Seat.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch seat');
    }
  }

  Future<List<Seat>> getAllSeats() async {
    final response = await http.get(Uri.parse('$baseUrl/seats'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Seat.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch seats');
    }
  }

  Future<void> updateSeat(Seat seat) async {
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
