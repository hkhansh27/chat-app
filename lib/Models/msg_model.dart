///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class Message {
/*
{
  "message": "de t cho m xem anh",
  "type": "0"
}
*/

  String? message;
  String? type;

  Message({
    this.message,
    this.type,
  });
  Message.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
    type = json['type']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['type'] = type;
    return data;
  }
}