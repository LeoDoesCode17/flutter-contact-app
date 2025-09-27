import 'package:contact_app/domain/entities/contact.dart';
import 'package:contact_app/domain/entities/contact_gender.dart';

Map<String, Object?> contactToFirebaseMap(Contact contact) => {
  'name': contact.name,
  'phone_number': contact.phoneNumber,
  'gender': contact.gender.name,
  'description': contact.description,
};

Contact contactFromFirebaseMap(String docId, Map<String, dynamic> data) =>
    Contact(
      id: docId,
      name: data['name'] as String? ?? '',
      phoneNumber: data['phone_number'] as String? ?? '',
      gender: Gender.values.firstWhere(
        (g) => g.name == (data['gender'] as String? ?? ''),
        orElse: () => Gender.none,
      ),
      description: data['description'] as String? ?? '',
    );
