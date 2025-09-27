import 'package:contact_app/domain/entities/contact_gender.dart';

class Contact {
  final String? id;
  final String name;
  final String phoneNumber;
  final Gender gender;
  final String description;

  const Contact({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.description,
  });

  Contact copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    Gender? gender,
    String? description,
  }) => Contact(
    id: id ?? this.id,
    name: name ?? this.name,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    gender: gender ?? this.gender,
    description: description ?? this.description,
  );

  @override
  String toString() =>
      'Contact(id: $id, name: $name, phone: $phoneNumber, gender: $gender, desc: $description)';
}
