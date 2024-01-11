part of 'dashboard_cubit.dart';


@immutable
abstract class DashbordState {}

class DashbordInitial extends DashbordState {}


class DashbordLoadingMyorders extends DashbordState {}

class DashbordLoadingMyordersSucssellfull extends DashbordState {

  final  List<Order>? orders;

  DashbordLoadingMyordersSucssellfull(this.orders);
}

class DashbordLoadingMyordersFail extends DashbordState {
  final String msg;
  DashbordLoadingMyordersFail(this.msg);
}
