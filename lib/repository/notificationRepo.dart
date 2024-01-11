// ignore_for_file: file_names

import 'dart:convert';
import 'package:cheerzclubvendor/cubit/Response/response.dart';
import 'package:cheerzclubvendor/networing/api_base_helper.dart';
import 'package:cheerzclubvendor/networing/endpoints.dart';
import 'package:result_type/result_type.dart';

abstract class notificationRepository {

  Future<Result> notificationcount();
  Future<Result> notificationList();
  Future<Result> GetoneNotif(String id);
}

class NotificatioNRepository extends notificationRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<Result> notificationcount() async {
    String responseString = await (_helper.get(
        APIEndPoints.urlString(EndPoints.notification),
        isHeaderRequired: true));

    Response response = Response.fromJson(json.decode(responseString));
    if (response.status == 1) {
      print(response.data);
      return Success(response.data);
    } else {
      //print(response.data);
      return Failure(response.message);
    }
  }

  @override
  Future<Result> notificationList() async {
    String responseString = await (_helper.get(
        APIEndPoints.urlString(EndPoints.notification),
        isHeaderRequired: true));

    Response response = Response.fromJson(json.decode(responseString));
    if (response.status == 1) {
      print(response.data);
      return Success(response.data);
    } else {
      //print(response.data);
      return Failure(response.message);
    }
  }

  @override
  Future<Result> GetoneNotif(String id) async {
    String responseString = await (_helper.get(
        APIEndPoints.urlString(EndPoints.singlenotification) + "/" + id.toString(),
        isHeaderRequired: true));
    Response response = Response.fromJson(json.decode(responseString));
    if (response.status == 1) {


      print("*****SINGLE Notif****"+response.data.toString());

      return Success(response.data);
    } else {
      print(response.data);
      return Failure(response.message);
    }
  }



}
