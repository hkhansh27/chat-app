// ignore_for_file: unnecessary_this

import 'package:chat_app/Models/msg_model.dart';
import 'package:chat_app/Models/room_model.dart';
import 'package:chat_app/Models/users_model.dart';

// import 'package:intl/intl.dart';
class Conversations {
  late bool? isSuccess;
  List<Conversation> conversations;
  Conversations({this.isSuccess, required this.conversations});
  factory Conversations.fromJson(dynamic json) {
    if (json['conversation'] != null) {
      var conversationObjJson = json['conversation'] as List;
      List<Conversation> _conversations = conversationObjJson.map((cv) => Conversation.fromJson(cv)).toList();

      return Conversations(isSuccess: json['success'], conversations: _conversations);
    } else {
      return Conversations(isSuccess: json['success'], conversations: []);
    }
  }
  @override
  String toString() {
    return '{ day la cai room, $conversations}';
  }
}

class Conversation {
  late String? id, messageId, chatRoomId;
  late Message? message;
  late User? postedByUserId;
  late String? createdAt;
  late List<dynamic>? amountMember;

  Conversation(
      {this.id,
      this.messageId,
      this.chatRoomId,
      required this.message,
      this.postedByUserId,
      this.createdAt,
      this.amountMember});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
        id: json['_id'],
        messageId: json['messageId'],
        chatRoomId: json['chatRoomId'],
        message: json['message'] == null ? null : Message.fromJson(json['message']),
        postedByUserId: json['postedByUser'] == null ? null : User.fromJson(json['postedByUser']),
        createdAt: json['createdAt'],
        amountMember: json['roomInfo']);
  }
  @override
  String toString() {
    return '😍${this.amountMember} 😍';
  }
}
