import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hsse_cat_tinder/domain/entities/cat_entity.dart';

part 'liked_state.dart';

class LikedCubit extends Cubit<LikedState> {
  LikedCubit() : super(LikedState.initial());

  void likeCat(Cat cat) {
    final updatedCats = List<Cat>.from(state.likedCats)
      ..add(cat.copyWith(likedAt: DateTime.now()));
    emit(state.copyWith(likedCats: updatedCats));
  }

  void unlikeCat(String id) {
    final updatedCats = state.likedCats.where((c) => c.id != id).toList();
    emit(state.copyWith(likedCats: updatedCats));
  }

  void selectBreed(String? breed) {
    emit(state.copyWith(filteredBreed: breed));
  }

  void clearFilter() {
    emit(state.copyWith(filteredBreed: null));
  }
}
