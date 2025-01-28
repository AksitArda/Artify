import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Search extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _imageTitleController = TextEditingController();
  final TextEditingController _imageDescController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    final uri = Uri.parse("http://2.58.85.87:4001/uploadImage");
    var request = http.MultipartRequest('POST', uri);

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    request.fields['userName'] = prefs.getString("username").toString();
    request.fields['imageTitle'] = _imageTitleController.text;
    request.fields['imageDesc'] = _imageDescController.text;

    var file = await http.MultipartFile.fromPath('file', _image!.path);
    request.files.add(file);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image uploaded successfully!");
    } else {
      String responseBody = await response.stream.bytesToString();
      print("Mistake! Response body: $responseBody");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _imageTitleController,
              decoration: InputDecoration(labelText: 'Image Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageDescController,
              decoration: InputDecoration(labelText: 'Image Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: _pickImage,
              height: 50,
              color: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: Text(
                  "Select Image",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (_image != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.file(_image!),
              ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _uploadImage();
                }
              },
              height: 50,
              color: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: Text(
                  "Upload Image",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
