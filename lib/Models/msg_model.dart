import 'package:chat_app/Models/users_model.dart';

class Message {
  late String? id;
  late String messageText;

  Message({this.id, required this.messageText});
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      messageText: json['messageText'],
    );
    // late List<Conversation> users;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '😛duoc gui tu msgmodel😱';
  }
}
