import 'package:cloud_firestore/cloud_firestore.dart';
class CarModel {
  final String id;
  final String brand;
  final String model;
  final String category;
  final String quality;

  CarModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.category,
    required this.quality,
  });

  factory CarModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CarModel(
      id: snapshot.id,
      brand: data['brand'] ?? '',
      model: data['model'] ?? '',
      category: data['category'] ?? '',
      quality: data['quality'] ?? '',
    );
  }
}