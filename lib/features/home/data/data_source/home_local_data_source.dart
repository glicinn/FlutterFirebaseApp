import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseapp/features/home/data/model/car_model.dart';

abstract interface class HomeLocalDataSource {
  Future<bool> registerWithEmailAndPassword(String email, String password);
  Future<bool> signInWithEmailAndPassword(String email, String password);
  Future<List<CarModel>> getFirestoreData();
  Future<void> add(String brand, String category, String model, String quality);
  Future<void> update(String doc, String brand, String category, String model, String quality);
  Future<void> delete(String doc);
  Future<CarModel?> getFirestoreDataById(String docId);
  Future<String?> getImageUrlByName(String imageName);
  Future<String?> addImageUrlByName(String imageName, File imageFile);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<bool> registerWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print("Ошибка регистрации: $e");
      return false;
    }
  }

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print("Ошибка входа: $e");
      return false;
    }
  }

  @override
  Future<List<CarModel>> getFirestoreData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('car').get();
      return querySnapshot.docs.map((doc) => CarModel.fromDocumentSnapshot(doc)).toList();
    } catch (e) {
      print("Ошибка получения данных из Firestore: $e");
      return [];
    }
  }

  @override
  Future<void> add(String brand, String category, String model, String quality){
    final car = _firestore.collection("car");

    return car.add(
      {
      'brand': brand,
      'category': category,
      'model': model,
      'quality': quality
      },
    )
    .then((value) =>("Car добавлена"));
  }

  @override
  Future<void> update(String doc, String brand, String category, String model, String quality){
    final car = _firestore.collection("car");

    return car
    .doc(doc)
    .set(
      {
      'brand': brand,
      'category': category,
      'model': model,
      'quality': quality
      },
    )
    .then((value) =>("Car изменена"));
  }

  @override
  Future<void> delete(String doc){
    final car = _firestore.collection("car");

    return car
    .doc(doc)
    .delete()
    .then((value) =>("Car удалена"));
  }

  @override
  Future<CarModel?> getFirestoreDataById(String docId) async {
    try {
      DocumentSnapshot docSnapshot = await _firestore.collection('car').doc(docId).get();
      if (docSnapshot.exists) {
        return CarModel.fromDocumentSnapshot(docSnapshot);
      } else {
        print("Документ с ID $docId не найден");
        return null;
      }
    } catch (e) {
      print("Ошибка получения данных из Firestore: $e");
      return null;
    }
  }

  @override
  Future<String?> getImageUrlByName(String imageName) async {
    String imagePath = '$imageName.jpg';
    Reference ref = _storage.ref().child(imagePath);
    String url = await ref.getDownloadURL();
    return url;
  }

  @override
  Future<String?> addImageUrlByName(String imageName, File imageFile) async {
    try {
      String imagePath = '$imageName';
      Reference ref = _storage.ref().child(imagePath);
      await ref.putFile(imageFile);
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Ошибка при добавлении изображения в Firebase Storage: $e');
      return null;
    }
  }
}
