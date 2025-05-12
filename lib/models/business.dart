import 'package:hive/hive.dart';

part 'business.g.dart';


@HiveType(typeId: 1)
class Business extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String currency;

  @HiveField(2)
  double taxPercent;

  @HiveField(3)
  int type;

  @HiveField(4)
  List<String> enabledModules;

  Business({
    required this.name,
    required this.currency,
    required this.taxPercent,
    required this.type,
    required this.enabledModules,
  });
}