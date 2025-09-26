import 'package:contact_app/data/repositories/contract/icontact_repository.dart';
import 'package:contact_app/domain/entities/contact.dart';

class GetAllContactsUseCase {
  final IContactRepository repository;
  GetAllContactsUseCase({required this.repository});
  Future<List<Contact>> call() => repository.getAll();
}
