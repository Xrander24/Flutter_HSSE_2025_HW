import 'package:hsse_cat_tinder/domain/entities/cat_entity.dart';

abstract class CatRepository {
  Future<List<Cat>> fetchCats();
}
