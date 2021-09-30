class ChatModel {
  int id;
  String? name;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool? select;
  ChatModel(
      {required this.id, this.name, this.isGroup, this.time, this.currentMessage, this.status, this.select = false});
}
