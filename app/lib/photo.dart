import 'dart:convert';
import 'package:artify/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Photo extends StatefulWidget {
  final String photoId;
  const Photo({Key? key, required this.photoId}) : super(key: key);

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  String imageUrl = "";
  String imageTitle = "";
  String imageDesc = "";
  String userName = "";
  String errorMessage = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    fetchPhoto(widget.photoId);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  // API'den fotoğrafı getiren fonksiyon
  Future<void> fetchPhoto(String photoId) async {
    final url = 'http://2.58.85.87:4001/image/$photoId';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Başarılı istek
        final data = json.decode(response.body);
        setState(() {
          imageUrl = "http://2.58.85.87:4001/" + data['imageSlug'];
          imageTitle = data['imageTitle'];
          imageDesc = data['imageDesc'];
          userName = data['userName'];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Error: Unable to fetch image (Code: ${response.statusCode})";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: ${e.toString()}";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 36, 36),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Main()),
            );
          },
        ),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(color: Colors.deepPurpleAccent)
            : errorMessage.isNotEmpty
            ? Text(
          errorMessage,
          style: TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageUrl.isNotEmpty
                ? Image.network(imageUrl, fit: BoxFit.cover)
                : Text(
              "No image available",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            Text(
              imageTitle,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            Text(
              imageDesc,
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            Text(
              "Gönderen: $userName",
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
