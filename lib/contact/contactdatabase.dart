import 'package:hive/hive.dart';

part 'contactdatabase.g.dart';


@HiveType(typeId: 1)
class Contactdb {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

    @HiveField(2)
  String group;

Contactdb({required this.name, required this.phone, required this.group});
}
