import 'package:contact_app/domain/entities/contact.dart';
import 'package:contact_app/domain/entities/contact_gender.dart';
import 'package:flutter/material.dart';

class ContactFormDialog extends StatefulWidget {
  final Contact contact;
  final Function(Contact) onSubmit;
  final String title;
  const ContactFormDialog({
    super.key,
    required this.contact,
    required this.onSubmit,
    required this.title,
  });

  @override
  State<StatefulWidget> createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<ContactFormDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _descriptionController;
  late Gender _selectedGender;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _phoneController = TextEditingController(text: widget.contact.phoneNumber);
    _descriptionController = TextEditingController(
      text: widget.contact.description,
    );
    _selectedGender = widget.contact.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    final updatedContact = Contact(
      id: widget.contact.id,
      name: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      gender: _selectedGender,
      description: _descriptionController.text.trim(),
    );
    widget.onSubmit(updatedContact);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // Name Field
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Phone Number Field
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Gender Radio Buttons
              RadioGroup(
                groupValue: _selectedGender,
                onChanged: (Gender? value) {
                  if (value != null) {
                    setState(() => _selectedGender = value);
                  }
                },
                child: Column(
                  children: Gender.values
                      .map(
                        (gender) => ListTile(
                          title: Text(gender.name),
                          leading: Radio<Gender>(value: gender),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 12),

              // Description Field
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              //Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: _submit, child: const Text('Save')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
