import 'package:bloc/bloc.dart';
import 'package:cheerzclubvendor/models/dashboar_class.dart';
import 'package:cheerzclubvendor/repository/dashboardRepo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:result_type/result_type.dart';

part 'dashboard_state.dart';

class DashbordCubit extends Cubit<DashbordState> {


  DashbordCubit(this.dashBordRepository) : super(DashbordInitial());
  final DashBordRepository dashBordRepository;


  Future<void> getOrders() async {
    emit(DashbordLoadingMyorders());
    Result result = await dashBordRepository.getOrders();
    if (result.isSuccess) {

      dynamic resultData = result.success;
      List<Order> orders = await myOrdersList(
        resultData,
      );
      emit(DashbordLoadingMyordersSucssellfull(orders));
    }
    else {
      emit(DashbordLoadingMyordersFail(result.failure));
    }
  }
}



List<Order> myOrdersList(List data) {
  List<Order> Orders = [];
  var length = data.length;
  print(length.toString());

  for (int i = 0; i < length; i++) {
  Order MyOrders = Order(
        id: data[i]['id'],
        name: data[i]['name'],
        deliveryDate: data[i]['delivery_date'],
        price: data[i]['price'],
        status: data[i]["status"],);
    Orders.add(MyOrders);
  }
  return Orders;
}