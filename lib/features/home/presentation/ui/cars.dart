import 'package:firebaseapp/dj/service.dart';
import 'package:firebaseapp/features/home/presentation/controller/home_controller.dart';
import 'package:firebaseapp/features/home/presentation/ui/ByID.dart';
import 'package:firebaseapp/features/home/presentation/ui/add.dart';
import 'package:firebaseapp/features/home/presentation/ui/addImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cars extends StatelessWidget {
  const Cars({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => service<HomeController>()..initGet(),
      child: _Cars()
    );
  }
}

class _Cars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: context.watch<HomeController>().carList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(context.watch<HomeController>().carList[index].brandModel),
                        subtitle: Text(
                            "${context.watch<HomeController>().carList[index].categoryQuality}"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ByID(id: context.watch<HomeController>().carList[index].id)),
                            );
                          },
                          child: Text('Подробнее')
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddImage(id: context.watch<HomeController>().carList[index].id)),
                            );
                          },
                          child: Text('Добавить изображение')
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Add()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

