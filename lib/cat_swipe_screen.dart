import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import './cat_service.dart';
import './cat_detail_screen.dart';
import './cat.dart';
import './like_dislike_button.dart';

class CatSwipeScreen extends StatefulWidget {
  const CatSwipeScreen({super.key});

  @override
  CatSwipeScreenState createState() => CatSwipeScreenState();
}

class CatSwipeScreenState extends State<CatSwipeScreen> {
  final CatService _catService = CatService();
  final List<Cat> _cats = [];
  final CardSwiperController _swiperController = CardSwiperController();

  int _likedCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCats();
  }

  Future<void> _loadCats() async {
    List<Cat> newCats = await _catService.fetchCats();
    setState(() {
      _cats.addAll(newCats);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
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
      body:
          _cats.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Text(
                    "Лайкнуто котов: $_likedCount",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  Expanded(
                    child: CardSwiper(
                      controller: _swiperController,
                      cardsCount: _cats.length,
                      allowedSwipeDirection:
                          const AllowedSwipeDirection.symmetric(
                            horizontal: true,
                          ),
                      onSwipe: (previousIndex, currentIndex, direction) {
                        if (direction == CardSwiperDirection.right) {
                          setState(() {
                            _likedCount++;
                          });
                        }
                        if (_cats.length - currentIndex! <= 3) {
                          _loadCats();
                        }
                        return true;
                      },
                      cardBuilder: (
                        context,
                        index,
                        percentThresholdX,
                        percentThresholdY,
                      ) {
                        final cat = _cats[index];
                        return GestureDetector(
                          onTap: () => _showCatDetails(cat),
                          child: Card(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      cat.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      cat.breed,
                                      style: TextStyle(fontSize: 20),
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
                    onLike: () {
                      _swiperController.swipe(CardSwiperDirection.right);
                    },
                    onDislike: () {
                      _swiperController.swipe(CardSwiperDirection.left);
                    },
                  ),
                ],
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
