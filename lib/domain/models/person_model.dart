class PersonModel {
  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String gender;
  final String homeworld;
  final List<String> films;
  final List<String> species;
  final List<String> vehicles;
  final List<String> starships;
  final DateTime created;
  final DateTime edited;
  final String url;

  PersonModel({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      name: json['name'],
      height: json['height'],
      mass: json['mass'],
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color'],
      birthYear: json['birth_year'],
      gender: json['gender'],
      homeworld: json['homeworld'],
      films: List<String>.from(json['films']),
      species: List<String>.from(json['species']),
      vehicles: List<String>.from(json['vehicles']),
      starships: List<String>.from(json['starships']),
      created: DateTime.parse(json['created']),
      edited: DateTime.parse(json['edited']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'height': height,
      'mass': mass,
      'hair_color': hairColor,
      'skin_color': skinColor,
      'eye_color': eyeColor,
      'birth_year': birthYear,
      'gender': gender,
      'homeworld': homeworld,
      'films': films,
      'species': species,
      'vehicles': vehicles,
      'starships': starships,
      'created': created.toIso8601String(),
      'edited': edited.toIso8601String(),
      'url': url,
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'height': height,
      'mass': mass,
      'hairColor': hairColor,
      'skinColor': skinColor,
      'eyeColor': eyeColor,
      'birthYear': birthYear,
      'gender': gender,
      'homeworld': homeworld,
      'films': films,
      'species': species,
      'vehicles': vehicles,
      'starships': starships,
      'created': created.millisecondsSinceEpoch,
      'edited': edited.millisecondsSinceEpoch,
      'url': url,
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      name: map['name'],
      height: map['height'],
      mass: map['mass'],
      hairColor: map['hair_color'],
      skinColor: map['skin_color'],
      eyeColor: map['eye_color'],
      birthYear: map['birth_year'],
      gender: map['gender'],
      homeworld: map['homeworld'],
      films: List<String>.from(map['films']),
      species: List<String>.from(map['species']),
      vehicles: List<String>.from(map['vehicles']),
      starships: List<String>.from(map['starships']),
      created: DateTime.parse(map['created']),
      edited: DateTime.parse(map['edited']),
      url: map['url'],
    );
  }

  String getTranslatedGender() {
    switch (gender.toLowerCase()) {
      case 'male':
        return 'Male';
      case 'female':
        return 'Female';
      case 'hermaphrodite':
        return 'Hermaphrodite';
      case 'n/a':
        return 'Not Specified';
      default:
        return gender;
    }
  }

  String getImagePath() {
    if (name == 'Luke Skywalker') {
      return 'assets/images/luke.png';
    } else if (name == 'C-3PO') {
      return 'assets/images/c3po.png';
    } else if (name == 'R2-D2') {
      return 'assets/images/r2d2.png';
    } else if (name == 'Leia Organa') {
      return 'assets/images/leia.png';
    } else if (name == 'Darth Vader') {
      return 'assets/images/darth.png';
    } else if (name == 'Han Solo') {
      return 'assets/images/han.png';
    } else if (name == 'Yoda') {
      return 'assets/images/yoda.png';
    } else if (name == 'Chewbacca') {
      return 'assets/images/chewbacca.png';
    } else if (name == 'Boba Fett') {
      return 'assets/images/boba.png';
    } else if (name == 'Obi-Wan Kenobi') {
      return 'assets/images/obi.png';
    } else if (name == 'Willhuff Tarkin') {
      return 'assets/images/tarkin.png';
    } else if (name == 'Jango Fett') {
      return 'assets/images/jango.png';
    } else if (name == 'Finn') {
      return 'assets/images/finn.png';
    } else if (name == 'Lando Calrissian') {
      return 'assets/images/lando.png';
    } else if (name == 'Rey') {
      return 'assets/images/rey.png';
    } else if (name == 'Jar Jar Binks') {
      return 'assets/images/jar.png';
    } else if (name == 'Poe Dameron') {
      return 'assets/images/poe.png';
    } else if (name == 'Padmé Amidala') {
      return 'assets/images/amidala.png';
    } else if (name == 'Kylo Ren') {
      return 'assets/images/kylo.png';
    } else if (name == 'Darth Maul') {
      return 'assets/images/maul.png';
    } else {
      return 'assets/images/venus.png';
    }
  }
}
