import 'package:firebaseapp/dj/service.dart';
import 'package:firebaseapp/features/home/presentation/controller/home_controller.dart';
import 'package:firebaseapp/features/home/presentation/ui/cars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Update extends StatelessWidget {
  final String id;

  const Update({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => service<HomeController>()..initGetId(id),
      child: _Update(id: id),
    );
  }
}

class _Update extends StatelessWidget {
  final String id;

  const _Update({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final car = context.watch<HomeController>().car;
    final _brandController = TextEditingController(text: car?.brand);
    final _modelController = TextEditingController(text: car?.model);
    final _categoryController = TextEditingController(text: car?.category);
    final _qualityController = TextEditingController(text: car?.quality);
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
                service<HomeController>().initUpdate(
                  id,
                  _brandController.text,
                  _categoryController.text,
                  _modelController.text,
                  _qualityController.text
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cars()),
                );
              },
              child: Text('Изменить'),
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
