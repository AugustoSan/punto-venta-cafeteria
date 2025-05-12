import 'package:hive/hive.dart';

part 'userModel.g.dart';


@HiveType(typeId: 0)
class UserModel extends HiveObject {

  @HiveField(0)
  String userName;

  @HiveField(1)
  String passwordHash;

  UserModel({
    required this.userName,
    required this.passwordHash,
  });
}