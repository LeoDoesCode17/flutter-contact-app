import 'dart:developer' as developer;
import 'package:contact_app/data/db/sqlite_provider.dart';
import 'package:contact_app/data/mappers/contact_sqlite_mapper.dart';
import 'package:contact_app/data/repositories/contract/icontact_repository.dart';
import 'package:contact_app/domain/entities/contact.dart';
import 'package:sqflite/sqflite.dart';

class SqliteContactRepository implements IContactRepository {
  final SQLiteDatabaseProvider dbProvider;

  SqliteContactRepository({required this.dbProvider});

  Future<Database> get _db async => await dbProvider.database;

  @override
  Future<String> add(Contact contact) async {
    try {
      final db = await _db;
      final int newRowId = await db.insert(
        'contacts',
        contactToSqliteMap(contact, omitId: true),
        // optional: conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return newRowId.toString();
    } catch (e, st) {
      developer.log('Error inserting contact', error: e, stackTrace: st);
      rethrow; // let caller handle DB errors
    }
  }

  @override
  Future<void> delete(String id) async {
    final int? intId = int.tryParse(id);
    if (intId == null) {
      // Fail fast — caller gave an invalid domain id
      developer.log("Invalid id for delete: '$id' is not an int string");
      throw ArgumentError.value(id, 'id', 'Expected numeric id string for sqlite');
    }

    try {
      final db = await _db;
      final deleted = await db.delete('contacts', where: 'id = ?', whereArgs: [intId]);
      developer.log('Deleted rows: $deleted for id: $id');
    } catch (e, st) {
      developer.log('Error deleting contact id=$id', error: e, stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<List<Contact>> getAll() async {
    try {
      final db = await _db;
      final List<Map<String, Object?>> maps = await db.query('contacts', orderBy: 'id ASC');
      return maps.map((m) => contactFromSqliteMap(m)).toList();
    } catch (e, st) {
      developer.log('Error querying all contacts', error: e, stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<Contact?> getById(String id) async {
    final int? intId = int.tryParse(id);
    if (intId == null) {
      developer.log("Invalid id for getById: '$id' is not an int string");
      throw ArgumentError.value(id, 'id', 'Expected numeric id string for sqlite');
    }

    try {
      final db = await _db;
      final maps = await db.query('contacts', where: 'id = ?', whereArgs: [intId], limit: 1);
      if (maps.isEmpty) return null;
      return contactFromSqliteMap(maps.first);
    } catch (e, st) {
      developer.log('Error fetching contact id=$id', error: e, stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<void> update(Contact contact) async {
    if (contact.id == null) {
      developer.log('Contact id is required when update a row');
      throw ArgumentError('Contact id is required for update');
    }

    final int? intId = int.tryParse(contact.id!);
    if (intId == null) {
      developer.log("Invalid id for update: '${contact.id}' is not an int string");
      throw ArgumentError.value(contact.id, 'contact.id', 'Expected numeric id string for sqlite');
    }

    try {
      final db = await _db;
      final count = await db.update(
        'contacts',
        contactToSqliteMap(contact, omitId: true),
        where: 'id = ?',
        whereArgs: [intId],
      );
      developer.log('Updated rows: $count for id: ${contact.id}');
    } catch (e, st) {
      developer.log('Error updating contact id=${contact.id}', error: e, stackTrace: st);
      rethrow;
    }
  }
}
