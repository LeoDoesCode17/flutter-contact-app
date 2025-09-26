import 'package:contact_app/data/db/sqlite_provider.dart';
import 'package:contact_app/data/repositories/contract/icontact_repository.dart';
import 'package:contact_app/domain/entities/contact.dart';
import 'package:sqflite/sqflite.dart';

class SqliteContactRepository implements IContactRepository {
  final SQLiteDatabaseProvider dbProvider;
  SqliteContactRepository({required this.dbProvider});
  Future<Database> get _db async => await dbProvider.database;

  @override
  Future<int> add(Contact contact) async {
    final db = await _db;
    return await db.insert('contacts', contact.toMap());
  }

  @override
  Future<int> delete(int id) async {
    final db = await _db;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Contact>> getAll() async {
    final db = await _db;
    final maps = await db.query('contacts', orderBy: 'id ASC');
    return maps.map((m) => Contact.fromMap(m)).toList();
  }

  @override
  Future<Contact?> getById(int id) async {
    final db = await _db;
    final maps = await db.query('contacts', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Contact.fromMap(maps.first);
  }

  @override
  Future<int> update(Contact contact) async {
    final db = await _db;
    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }
}
