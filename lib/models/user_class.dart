class User {
  int? id;
  String? name;
  String? username;
  int? restaurantId;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
        this.id,
        this.name,
        this.username,
        this.restaurantId,
        this.createdAt,
        this.updatedAt,

      });

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    username = json["username"];
    restaurantId = json["restaurant_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserSession {
  String? token;

  UserSession(
      {this.token,});

  UserSession.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}





