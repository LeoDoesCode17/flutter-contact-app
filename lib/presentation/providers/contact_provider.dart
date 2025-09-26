import 'package:contact_app/data/repositories/contract/icontact_repository.dart';
import 'package:contact_app/domain/entities/contact.dart';
import 'package:contact_app/domain/usecases/get_all_contacts_use_case.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  final IContactRepository repository;
  final GetAllContactsUseCase _getAllContactsUseCase;
  ContactProvider({required this.repository})
    : _getAllContactsUseCase = GetAllContactsUseCase(repository: repository);

  List<Contact> _contacts = [];
  bool _isLoading = false;
  String? _error;

  // Getter for private property
  List<Contact> get contacts => _contacts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // notify all widgets that use isLoading, error, and contacts
    try {
      _contacts = await _getAllContactsUseCase();
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
