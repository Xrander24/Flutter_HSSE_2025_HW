import 'package:hsse_cat_tinder/domain/entities/cat_entity.dart';
import 'package:hsse_cat_tinder/domain/repositories/cat_repository.dart';
import 'package:hsse_cat_tinder/data/sources/cat_api_source.dart';

class CatRepositoryImpl implements CatRepository {
  final CatApiSource api;

  CatRepositoryImpl(this.api);

  @override
  Future<List<Cat>> fetchCats() => api.fetchCats();
}
