// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:contact_app/data/db/sqlite_provider.dart';
import 'package:contact_app/data/repositories/concrete/sqlite_contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:contact_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SQLiteDatabaseProvider dbProvider = SQLiteDatabaseProvider.instance;
    final repository = SqliteContactRepository(dbProvider: dbProvider);
    await tester.pumpWidget(MyApp(repository: repository));
  });
}
