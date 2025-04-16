import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsse_cat_tinder/presentation/cubits/liked_cubit.dart';
import 'package:hsse_cat_tinder/presentation/extensions/cat_format_extension.dart';

class LikedCatsScreen extends StatelessWidget {
  const LikedCatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: const Text(
          "Liked Cats",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_rounded),
            color: Colors.deepPurpleAccent,
            tooltip: "Очистить фильтр",
            onPressed: () {
              context.read<LikedCubit>().clearFilter();
            },
          ),
        ],
      ),
      body: BlocBuilder<LikedCubit, LikedState>(
        builder: (context, state) {
          final cats = state.filteredCats;
          final allBreeds =
              state.likedCats.map((c) => c.breed).toSet().toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: Colors.grey[850],
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.deepPurpleAccent,
                  value: state.filteredBreed,
                  hint: const Text(
                    "Фильтр по породе",
                    style: TextStyle(color: Colors.white60),
                  ),
                  items:
                      allBreeds.map((breed) {
                        return DropdownMenuItem(
                          value: breed,
                          child: Text(breed),
                        );
                      }).toList(),
                  onChanged: (val) {
                    context.read<LikedCubit>().selectBreed(val);
                  },
                ),
              ),
              Expanded(
                child:
                    cats.isEmpty
                        ? const Center(
                          child: Text(
                            "Нет лайкнутых котиков :(",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 18,
                            ),
                          ),
                        )
                        : ListView.builder(
                          itemCount: cats.length,
                          itemBuilder: (context, index) {
                            final cat = cats[index];
                            return Card(
                              color: Colors.grey[800],
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    cat.imageUrl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, _) => const Icon(
                                          Icons.error,
                                          color: Colors.redAccent,
                                        ),
                                  ),
                                ),
                                title: Text(
                                  cat.breed,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  "Лайк: ${cat.likedAtFormatted}",
                                  style: const TextStyle(color: Colors.white60),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.deepOrangeAccent,
                                  tooltip: "Удалить из лайков",
                                  onPressed: () {
                                    context.read<LikedCubit>().unlikeCat(
                                      cat.id,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          );
        },
      ),
    );
  }
}
