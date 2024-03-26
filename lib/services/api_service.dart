import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallfaper/constants/api_constants.dart';
import 'package:wallfaper/models/wallpaper_model.dart';

class ApiService {
  Future<void> fetch() async {
    var request = http.Request(
      'GET',
      Uri.parse(ApiConstants.baseUrl),
    );
    request.headers.addAll(ApiConstants.headers);
    http.StreamedResponse response = await request.send();
    debugPrint(response.statusCode == 200
        ? await response.stream.bytesToString()
        : response.reasonPhrase);
  }

  Future<WallpaperModel?> getWallpaper() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return wallpaperModelFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
