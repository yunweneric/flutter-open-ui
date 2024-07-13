class Mountain {
  final int id;
  final String slug;
  final String name;
  final String location;
  final String image;
  final String riv;
  final String description;
  final String bg;
  final String fg;
  final String path;
  final String coordinates;

  Mountain({
    required this.id,
    required this.slug,
    required this.name,
    required this.location,
    required this.image,
    required this.riv,
    required this.description,
    required this.bg,
    required this.fg,
    required this.path,
    required this.coordinates,
  });

  factory Mountain.fromJson(Map<String, dynamic> json) {
    return Mountain(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      location: json['location'],
      image: json['image'],
      riv: json['riv'],
      description: json['description'],
      bg: json['bg'],
      fg: json['fg'],
      path: json['path'],
      coordinates: json['coordinates'],
    );
  }
}
