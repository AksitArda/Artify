import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
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

    final uri = Uri.parse("http://192.168.1.80:3000/uploadImage");
    var request = http.MultipartRequest('POST', uri);

    request.fields['userName'] = _usernameController.text;
    request.fields['imageTitle'] = _imageTitleController.text;
    request.fields['imageDesc'] = _imageDescController.text;

    var file = await http.MultipartFile.fromPath('file', _image!.path);
    request.files.add(file);
    
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Resim başarıyla yüklendi!");
    } else {
      print("Resim yüklenirken bir hata oluştu.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resim Yükleme Sayfası"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir kullanıcı adı girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageTitleController,
                decoration: InputDecoration(labelText: 'Resim Başlığı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir başlık girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageDescController,
                decoration: InputDecoration(labelText: 'Resim Açıklaması'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir açıklama girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Resim Seç'),
              ),
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.file(_image!),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _uploadImage();
                  }
                },
                child: Text('Resmi Yükle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
