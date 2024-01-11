import 'package:bloc/bloc.dart';
import 'package:cheerzclubvendor/models/checkorder_class.dart';
import 'package:cheerzclubvendor/models/user_class.dart';
import 'package:cheerzclubvendor/repository/productdetailsRepo.dart';
import 'package:cheerzclubvendor/utils/user_manager.dart';
import 'package:meta/meta.dart';
import 'package:result_type/result_type.dart';

part 'usercheck_state.dart';

class UserchekCubit extends Cubit<UsercheckState> {


  OrderedUser? orderedUser;
  Order? order;
  List<Orderitem>? orderitems;


  final CheckOrderRepository usercheckRepo;
  UserchekCubit(this.usercheckRepo) : super(UsercheckInitial());



  Future<void> checkorder(String? user_secret) async {
    print("**********************"+user_secret.toString());
    emit(UsercheckLoading());


    Result? result = await usercheckRepo.checkorder(user_secret);

    if (result!.isSuccess) {


      dynamic ordr = result.success['ordered_user'];

      orderedUser = OrderedUser(

          name: ordr["name"],
          email: ordr["email"],
          phone: ordr["phone"],
          address: ordr["address"],
          profilePhotoUrl: ordr["profile_photo_url"],
          followers: 0,
          followings: 0,
      );

      dynamic myorder = result.success['order'];

      order = Order(
        id: myorder["id"],
        name: myorder["name"],
        message: myorder["message"],
        note: myorder["note"],
        deliveryDate: DateTime.parse(myorder["delivery_date"]),
        price: myorder["price"].toDouble(),
        status: myorder["status"],
        createdAt: DateTime.parse(myorder["created_at"]),
        paymentStatus: myorder["payment_status"],
        userId: myorder["user_id"],
        userSecret: myorder["user_secret"],
        restaurantSecret: myorder["restaurant_secret"],
      );


      dynamic products = result.success['order_data']['orderitems'];
      orderitems = await productsList(products);

      emit(UsercheckSuccessFull(orderedUser,order,orderitems));
    }

    else {
      emit(UsercheckFailed(result.failure));
    }
  }

  Future<void> orderdelivery(String? user_secret,String? restaurant_secret,String table) async {
    emit(DeliveryLoading());


    Result? result = await usercheckRepo.orderdelivery(user_secret,restaurant_secret,table);

    if (result!.isSuccess) {

      emit(DeliverySuccessFull(orderedUser,order,orderitems));
    }

    else {
      emit(DeliveryFailed(result.failure));
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
      orderType: data[i]?['order_type'],
      quantity: data[i]?['quantity'],
      quantityText: data[i]?['quantity_text'],

    );
    productslist.add(products);
  }
  return productslist;
}