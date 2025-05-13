import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart'; // driftDatabase
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [UsersModel])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'db.sqlite'));

  @override
  int get schemaVersion => 1;
}
