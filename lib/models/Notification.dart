
// ignore_for_file: file_names

class Data {
  Data({
    this.notifications,
    this.notificationCount,
    this.notification
  });

  List<MyNotification>? notifications;
  int? notificationCount;
  SingleNotification? notification;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: json["notifications"] == null ? null : List<MyNotification>.from(json["notifications"].map((x) => MyNotification.fromJson(x))),
    notificationCount: json["notification_count"] == null ? null : json["notification_count"],
    notification: json["notification"] == null ? null : SingleNotification.fromJson(json["notification"]),
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications == null ? null : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    "notification_count": notificationCount == null ? null : notificationCount,
    "notification": notification == null ? null : notification!.toJson(),
  };
}

class MyNotification {
  MyNotification({
    this.id,
    this.time,
    this.title,
    this.description,
    this.url,
    this.orderId
  });

  String? id;
  String? time;
  String? title;
  String? description;
  String? url;
  String? orderId;

  factory MyNotification.fromJson(Map<String, dynamic> json) => MyNotification(
    id: json["id"] == null ? null : json["id"],
    time: json["time"] == null ? null : json["time"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    url: json["url"] == null ? null : json["url"],
    orderId: json["order_id"] == null ? null : json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "time": time == null ? null : time,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "url": url == null ? null : url,
    "order_id": orderId == null ? null : orderId,
  };
}

class SingleNotification {
  SingleNotification({
    this.id,
    this.time,
    this.title,
    this.description,
    this.url,
    this.orderId
  });

  String? id;
  String? time;
  String? title;
  String? description;
  String? url;
  String? orderId;

  factory SingleNotification.fromJson(Map<String, dynamic> json) => SingleNotification(
    id: json["id"] == null ? null : json["id"],
    time: json["time"] == null ? null : json["time"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    url: json["url"] == null ? null : json["url"],
    orderId: json["order_id"] == null ? null : json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "time": time == null ? null : time,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "url": url == null ? null : url,
    "order_id": orderId == null ? null : orderId,
  };
}




// enum Description { YOUR_PAYMENT_FOR_ORDER_IS_SUCESS, YOUR_ORDER_IS_DELIVERED }
//
// final descriptionValues = EnumValues({
//   "Your Order is Delivered": Description.YOUR_ORDER_IS_DELIVERED,
//   "Your payment for Order is Sucess": Description.YOUR_PAYMENT_FOR_ORDER_IS_SUCESS
// });
//
// enum Title { ORDER_SUCCESS, ORDER_DELIVERED }
//
// final titleValues = EnumValues({
//   "Order Delivered": Title.ORDER_DELIVERED,
//   "Order Success": Title.ORDER_SUCCESS
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }





