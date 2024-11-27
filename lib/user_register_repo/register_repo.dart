import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final Dio _dio = Dio();

  final String baseUrl = "http://localhost:3000";

  Future<void> registerUser({
    required String username,
    required String password,required String confirmPassword,
    required String mobileNo,
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "password": password,
        "confirmpassword": confirmPassword,
        "mobileNumber": mobileNo,
        "email": email
      }),
    );

    if (response.statusCode == 200) {
      print("registered successfully");
    } else {
      throw Exception(
        'Failed to register user',
      );
    }
  }

  Future<String?> loginUser(
      {required String email, required String password}) async {
    final response = await http.post(Uri.parse("$baseUrl/login"),
        headers: {"content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("login Successfull");
      return data["user_id"];
    } else {
      throw Exception("Failed to login User");
    }
  }

  Future<String> logout() async{
    final prefs = await SharedPreferences.getInstance();
    final userID =  prefs.getString('user_id');

    if (userID==null){
      throw Exception("userID not found");
    }

    final response = await _dio.post("$baseUrl/logout",
    data: {'user_id':userID},
    );
    if(response.statusCode==200){
      await prefs.remove(userID);
      print("logout:${prefs.remove(userID)}");
      return response.data['message'];
    }else{
      throw Exception("Logout failed:${response.data['error']}");
    }
  }

  Future<List<Map<String, dynamic>>> fetchNewArrivalItems() async {
    try {
      final response = await _dio.get("$baseUrl/getnewarrival");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception("Failed to load items");
      }
    } catch (e) {
      throw Exception("Failed to load items: $e");
    }
  }

  Future<Map<String, dynamic>> fetchNewArrivalItemId(String id) async {
    try {
      final response = await _dio.get("$baseUrl/getnewarrivalitem/$id");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to load items");
      }
    } catch (e) {
      throw Exception("Failed to load items:$e");
    }
  }

  Future<List<dynamic>> fetchCategoryData(String category) async {
    try {
      final response = await _dio.get("$baseUrl/category/$category");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to load items");
      }
    } catch (e) {
      throw Exception("Failed to load items:$e");
    }
  }

  Future<Map<String, dynamic>> fetchCategoryDetailData(
      String category, String id) async {
    try {
      final response = await _dio.get("$baseUrl/category/$category/$id");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Failed to load data:$e");
    }
  }

  Future<List<dynamic>> fetchBrandItems(String brandName) async {
    final response = await _dio.get("$baseUrl/brand/$brandName");
    try {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to load brand items");
      }
    } catch (e) {
      throw Exception("Failed to load data:$e");
    }
  }

  Future<Map<String, dynamic>> fetchBrandDetailsItem(
      String brandName, String id) async {
    final response = await _dio.get("$baseUrl/brand/$brandName/$id");
    try {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Failed to load items:$e");
    }
  }

  Future<void> addToCart(String userId, Map<String, dynamic> itemId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/order/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(itemId),
    );

    if (response.statusCode == 200) {
      // final responseData = jsonDecode(response.body);
      print('Successfully added to cart');
      // return responseData["user_id"];
    } else {
      print('Failed to add to cart: ${response.body}');
      throw Exception('Failed to add to cart');
    }
  }

  Future<Map<String, dynamic>> getCartItems(String userId) async {
    final response = await _dio.get('$baseUrl/order/$userId');

    if (response.statusCode == 200) {
      print("url:$baseUrl/order/$userId");
      print("res:${response.data}");
      return response.data;
    } else {
      throw Exception('Failed to fetch cart items');
    }
  }

  Future<void> removeSingleItemFromCart(String userId, String itemId) async {
    try {
      final response =
          await _dio.delete("$baseUrl/cart/remove/$userId/$itemId");
      if (response.statusCode == 200) {
        print("successfully removed item from cart");
      } else {
        print("Error: ${response.statusCode}");
        throw Exception('Failed to remove item from cart');
      }
    } catch (e) {
      print("DioException: ${e}");
      throw Exception('Error: ${e}');
    }
  }
}
