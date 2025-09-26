import 'package:contact_app/domain/entities/contact_gender.dart';

class Contact {
  final int? id;
  final String name;
  final String phoneNumber;
  final Gender gender;
  final String description;

  const Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.description,
  });

  // Convert Contact to Map
  Map<String, Object?> toMap() => {
    'id': id,
    'name': name,
    'phone_number': phoneNumber,
    'gender': gender.name,
    'description': description,
  };

  // Create contact from Map (warning to parse data of gender)
  factory Contact.fromMap(Map<String, Object?> map) => Contact(
    id: map['id'] as int,
    name: map['name'] as String,
    phoneNumber: map['phone_number'] as String,
    gender: Gender.values.firstWhere(
      (g) => g.name == map['gender'],
      orElse: () => Gender.none,
    ),
    description: map['description'] as String,
  );
}
