// ignore_for_file: unnecessary_this

class Room {
  String? chatRoomId, message;
  bool? isNew;
  Room({this.chatRoomId, this.message, this.isNew = false});

  factory Room.fromJson(Map<dynamic, dynamic> json) {
    return Room(chatRoomId: json['chatRoomId'], message: json['message'], isNew: json['isNew']);
  }
}
