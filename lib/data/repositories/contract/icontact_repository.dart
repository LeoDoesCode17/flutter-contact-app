import 'package:contact_app/domain/entities/contact.dart';

abstract class IContactRepository {
  Future<String> add(Contact contact);
  Future<Contact?> getById(String id);  
  Future<List<Contact>> getAll();
  Future<void> update(Contact contact);
  Future<void> delete(String id);
}
