import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'flashcard.g.dart';

@HiveType(typeId: 1)
class Flashcard {
  Flashcard({
    required this.content,
    required this.labels,
    String? uuid,
  }) : uuid = const Uuid().v4();

  @HiveField(0)
  String uuid;
  @HiveField(1)
  String content;
  @HiveField(2)
  List<String> labels;

  @override
  bool operator ==(covariant Flashcard other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() {
    return 'Flashcard (content: $content, labels:$labels, id:$uuid)';
  }
}
