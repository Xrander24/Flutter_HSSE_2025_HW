class Cat {
  final String id;
  final String imageUrl;
  final String breed;
  final String description;

  Cat({
    required this.id,
    required this.imageUrl,
    required this.breed,
    required this.description,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      imageUrl: json['url'],
      breed: json['breeds'].isNotEmpty ? json['breeds'][0]['name'] : 'Unknown',
      description:
          json['breeds'].isNotEmpty ? json['breeds'][0]['description'] : '',
    );
  }
}
