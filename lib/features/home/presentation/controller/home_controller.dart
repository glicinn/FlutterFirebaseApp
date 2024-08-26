
import 'dart:io';

import 'package:firebaseapp/features/home/domain/entity/car_entity.dart';
import 'package:firebaseapp/features/home/domain/use_case/home_use_case.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  final HomeUseCase useCase;

  HomeController(this.useCase);

  List<CarEntity> carList = [];

  CarEntity? car;

  Future<bool> initReg(String email, String password) async {
    bool success = await useCase.callReg(email, password);
    notifyListeners();
    return success;
  }

  Future<bool> initAuth(String email, String password) async {
    bool success = await useCase.callAuth(email, password);
    notifyListeners();
    return success;
  }

  void initGet() async {
    carList = await useCase.callGet();
    notifyListeners();
  }

  void initAdd(String brand, String category, String model, String quality) async {
    await useCase.callAdd(brand, category, model, quality);
    notifyListeners();
  }

  void initUpdate(String doc, String brand, String category, String model, String quality) async {
    await useCase.callUpdate(doc, brand, category, model, quality);
    notifyListeners();
  }

  void initDelete(String doc) async {
    await useCase.callDelete(doc);
    notifyListeners();
  }

  void initGetId(String docId) async {
    car = await useCase.callGetId(docId);
    notifyListeners();
  }

  Future<String?> initImage(String imageName) async {
    String? url = await useCase.callImage(imageName);
    notifyListeners();
    return url;
  }

  void initAddImage(String imageName, File imageFile) async {
    await useCase.callAddImage(imageName, imageFile);
    notifyListeners();
  }
}