class ChatModel {
  String? name;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool? select;
  ChatModel({this.name, this.isGroup, this.time, this.currentMessage, this.status, this.select = false});
}
