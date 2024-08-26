import 'dart:io';

import 'package:firebaseapp/features/home/data/data_source/home_local_data_source.dart';
import 'package:firebaseapp/features/home/data/mappers/car_mapper.dart';
import 'package:firebaseapp/features/home/domain/entity/car_entity.dart';
import 'package:firebaseapp/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{
final  HomeLocalDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});

  @override
  Future<bool> registerWithEmailAndPassword(String email, String password) async {
    return await dataSource.registerWithEmailAndPassword(email, password);
  }

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    return await dataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<List<CarEntity>> getFirestoreData() async {
    final data = await dataSource.getFirestoreData();
    return data.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> add(String brand, String category, String model, String quality) async {
    return await dataSource.add(brand, category, model, quality);
  }

  @override
  Future<void> update(String doc, String brand, String category, String model, String quality) async {
    return await dataSource.update(doc, brand, category, model, quality);
  }

  @override
  Future<void> delete(String doc) async {
    return await dataSource.delete(doc);
  }

  @override
  Future<CarEntity?> getFirestoreDataById(String docId) async {
    final data = await dataSource.getFirestoreDataById(docId);
    return data?.toEntity();
  }

  @override
  Future<String?> getImageUrlByName(String imageName) async {
    return await dataSource.getImageUrlByName(imageName);
  }

  @override
  Future<String?> addImageUrlByName(String imageName, File imageFile) async {
    return await dataSource.addImageUrlByName(imageName, imageFile);
  }
}