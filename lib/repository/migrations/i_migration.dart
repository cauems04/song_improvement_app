import 'package:sqflite/sqflite.dart';

abstract class IMigration {
  Future<void> execute(Database db);
}
