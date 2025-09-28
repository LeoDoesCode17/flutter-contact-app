import 'package:contact_app/data/repositories/contract/icontact_repository.dart';
import 'package:contact_app/domain/entities/contact.dart';

class UpdateContactUseCase {
  final IContactRepository repository;
  UpdateContactUseCase({required this.repository});
  Future<void> call(Contact contact) => repository.update(contact); // callable object
}
