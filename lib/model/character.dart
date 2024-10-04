class Character {
  final String id;
  final String name;
  final List<String>? alternateNames;
  final String? species;
  final String? gender;
  final String? house;
  final String? dateOfBirth;
  final int? yearOfBirth;
  final bool? wizard;
  final String? ancestry;
  final String? eyeColour;
  final String? hairColour;
  final Map<String, dynamic>? wand;
  final String? patronus;
  final bool? hogwartsStudent;
  final bool? hogwartsStaff;
  final String? actors;
  final List<String>? alternateActors;
  final bool? alive;
  final String? image;

  Character({
    required this.id,
    required this.name,
    this.alternateNames,
    this.species,
    this.gender,
    this.house,
    this.dateOfBirth,
    this.yearOfBirth,
    this.wizard,
    this.ancestry,
    this.eyeColour,
    this.hairColour,
    this.wand,
    this.patronus,
    this.hogwartsStudent,
    this.hogwartsStaff,
    this.actors,
    this.alternateActors,
    this.alive,
    this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      alternateNames: (json['alternate_names'] as List?)?.map((e) => e as String).toList() ?? [],
      species: json['species'],
      gender: json['gender'],
      house: json['house'],
      dateOfBirth: json['dateOfBirth'],
      yearOfBirth: json['yearOfBirth'],
      wizard: json['wizard'] == true,
      ancestry: json['ancestry'],
      eyeColour: json['eyeColour'],
      hairColour: json['hairColour'],
      wand: json['wand'] as Map<String, dynamic>?,
      patronus: json['patronus'],
      hogwartsStudent: json['hogwartsStudent'] == true,
      hogwartsStaff: json['hogwartsStaff'] == true,
      actors: json['actors'],
      alternateActors: (json['alternate_actors'] as List?)?.map((e) => e as String).toList() ?? [],
      alive: json['alive'] == true,
      image: json['image'],
    );
  }
}