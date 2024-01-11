// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'package:cheerzclubvendor/networing/api_base_helper.dart';
import 'package:cheerzclubvendor/networing/endpoints.dart';
import 'package:result_type/result_type.dart';
import 'package:cheerzclubvendor/cubit/Response/response.dart';

abstract class CheckOrderRepository {

  Future<Result?> checkorder(String? user_secret,);
  Future<Result?> orderdelivery(String? user_secret,String? restaurant_secret,String? table);

}

class OrderRepository extends CheckOrderRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  Future<Result?> checkorder(String? user_secret,) async {
    String responseString = await (_helper.post(
        APIEndPoints.urlString(EndPoints.checkorderdetails),
        {
          "user_secret": user_secret,
        },
        isHeaderRequired: true
        )
    );

    Response response = Response.fromJson(json.decode(responseString));

  try{
    if (response.status == 1) {
      print(response.data.toString() +"*******KKKKKKK******");
      return Success(response.data);
    }
    else {
      print(response.data);
      return Failure(response.message);
    }
  }catch(e){
    print(e);
  }

  }


  @override
  Future<Result?> orderdelivery(String? user_secret,String? restaurant_secret,String? table) async {
    String responseString = await (_helper.post(
        APIEndPoints.urlString(EndPoints.orderdelivery),
        {
          "user_secret": user_secret,
          "restaurant_secret": restaurant_secret,
          "table":table,
        },
        isHeaderRequired: true
    )
    );

    Response response = Response.fromJson(json.decode(responseString));

    try{
      if (response.status == 1) {
        print(response.data.toString() +"*******Noooooooo******");
        return Success(response.data);
      }
      else {
        print(response.data);
        return Failure(response.message);
      }
    }catch(e){
      print(e);
    }

  }



}
