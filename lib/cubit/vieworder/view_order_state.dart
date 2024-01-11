part of 'view_order_cubit.dart';

@immutable
abstract class MyorderState {}

class MyorderInitial extends MyorderState {}

class MyorderLoading extends MyorderState {}

class MyorderSuccess extends MyorderState {



  final OrderedUser? orderedUser;
  final   Order? order;
  final   List<Orderitem>? orderitems;
  final dynamic total;


  MyorderSuccess(this.orderedUser,this.order,this.orderitems,this.total);
}

class MyorderFail extends MyorderState {

  final String msg;

  MyorderFail(this.msg);

}
