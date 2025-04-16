import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hsse_cat_tinder/domain/entities/cat_entity.dart';
import 'package:hsse_cat_tinder/domain/repositories/cat_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CatRepository _catRepository;

  HomeCubit(this._catRepository) : super(HomeState.initial());

  Future<void> fetchCats() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final newCats = await _catRepository.fetchCats();
      emit(
        state.copyWith(
          cats: [...state.cats, ...newCats],
          isLoading: false,
          generation: state.generation + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Не удалось загрузить котов :(',
        ),
      );
    }
  }

  void setImageLoadError(String message) {
    emit(state.copyWith(errorMessage: message));
  }
}
