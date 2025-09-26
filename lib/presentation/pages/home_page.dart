import 'package:contact_app/presentation/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContactProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (provider.isLoading) const CircularProgressIndicator(),
            if (provider.error != null) Text('Error: ${provider.error}'),
            provider.contacts.isEmpty
                ? Text('No contacts found')
                : Expanded(
                    child: ListView.builder(
                      itemCount: provider.contacts.length,
                      itemBuilder: (context, index) {
                        final contact = provider.contacts[index];
                        return ListTile(
                          title: Text(contact.name),
                          subtitle: Text(contact.phoneNumber),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ) /* Placeholder is contact list */,
      floatingActionButton: FloatingActionButton(onPressed: null, child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
