part of 'usercheck_cubit.dart';

@immutable
abstract class UsercheckState {}

class UsercheckInitial extends UsercheckState {}

class UsercheckLoading extends UsercheckState {}

class UsercheckSuccessFull extends UsercheckState {
  //save user data
  final   OrderedUser? orderedUser;
  final Order? order;
  final List<Orderitem>? orderitems;
  UsercheckSuccessFull(this.orderedUser,this.order,this.orderitems);
}

class UsercheckFailed extends UsercheckState {
  //show error
  final String msg;
  UsercheckFailed(this.msg);
}
class DeliveryLoading extends UsercheckState {}

class DeliverySuccessFull extends UsercheckState {
  //save user data
  final   OrderedUser? orderedUser;
  final Order? order;
  final List<Orderitem>? orderitems;
  DeliverySuccessFull(this.orderedUser,this.order,this.orderitems);
}

class DeliveryFailed extends UsercheckState {
  //show error
  final String msg;
  DeliveryFailed(this.msg);
}