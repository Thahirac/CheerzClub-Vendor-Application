// ignore_for_file: file_names

import 'dart:convert';
import 'package:cheerzclubvendor/cubit/Response/response.dart';
import 'package:cheerzclubvendor/networing/api_base_helper.dart';
import 'package:cheerzclubvendor/networing/endpoints.dart';
import 'package:result_type/result_type.dart';

abstract class dashbordRepository {

  Future<Result> getOrders();
}

class DashBordRepository extends dashbordRepository {
  ApiBaseHelper _helper = ApiBaseHelper();


  @override
  Future<Result> getOrders() async {
    String responseString = await _helper.get(
        APIEndPoints.urlString(
          EndPoints.mydashboard,
        ),
        isHeaderRequired: true);

    Response response = Response.fromJson(json.decode(responseString));
    if (response.status == 1) {
      print("***MY**ORDERS***"+response.data.toString());
      return Success(response.data['orders']);
    } else {
      return Failure(response.message);
    }
  }
}
