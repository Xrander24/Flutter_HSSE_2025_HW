import 'package:intl/intl.dart';
import 'package:hsse_cat_tinder/domain/entities/cat_entity.dart';

extension CatFormatting on Cat {
  String get likedAtFormatted {
    if (likedAt == null) return "";
    return DateFormat('dd.MM.yyyy HH:mm').format(likedAt!);
  }
}
