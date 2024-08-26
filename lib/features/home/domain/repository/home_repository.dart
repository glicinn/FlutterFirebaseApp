import 'dart:io';

import 'package:firebaseapp/features/home/domain/entity/car_entity.dart';

abstract interface class HomeRepository{
  Future<bool> registerWithEmailAndPassword(String email, String password);
  Future<bool> signInWithEmailAndPassword(String email, String password);
  Future<List<CarEntity>> getFirestoreData();
  Future<void> add(String brand, String category, String model, String quality);
  Future<void> update(String doc, String brand, String category, String model, String quality);
  Future<void> delete(String doc);
  Future<CarEntity?> getFirestoreDataById(String docId);
  Future<String?> getImageUrlByName(String imageName);
  Future<String?> addImageUrlByName(String imageName, File imageFile);
}