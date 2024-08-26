import 'package:firebaseapp/dj/service.dart';
import 'package:firebaseapp/features/home/presentation/controller/home_controller.dart';
import 'package:firebaseapp/features/home/presentation/ui/cars.dart';
import 'package:firebaseapp/features/home/presentation/ui/update.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ByID extends StatelessWidget {
  final String id;

  const ByID({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => service<HomeController>()..initGetId(id),
      child: _ByID(id: id),
    );
  }
}

class _ByID extends StatelessWidget {
  final String id;

  const _ByID({Key? key, required this.id}) : super(key: key);

  Future<bool> checkImageAvailability(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode == 200;
    } catch (e) {
      print('Ошибка при проверке доступности изображения: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final car = context.watch<HomeController>().car;

    String imageUrl = "https://firebasestorage.googleapis.com/v0/b/fire123-72ffc.appspot.com/o/$id.jpg?alt=media&token";

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<bool>(
              future: checkImageAvailability(imageUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Ошибка: ${snapshot.error}');
                } else if (snapshot.data == true) {
                  return Image.network(
                    imageUrl,
                    width: 100,
                    height: 100,
                  );
                } else {
                  return Text('Изображение недоступно');
                }
              },
            ),
            Text(car?.brandModel ?? ''),
            Text(car?.categoryQuality ?? ''),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Update(id: id)),
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
