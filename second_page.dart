import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Uint8List? _imageBytes;
  bool _isSubmitted = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await showDialog<XFile?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Sumber Gambar'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(await picker.pickImage(source: ImageSource.gallery));
              },
              child: Text('Galeri'),
            ),
          ],
        );
      },
    );

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = imageBytes;
        _isSubmitted = false;  
      });
    }
  }

  void _submitImage() {
    setState(() {
      _isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Gambar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Silakan upload gambar Anda',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: _pickImage,
              child: _imageBytes == null
                  ? Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                        size: 100,
                      ),
                    )
                  : Image.memory(
                      _imageBytes!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _imageBytes != null ? _submitImage : null,
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            _isSubmitted && _imageBytes != null
                ? Image.memory(
                    _imageBytes!,
                     width: 200,
                      height: 200,
                    fit: BoxFit.contain,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
