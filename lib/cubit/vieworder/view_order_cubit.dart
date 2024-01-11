import 'package:bloc/bloc.dart';
import 'package:cheerzclubvendor/models/Singleorder_class.dart';
import 'package:cheerzclubvendor/repository/VieworderRepo.dart';
import 'package:meta/meta.dart';
import 'package:result_type/result_type.dart';

part 'view_order_state.dart';

class MyorderCubit extends Cubit<MyorderState> {

  OrderedUser? orderedUser;
  Order? order;
  List<Orderitem>? orderitems;
  dynamic transactionfee;
  dynamic subtotal;
  dynamic total;
  dynamic vat21;
  dynamic vat9;

  MyorderCubit(this.getoneordEr) : super(MyorderInitial());
  final GetOneOrder  getoneordEr;


  Future<void> GetoneOrderGet(String id) async {
    emit(MyorderLoading());
    Result? result = await getoneordEr.GetoneOrderGet(id);
    if (result.isSuccess) {

      dynamic orderuser = result.success['ordered_user'];

      orderedUser = OrderedUser(
          name: orderuser['name'],
          email: orderuser['email'],
          phone: orderuser["phone"],
          address: orderuser['address'],
          profilePhotoUrl: orderuser['profile_photo_url'],
          followers: 0,
          followings: 0);


      dynamic ordr= result.success['order'];

      order = Order(
        id: ordr["id"],
        price: ordr["price"].toDouble(),
        userSecret: ordr["user_secret"],
        deliveryDate: DateTime.parse(ordr["delivery_date"]),
        name: ordr["name"],
        message: ordr["message"],
        note: ordr["note"],
        createdAt: DateTime.parse(ordr["created_at"]),
        status: ordr["status"],
        paymentStatus: ordr["payment_status"],
        userId: ordr["user_id"],
        restaurantSecret: ordr["restaurant_secret"],
      );




      dynamic products = result.success['order_data']['orderitems'];
      orderitems = await productsList(products);

      total = result.success['order_data']['total'];




      emit(MyorderSuccess(orderedUser,order,orderitems,total));
    } else {
      emit(MyorderFail(result.failure));
    }
  }




}

List<Orderitem> productsList(List data) {
  List<Orderitem> productslist = [];
  var length = data.length;
  print("**********CART***LENGTH**********"+length.toString());

  for (int i = 0; i < length; i++) {
    Orderitem products =Orderitem(
        id: data[i]?['id'],
        productName: data[i]?['product_name'],
        vat: data[i]?["vat"],
        price: data[i]?["price"],
        orderType: data[i]?['order_type'],
        quantity: data[i]?['quantity']!,
        quantityText: data[i]?['quantity_text'],
        itemPrice: data[i]?['item_price'],
    );


    productslist.add(products);
  }
  return productslist;
}

