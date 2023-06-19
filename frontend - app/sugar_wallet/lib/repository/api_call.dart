import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sugar_wallet/controller/user.dart';
import 'package:sugar_wallet/screens/homepage_screen.dart';

class APICall {
  final AuthController controller = Get.find<AuthController>();
  Future<bool> loginAPI(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://api-sugarwallet.onrender.com/auth/login'),
      body: {
        "username": username,
        "password": password,
      },
    );


    if (response.statusCode == 200) {
      controller.city = jsonDecode(response.body)['city'];
      controller.token = jsonDecode(response.body)['_id'];
      if(controller.token != null) {
        Get.off(() => const Homepage());
      } else {
        Get.snackbar("Login Failed", jsonDecode(response.body)['detail']);
      }
      return true;
    } else {
      print(jsonDecode(response.body));
      return false;
    }
  }

  Future<bool> registerAPI(String username, String password,) async {
    final response = await http.post(
        Uri.parse('https://api-sugarwallet.onrender.com/auth/register'),
        body: {
          "username": username,
          "password": password,
          "city": "Banglore",
          "isAppUser": 'true',
        });

    if (response.statusCode == 200) {
      print(response.body);
      controller.token = jsonDecode(response.body)['_id'];
      if(controller.token != null) {
        Get.off(() => const Homepage());
      } else {
        Get.snackbar("Login Failed", jsonDecode(response.body)['detail']);
      }
      return true;
    } else {
      print(jsonDecode(response.body));
      return false;
    }
  }

  getCities() async {
    final response = await http.get(
      Uri.parse('https://api-sugarwallet.onrender.com/app/cities'),
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(jsonDecode(response.body));
    }
  }

  getData(String city) async {
    final response = await http.get(
      Uri.parse('https://api-sugarwallet.onrender.com/app/data?location=$city'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      controller.data = jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body));
    }
  }

  modifyCity(String city, String token) async {
    final response = await http.patch(
      Uri.parse('https://api-sugarwallet.onrender.com/auth/user'),
      headers: {
        'Authorization' : "Bearer $token"
      },
      body: {
        "city": city
      }
    );

    if (response.statusCode == 200) {
      print(response.body);
      controller.city = city;
    } else {
      print(jsonDecode(response.body));
    }
  }
}
