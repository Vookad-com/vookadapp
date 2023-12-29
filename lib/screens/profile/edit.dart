import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});



  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {

  final ImagePicker picker = ImagePicker();
  TextEditingController _textController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  String? photoUrl;
  late StreamSubscription<User?> listener;
  bool loading = false;
  @override
  void initState(){
    super.initState();
    _textController.text = auth.currentUser?.displayName ?? "Edit your Name";
    photoUrl = auth.currentUser?.photoURL;
    listener = auth
      .userChanges()
      .listen((User? user) {
        if (user != null) {
          setState(() {
            photoUrl = auth.currentUser?.photoURL;
          });
        }
      });
  }

  @override
  void dispose(){
    super.dispose();
    listener.cancel();
  }

  Future _getImage(BuildContext context) async {
    setState(() {
      loading = true;
    });
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      print('users/${auth.currentUser?.uid}/profilePicture');
      final reference = storage.ref().child('users/${auth.currentUser?.uid}/profilePicture');
      final uploadTask = reference.putFile(File(image.path));

      try {
        await uploadTask;
        String photo = await reference.getDownloadURL();
        setState(() async {
          await auth.currentUser?.updatePhotoURL(photo);
          loading = false;
        });
      } on FirebaseException catch (e) {
        // Handle error
        print(e.message);
      }
    }
  }

  void _saveText() {
    // Implement your logic to save the text here
    // For now, just print a message
    String text = _textController.text;
    auth.currentUser?.updateDisplayName(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          photoUrl == null
                ? const Text('No image selected.')
                : Image.network(
                    photoUrl!,
                    height: 100,
                  ),
           loading?const CircularProgressIndicator():ElevatedButton(
              onPressed: (){_getImage(context);},
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter text'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveText,
              child: const Text('Save Text'),
            ),
          ],
        ),
      ),
    );
  }
}
