// ignore_for_file: file_names

// class Data {
//   Data({
//     this.restaurant,
//     this.order,
//     this.orderData,
//     this.orderedUser,
//   });
//
//   Restaurant? restaurant;
//   Order? order;
//   OrderData? orderData;
//   OrderedUser? orderedUser;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     restaurant: Restaurant.fromJson(json["restaurant"]),
//     order: Order.fromJson(json["order"]),
//     orderData: OrderData.fromJson(json["order_data"]),
//     orderedUser: OrderedUser.fromJson(json["ordered_user"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "restaurant": restaurant?.toJson(),
//     "order": order?.toJson(),
//     "order_data": orderData?.toJson(),
//     "ordered_user": orderedUser?.toJson(),
//   };
// }
//
// class Restaurant {
//   Restaurant({
//     this.id,
//     this.name,
//     this.email,
//     this.address,
//     this.city,
//     this.zip,
//     this.profilePhotoUrl,
//     this.followers,
//     this.followings,
//   });
//
//   int? id;
//   String? name;
//   String? email;
//   String? address;
//   String? city;
//   dynamic zip;
//   String? profilePhotoUrl;
//   int? followers;
//   int? followings;
//
//   factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     address: json["address"],
//     city: json["city"],
//     zip: json["zip"],
//     profilePhotoUrl: json["profile_photo_url"],
//     followers: json["followers"],
//     followings: json["followings"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "address": address,
//     "city": city,
//     "zip": zip,
//     "profile_photo_url": profilePhotoUrl,
//     "followers": followers,
//     "followings": followings,
//   };
// }
//
// class Order {
//   Order({
//     this.id,
//     this.price,
//     this.userSecret,
//     this.deliveryDate,
//     this.deliveryType,
//     this.name,
//     this.dialcode,
//     this.phone,
//     this.message,
//     this.note,
//     this.createdAt,
//     this.restaurantId,
//     this.qr,
//   });
//
//   int? id;
//   double? price;
//   String? userSecret;
//   DateTime? deliveryDate;
//   int? deliveryType;
//   String? name;
//   String? dialcode;
//   String? phone;
//   String? message;
//   dynamic note;
//   DateTime? createdAt;
//   int? restaurantId;
//   String? qr;
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//     id: json["id"],
//     price: json["price"].toDouble(),
//     userSecret: json["user_secret"],
//     deliveryDate: DateTime.parse(json["delivery_date"]),
//     deliveryType: json["delivery_type"],
//     name: json["name"],
//     dialcode: json["dialcode"],
//     phone: json["phone"],
//     message: json["message"],
//     note: json["note"],
//     createdAt: DateTime.parse(json["created_at"]),
//     restaurantId: json["restaurant_id"],
//     qr: json["qr"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "price": price,
//     "user_secret": userSecret,
//     "delivery_date": deliveryDate,
//     "delivery_type": deliveryType,
//     "name": name,
//     "dialcode": dialcode,
//     "phone": phone,
//     "message": message,
//     "note": note,
//     "created_at": createdAt,
//     "restaurant_id": restaurantId,
//     "qr": qr,
//   };
// }
//
// class OrderData {
//   OrderData({
//     this.orderitems,
//     this.subtotal,
//     this.transactionFee,
//     this.vat,
//     this.total,
//   });
//
//   List<Orderitem>? orderitems;
//   double? subtotal;
//   double? transactionFee;
//   Vat? vat;
//   double? total;
//
//   factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
//     orderitems: List<Orderitem>.from(json["orderitems"].map((x) => Orderitem.fromJson(x))),
//     subtotal: json["subtotal"].toDouble(),
//     transactionFee: json["transaction_fee"].toDouble(),
//     vat: Vat.fromJson(json["vat"]),
//     total: json["total"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "orderitems": List<dynamic>.from(orderitems!.map((x) => x.toJson())),
//     "subtotal": subtotal,
//     "transaction_fee": transactionFee,
//     "vat": vat!.toJson(),
//     "total": total,
//   };
// }
//
// class Orderitem {
//   Orderitem({
//     this.id,
//     this.productName,
//     this.productId,
//     this.orderId,
//     this.vat,
//     this.price,
//     this.quantity,
//     this.orderType,
//     this.createdAt,
//     this.updatedAt,
//     this.quantityText,
//     this.itemPrice,
//   });
//
//   int? id;
//   String? productName;
//   int? productId;
//   int? orderId;
//   int? vat;
//   dynamic price;
//   int? quantity;
//   String? orderType;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? quantityText;
//   double? itemPrice;
//
//   factory Orderitem.fromJson(Map<String, dynamic> json) => Orderitem(
//     id: json["id"],
//     productName: json["product_name"],
//     productId: json["product_id"],
//     orderId: json["order_id"],
//     vat: json["vat"],
//     price: json["price"],
//     quantity: json["quantity"],
//     orderType: json["order_type"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     quantityText: json["quantity_text"],
//     itemPrice: json["item_price"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_name": productName,
//     "product_id": productId,
//     "order_id": orderId,
//     "vat": vat,
//     "price": price,
//     "quantity": quantity,
//     "order_type": orderType,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "quantity_text": quantityText,
//     "item_price": itemPrice,
//   };
// }
//
// class Vat {
//   Vat({
//     this.the21,
//   });
//
//   double? the21;
//
//   factory Vat.fromJson(Map<String, dynamic> json) => Vat(
//     the21: json["21"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "21": the21,
//   };
// }
//
// class OrderedUser {
//   OrderedUser({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.address,
//     this.profilePhotoUrl,
//     this.followers,
//     this.followings,
//     this.city,
//     this.zip,
//   });
//
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? address;
//   String? profilePhotoUrl;
//   int? followers;
//   int? followings;
//   String? city;
//   String? zip;
//
//   factory OrderedUser.fromJson(Map<String, dynamic> json) => OrderedUser(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     phone: json["phone"] == null ? null : json["phone"],
//     address: json["address"],
//     profilePhotoUrl: json["profile_photo_url"],
//     followers: json["followers"],
//     followings: json["followings"],
//     city: json["city"] == null ? null : json["city"],
//     zip: json["zip"] == null ? null : json["zip"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "phone": phone == null ? null : phone,
//     "address": address,
//     "profile_photo_url": profilePhotoUrl,
//     "followers": followers,
//     "followings": followings,
//     "city": city == null ? null : city,
//     "zip": zip == null ? null : zip,
//   };
// }






