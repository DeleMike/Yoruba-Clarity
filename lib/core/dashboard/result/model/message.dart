import 'package:uuid/uuid.dart';

/// Message data model
class Message {
  /// Message data model
  Message({
    required this.content,
    required this.isUser,
    String? id,
  }) : id = const Uuid().v4();

  /// id of the user currently using the application
  final String id;

  /// converted text
  final String content;

  /// is this the user or AI
  final bool isUser;

  /// change to [Ama] data model
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: const Uuid().v4(),
      content: json['content'],
      isUser: json['is_user'],
    );
  }

  /// Convert to json object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'is_user': isUser,
    };
  }

  @override
  bool operator ==(covariant Message other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Message (convertedText: $content, isUser:$isUser, id:$id)';
  }
}
