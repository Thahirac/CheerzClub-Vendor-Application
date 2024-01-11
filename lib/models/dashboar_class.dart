class Order {
  int? id;
  String? name;
  String? deliveryDate;
  double? price;
  int? status;

  Order(
      {
        this.id,
        this.name,
        this.deliveryDate,
        this.price,
        this.status
      });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name=  json['name'];
    deliveryDate = json['delivery_date'];
    price= json['price'].toDouble();
    status= json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name']=this.name;
    data['delivery_date']=this.deliveryDate;
    data['price']=this.price;
    data['status']=this.status;
    return data;
  }
}