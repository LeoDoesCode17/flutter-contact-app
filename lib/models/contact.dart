import 'package:contact_app/utils/enums/gender.dart';

class Contact {
  final int id;
  final String phoneNumber;
  final Gender gender;
  final String description;

  const Contact({
    required this.id,
    required this.phoneNumber,
    required this.gender,
    required this.description,
  });
}
