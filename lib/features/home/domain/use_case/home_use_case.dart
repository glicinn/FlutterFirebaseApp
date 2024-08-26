import 'dart:io';

import 'package:firebaseapp/features/home/domain/entity/car_entity.dart';
import 'package:firebaseapp/features/home/domain/repository/home_repository.dart';

class HomeUseCase {
  final HomeRepository _repository;

  HomeUseCase(this._repository);

  Future<bool> callReg(String email, String password) async {
    return _repository.registerWithEmailAndPassword(email, password);
  }

  Future<bool> callAuth(String email, String password) async {
    return _repository.signInWithEmailAndPassword(email, password);
  }
    
  Future<List<CarEntity>> callGet() async {
    return _repository.getFirestoreData();
  }

  Future<void> callAdd(String brand, String category, String model, String quality) async {
    return _repository.add(brand, category, model, quality);
  }

  Future<void> callUpdate(String doc, String brand, String category, String model, String quality) async {
    return _repository.update(doc, brand, category, model, quality);
  }

  Future<void> callDelete(String doc) async {
    return _repository.delete(doc);
  }

  Future<CarEntity?> callGetId(String docId) async {
    return _repository.getFirestoreDataById(docId);
  }
  
  Future<String?> callImage(String imageName) async {
    return _repository.getImageUrlByName(imageName);
  }

  Future<String?> callAddImage(String imageName, File imageFile) async {
    return _repository.addImageUrlByName(imageName, imageFile);
  }
}