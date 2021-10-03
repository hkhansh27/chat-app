class Users {
  late bool isSuccess;
  late List<User>? users;
  Users({required this.isSuccess, this.users});

  factory Users.fromJson(dynamic json) {
    if (json['users'] != null) {
      var usersObjJson = json['users'] as List;
      List<User> _users = usersObjJson.map((usersJson) => User.fromJson(usersJson)).toList();

      return Users(isSuccess: json['success'], users: _users);
    } else {
      return Users(
        isSuccess: json['success'],
      );
    }
  }
  @override
  String toString() {
    // TODO: implement toString
    return '{✅✅✅✅ ${this.isSuccess}, ${this.users}}';
  }
}

class User {
  String? id, firstName, lastName, token;
  User({this.id, this.firstName, this.lastName, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{✅✅✅✅ ${this.id}}';
  }
}
