import 'dart:io';

import 'package:firebaseapp/dj/service.dart';
import 'package:firebaseapp/features/home/presentation/controller/home_controller.dart';
import 'package:firebaseapp/features/home/presentation/ui/cars.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatelessWidget {
  final String id;

  const AddImage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  File imageFile = File(pickedFile.path);
                  service<HomeController>().initAddImage("$id.jpg", imageFile);
                } else {
                  print('Пользователь не выбрал изображение');
                }
              },
              child: Text('Добавить изображение'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cars()),
                );
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}
