import 'package:hsse_cat_tinder/domain/entities/cat_entity.dart';

class CatModel extends Cat {
  CatModel({
    required super.id,
    required super.imageUrl,
    required super.breed,
    required super.description,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'],
      imageUrl: json['url'],
      breed: json['breeds'].isNotEmpty ? json['breeds'][0]['name'] : 'Unknown',
      description:
          json['breeds'].isNotEmpty ? json['breeds'][0]['description'] : '',
    );
  }
}
