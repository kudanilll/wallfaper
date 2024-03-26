import 'package:wallfaper/constants/variables.dart';

class ApiConstants {
  static final headers = {
    'Accept-Language': 'en-US',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Freepik-API-Key': '' // your api key
  };
  static String baseUrl =
      'https://api.freepik.com/v1/resources?locale=en-US&page=$page&limit=$limit&order=latest&term=mobile+wallpaper';
}
