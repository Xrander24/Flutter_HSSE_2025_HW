import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'package:hsse_cat_tinder/domain/entities/cat_entity.dart';
import 'package:hsse_cat_tinder/di.dart';
import 'package:hsse_cat_tinder/presentation/cubits/liked_cubit.dart';
import 'package:hsse_cat_tinder/presentation/cubits/home_cubit.dart';
import 'package:hsse_cat_tinder/presentation/screens/cat_detail_screen.dart';
import 'package:hsse_cat_tinder/presentation/widgets/like_dislike_button.dart';
import 'package:hsse_cat_tinder/presentation/screens/liked_cats_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..fetchCats(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  final CardSwiperController _swiperController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text('Ошибка сети'),
                  content: Text(state.errorMessage!),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<HomeCubit>().fetchCats();
                      },
                      child: Text('Повторить'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Ок'),
                    ),
                  ],
                ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Cat Tinder',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.grey[800],
        ),
        backgroundColor: Colors.grey[800],
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading && state.cats.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Что-то пошло не так 🐾',
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<HomeCubit>().fetchCats();
                      },
                      icon: Icon(Icons.refresh),
                      label: Text('Повторить'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<LikedCubit, LikedState>(
                      builder: (context, likedState) {
                        return Text(
                          "Лайкнуто котов: ${likedState.likedCats.length}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.list, size: 40),
                      color: Colors.deepPurpleAccent,
                      tooltip: 'Liked cats',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LikedCatsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: CardSwiper(
                    controller: _swiperController,
                    cardsCount: state.cats.length,
                    allowedSwipeDirection:
                        const AllowedSwipeDirection.symmetric(horizontal: true),
                    onSwipe: (prevIndex, currentIndex, direction) {
                      if (direction == CardSwiperDirection.right) {
                        final cat = state.cats[prevIndex];
                        context.read<LikedCubit>().likeCat(cat);
                      }

                      if (state.cats.length - currentIndex! <= 3) {
                        context.read<HomeCubit>().fetchCats();
                      }
                      return true;
                    },
                    cardBuilder: (context, index, percentX, percentY) {
                      final cat = state.cats[index];
                      return GestureDetector(
                        onTap: () => _showCatDetails(cat),
                        child: Card(
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      cat.imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }

                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        context
                                            .read<HomeCubit>()
                                            .setImageLoadError(
                                              'Не удалось загрузить изображение',
                                            );
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    cat.breed,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                LikeDislikeButtons(
                  onLike:
                      () => _swiperController.swipe(CardSwiperDirection.right),
                  onDislike:
                      () => _swiperController.swipe(CardSwiperDirection.left),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showCatDetails(Cat cat) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CatDetailsScreen(cat: cat)),
    );
  }
}
