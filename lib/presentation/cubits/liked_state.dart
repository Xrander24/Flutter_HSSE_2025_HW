part of 'liked_cubit.dart';

class LikedState extends Equatable {
  final List<Cat> likedCats;
  final String? filteredBreed;

  const LikedState({required this.likedCats, required this.filteredBreed});

  factory LikedState.initial() =>
      const LikedState(likedCats: [], filteredBreed: null);

  LikedState copyWith({
    List<Cat>? likedCats,
    Object? filteredBreed = _noValue,
  }) {
    final updatedCats = likedCats ?? this.likedCats;

    final updatedBreed =
        identical(filteredBreed, _noValue)
            ? (updatedCats.any((cat) => cat.breed == this.filteredBreed)
                ? this.filteredBreed
                : null)
            : filteredBreed as String?;

    return LikedState(likedCats: updatedCats, filteredBreed: updatedBreed);
  }

  static const _noValue = Object();

  List<Cat> get filteredCats {
    if (filteredBreed == null) return likedCats;
    return likedCats.where((c) => c.breed == filteredBreed).toList();
  }

  @override
  List<Object?> get props => [likedCats, filteredBreed];
}
