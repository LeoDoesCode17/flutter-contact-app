import 'package:contact_app/data/db/sqlite_provider.dart';
import 'package:contact_app/data/repositories/concrete/sqlite_contact_repository.dart';
import 'package:contact_app/data/repositories/contract/icontact_repository.dart';
import 'package:contact_app/presentation/pages/home_page.dart';
import 'package:contact_app/presentation/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); /* Must understand this */

  SQLiteDatabaseProvider dbProvider = SQLiteDatabaseProvider.instance;
  final repository = SqliteContactRepository(dbProvider: dbProvider);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final IContactRepository repository;
  const MyApp({super.key, required this.repository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /* Must Understand this */
        ChangeNotifierProvider(
          create: (_) => ContactProvider(repository: repository)..loadUsers(),
        ),
      ],
      child: MaterialApp(
        title: 'Contact App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomePage(),
      ),
    );
  }
}
