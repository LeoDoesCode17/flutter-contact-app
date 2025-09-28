import 'package:flutter/material.dart';
import 'package:contact_app/domain/entities/contact.dart';
import 'package:contact_app/domain/entities/contact_gender.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final void Function()? onEdit;
  final void Function()? onDelete;

  const ContactCard({
    super.key,
    required this.contact,
    this.onEdit,
    this.onDelete,
  });

  Widget _buildAvatar(BuildContext context) {
    // Choose avatar by gender. You can replace with images if you have assets.
    switch (contact.gender) {
      case Gender.male:
        return CircleAvatar(
          radius: 28,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.male, size: 28, color: Colors.white),
        );
      case Gender.female:
        return CircleAvatar(
          radius: 28,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.female, size: 28, color: Colors.white),
        );
      default:
        // fallback: initials from name
        final initials = _getInitials(contact.name);
        return CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade400,
          child: Text(
            initials,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
    }
  }

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(context),
            const SizedBox(width: 12),

            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and phone on single row with responsive wrapping
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          contact.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        contact.phoneNumber,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Description (multi-line)
                  Text(
                    contact.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Actions
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Edit',
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  tooltip: 'Delete',
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
