import 'package:contact_app/data/repositories/contract/icontact_repository.dart';

class DeleteContactUseCase {
  final IContactRepository repository;
  DeleteContactUseCase({required this.repository});
  Future<void> call(String id) => repository.delete(id);
}
