import 'package:hive/hive.dart';

part 'user.g.dart';


@HiveType(typeId: 0)
class User extends HiveObject {

  @HiveField(0)
  String userName;

  @HiveField(1)
  String passwordHash;

  User({
    required this.userName,
    required this.passwordHash,
  });
}