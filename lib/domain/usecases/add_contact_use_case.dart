import 'package:contact_app/data/repositories/contract/icontact_repository.dart';
import 'package:contact_app/domain/entities/contact.dart';

class AddContactUseCase {
  final IContactRepository repository;
  AddContactUseCase({required this.repository});
  Future<int> call(Contact contact) => repository.add(contact);
}
