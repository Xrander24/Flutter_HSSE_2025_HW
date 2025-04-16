class Cat {
  final String id;
  final String imageUrl;
  final String breed;
  final String description;
  final DateTime? likedAt;

  Cat({
    required this.id,
    required this.imageUrl,
    required this.breed,
    required this.description,
    this.likedAt,
  });

  Cat copyWith({
    String? id,
    String? imageUrl,
    String? breed,
    String? description,
    DateTime? likedAt,
  }) {
    return Cat(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      breed: breed ?? this.breed,
      description: description ?? this.description,
      likedAt: likedAt ?? this.likedAt,
    );
  }
}
