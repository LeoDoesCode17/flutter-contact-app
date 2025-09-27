import 'package:contact_app/domain/entities/contact.dart';
import 'package:contact_app/domain/entities/contact_gender.dart';

Map<String, Object?> contactToSqliteMap(
  Contact contact, {
  bool omitId = false,
}) {
  final map = <String, Object?>{
    'name': contact.name,
    'phone_number': contact.phoneNumber,
    'gender': contact.gender.name,
    'description': contact.description,
  };

  if (!omitId && contact.id != null) {
    final numericId = int.tryParse(contact.id!);
    map['id'] = numericId ?? contact.id;
  }
  return map;
}

Contact contactFromSqliteMap(Map<String, Object?> map) {
  final rawId = map['id'];
  final stringId = rawId.toString();

  return Contact(
    id: stringId,
    name: map['name'] as String? ?? '',
    phoneNumber: map['phone_number'] as String? ?? '',
    gender: Gender.values.firstWhere(
      (g) => g.name == (map['gender'] as String? ?? ''),
      orElse: () => Gender.none,
    ),
    description: map['description'] as String? ?? '',
  );
}
