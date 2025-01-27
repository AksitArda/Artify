import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Images>> fetchImages() async {
  try {
    final response = await http.get(Uri.parse('http://2.58.85.87:4001/images'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList.map((json) => Images.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load images: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Failed to load images: $e');
  }
}

class Images {
  final String id;
  final String imageTitle;
  final String imageDesc;
  final String imageSlug;
  final String userName;

  const Images({
    required this.id,
    required this.imageDesc,
    required this.imageSlug,
    required this.imageTitle,
    required this.userName,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('_id') &&
        json.containsKey('imageTitle') &&
        json.containsKey('imageDesc') &&
        json.containsKey('imageSlug') &&
        json.containsKey('userName')) {
      return Images(
        id: json['_id'] as String,
        imageTitle: json['imageTitle'] as String,
        imageDesc: json['imageDesc'] as String,
        imageSlug: json['imageSlug'] as String,
        userName: json['userName'] as String,
      );
    } else {
      throw const FormatException('Failed to load images.');
    }
  }

}