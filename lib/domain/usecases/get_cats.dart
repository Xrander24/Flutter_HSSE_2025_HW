import 'package:hsse_cat_tinder/domain/entities/cat_entity.dart';
import 'package:hsse_cat_tinder/domain/repositories/cat_repository.dart';

class GetCats {
  final CatRepository repo;

  GetCats(this.repo);

  Future<List<Cat>> call() {
    return repo.fetchCats();
  }
}
