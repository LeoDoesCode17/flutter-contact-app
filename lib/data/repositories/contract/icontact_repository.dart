import 'package:contact_app/domain/entities/contact.dart';

abstract class IContactRepository {
  Future<int> add(Contact contact);
  Future<Contact?> getById(int id);
  Future<List<Contact>> getAll();
  Future<int> update(Contact contact);
  Future<int> delete(int id);
}
