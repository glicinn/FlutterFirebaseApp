import 'package:firebaseapp/dj/service.dart';
import 'package:firebaseapp/features/home/presentation/controller/home_controller.dart';
import 'package:firebaseapp/features/home/presentation/ui/cars.dart';
import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _brandController = TextEditingController();
    final _modelController = TextEditingController();
    final _categoryController = TextEditingController();
    final _qualityController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _brandController,
              decoration: InputDecoration(
                labelText: 'Марка',
              ),
            ),
            TextField(
              controller: _modelController,
              decoration: InputDecoration(
                labelText: 'Модель',
              ),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Категория',
              ),
            ),
            TextField(
              controller: _qualityController,
              decoration: InputDecoration(
                labelText: 'Качество',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                service<HomeController>().initAdd(
                  _brandController.text,
                  _categoryController.text,
                  _modelController.text,
                  _qualityController.text,
                );
              },
              child: Text('Добавить'),
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
