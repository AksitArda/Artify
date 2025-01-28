import 'dart:convert';
import 'package:artify/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isFavorite = false;

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

  Future<void> fetchPhoto(String photoId) async {
    final url = 'http://2.58.85.87:4001/image/$photoId';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          imageUrl = "http://2.58.85.87:4001/" + data['imageSlug'];
          imageTitle = data['imageTitle'];
          imageDesc = data['imageDesc'];
          userName = data['userName'];
          isFavorite = data['isFavorite'] ?? false;
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

  Future<void> toggleFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final url = 'http://2.58.85.87:4001/favorites/toggle';
    final body = jsonEncode({
      "photoId": widget.photoId,
      "userToken": prefs.getString("authToken").toString()
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          isFavorite = data['isFavorite'];
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 36, 36),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 36, 36, 36),
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
            ? CircularProgressIndicator(
          color: Colors.deepPurpleAccent,
          strokeWidth: 4.0,
        )
            : errorMessage.isNotEmpty
            ? Text(
          errorMessage,
          style: TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        )
            : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: imageUrl.isNotEmpty
                      ? LayoutBuilder(
                    builder: (context, constraints) {
                      return Image.network(
                        imageUrl,
                        fit: BoxFit.contain, // This makes the image responsive
                        height: constraints.maxHeight * 0.6, // 60% of screen height
                        width: constraints.maxWidth, // Full screen width
                      );
                    },
                  )
                      : Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        "No image available",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  imageTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  imageDesc,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Gönderen: $userName",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: toggleFavorite,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                    color: isFavorite ? Colors.red : Colors.grey[800],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        isFavorite ? "Favorited" : "Add to Favorites",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
