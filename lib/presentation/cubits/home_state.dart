part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Cat> cats;
  final bool isLoading;
  final String? errorMessage;
  final int generation;

  const HomeState({
    required this.cats,
    required this.isLoading,
    required this.errorMessage,
    required this.generation,
  });

  factory HomeState.initial() => const HomeState(
    cats: [],
    isLoading: false,
    errorMessage: null,
    generation: 0,
  );

  HomeState copyWith({
    List<Cat>? cats,
    bool? isLoading,
    String? errorMessage,
    int? generation,
  }) {
    return HomeState(
      cats: cats ?? this.cats,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      generation: generation ?? this.generation,
    );
  }

  @override
  List<Object?> get props => [cats, isLoading, errorMessage, generation];
}
