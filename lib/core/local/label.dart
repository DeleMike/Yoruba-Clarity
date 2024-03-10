import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'label.g.dart';

@HiveType(typeId: 2)
class Label {
  Label({
    required this.name,
  }) : id = const Uuid().v4();

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  @override
  bool operator ==(covariant Label other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Label (id: $id, name:$name)';
  }
}
