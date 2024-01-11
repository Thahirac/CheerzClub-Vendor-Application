class Data {
  Data({
    this.orderedUser,
    this.order,
    this.orderData,
  });

  OrderedUser? orderedUser;
  Order? order;
  OrderData? orderData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orderedUser: OrderedUser.fromJson(json["ordered_user"]),
    order: Order.fromJson(json["order"]),
    orderData: OrderData.fromJson(json["order_data"]),
  );

  Map<String, dynamic> toJson() => {
    "ordered_user": orderedUser!.toJson(),
    "order": order!.toJson(),
    "order_data": orderData!.toJson(),
  };
}

class Order {
  Order({
    this.id,
    this.name,
    this.message,
    this.note,
    this.deliveryDate,
    this.price,
    this.status,
    this.createdAt,
    this.paymentStatus,
    this.userId,
    this.userSecret,
    this.restaurantSecret,
  });

  int? id;
  String? name;
  String? message;
  dynamic note;
  DateTime? deliveryDate;
  double? price;
  int? status;
  DateTime? createdAt;
  int? paymentStatus;
  int? userId;
  String? userSecret;
  String? restaurantSecret;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    name: json["name"],
    message: json["message"],
    note: json["note"],
    deliveryDate: DateTime.parse(json["delivery_date"]),
    price: json["price"].toDouble(),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    paymentStatus: json["payment_status"],
    userId: json["user_id"],
    userSecret: json["user_secret"],
    restaurantSecret: json["restaurant_secret"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "message": message,
    "note": note,
    "delivery_date": deliveryDate,
    "price": price,
    "status": status,
    "created_at": createdAt,
    "payment_status": paymentStatus,
    "user_id": userId,
    "user_secret": userSecret,
    "restaurant_secret": restaurantSecret,
  };
}

class OrderData {
  OrderData({
    this.orderitems,
  });

  List<Orderitem>? orderitems;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    orderitems: List<Orderitem>.from(json["orderitems"].map((x) => Orderitem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderitems": List<dynamic>.from(orderitems!.map((x) => x.toJson())),
  };
}

class Orderitem {
  Orderitem({
    this.id,
    this.productName,
    this.vat,
    this.quantity,
    this.orderType,
    this.quantityText,
  });

  int? id;
  String? productName;
  int? vat;
  int? quantity;
  String? orderType;
  String? quantityText;

  factory Orderitem.fromJson(Map<String, dynamic> json) => Orderitem(
    id: json["id"],
    productName: json["product_name"],
    vat: json["vat"],
    quantity: json["quantity"],
    orderType: json["order_type"],
    quantityText: json["quantity_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "vat": vat,
    "quantity": quantity,
    "order_type": orderType,
    "quantity_text": quantityText,
  };
}

class OrderedUser {
  OrderedUser({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.profilePhotoUrl,
    this.followers,
    this.followings,
  });

  String? name;
  String? email;
  dynamic phone;
  dynamic address;
  String? profilePhotoUrl;
  int? followers;
  int? followings;

  factory OrderedUser.fromJson(Map<String, dynamic> json) => OrderedUser(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    profilePhotoUrl: json["profile_photo_url"],
    followers: json["followers"],
    followings: json["followings"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "profile_photo_url": profilePhotoUrl,
    "followers": followers,
    "followings": followings,
  };
}