class DataClass {
  DataClass({
    this.orderedUser,
    this.order,
    this.orderData,
  });

  OrderedUser? orderedUser;
  Order? order;
  OrderData? orderData;

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
    orderedUser: json["ordered_user"] == null ? null : OrderedUser.fromJson(json["ordered_user"]),
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    orderData: json["order_data"] == null ? null : OrderData.fromJson(json["order_data"]),
  );

  Map<String, dynamic> toJson() => {
    "ordered_user": orderedUser == null ? null : orderedUser!.toJson(),
    "order": order == null ? null : order!.toJson(),
    "order_data": orderData == null ? null : orderData!.toJson(),
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
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    message: json["message"] == null ? null : json["message"],
    note: json["note"],
    deliveryDate: json["delivery_date"] == null ? null : DateTime.parse(json["delivery_date"]),
    price: json["price"] == null ? null : json["price"].toDouble(),
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
    userId: json["user_id"] == null ? null : json["user_id"],
    userSecret: json["user_secret"] == null ? null : json["user_secret"],
    restaurantSecret: json["restaurant_secret"] == null ? null : json["restaurant_secret"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "message": message == null ? null : message,
    "note": note,
    "delivery_date": deliveryDate == null ? null : deliveryDate,
    "price": price == null ? null : price,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "payment_status": paymentStatus == null ? null : paymentStatus,
    "user_id": userId == null ? null : userId,
    "user_secret": userSecret == null ? null : userSecret,
    "restaurant_secret": restaurantSecret == null ? null : restaurantSecret,
  };
}

class OrderData {
  OrderData({
    this.orderitems,
    this.vat,
    this.transactionFee,
    this.subtotal,
    this.total,
  });

  List<Orderitem>? orderitems;
  double? subtotal;
  int? transactionFee;
  Map<String, double>? vat;
  dynamic total;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    orderitems: json["orderitems"] == null ? null : List<Orderitem>.from(json["orderitems"].map((x) => Orderitem.fromJson(x))),
    subtotal: json["subtotal"] == null ? null : json["subtotal"].toDouble(),
    transactionFee: json["transaction_fee"] == null ? null : json["transaction_fee"],
    vat: json["vat"] == null ? null : Map.from(json["vat"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "orderitems": orderitems == null ? null : List<dynamic>.from(orderitems!.map((x) => x.toJson())),
    "subtotal": subtotal == null ? null : subtotal,
    "transaction_fee": transactionFee == null ? null : transactionFee,
    "vat": vat == null ? null : Map.from(vat!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "total": total == null ? null : total,
  };
}

class Orderitem {
  Orderitem({
    this.id,
    this.productName,
    this.vat,
    this.price,
    this.quantity,
    this.orderType,
    this.quantityText,
    this.itemPrice

  });

  int? id;
  String? productName;
  int? vat;
  dynamic price;
  int? quantity;
  dynamic orderType;
  String? quantityText;
  dynamic itemPrice;

  factory Orderitem.fromJson(Map<String, dynamic> json) => Orderitem(
    id: json["id"] == null ? null : json["id"],
    productName: json["product_name"] == null ? null : json["product_name"],
    vat: json["vat"] == null ? null : json["vat"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    quantity: json["quantity"] == null ? null : json["quantity"],
    orderType: json["order_type"],
    quantityText: json["quantity_text"] == null ? null : json["quantity_text"],
    itemPrice: json["item_price"] == null ? null : json["item_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "product_name": productName == null ? null : productName,
    "vat": vat == null ? null : vat,
    "price": price == null ? null : price,
    "quantity": quantity == null ? null : quantity,
    "order_type": orderType,
    "quantity_text": quantityText == null ? null : quantityText,
    "item_price": itemPrice == null ? null : itemPrice,
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
  String? phone;
  String? address;
  String? profilePhotoUrl;
  int? followers;
  int? followings;

  factory OrderedUser.fromJson(Map<String, dynamic> json) => OrderedUser(
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    address: json["address"] == null ? null : json["address"],
    profilePhotoUrl: json["profile_photo_url"] == null ? null : json["profile_photo_url"],
    followers: json["followers"] == null ? null : json["followers"],
    followings: json["followings"] == null ? null : json["followings"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "address": address == null ? null : address,
    "profile_photo_url": profilePhotoUrl == null ? null : profilePhotoUrl,
    "followers": followers == null ? null : followers,
    "followings": followings == null ? null : followings,
  };
}


