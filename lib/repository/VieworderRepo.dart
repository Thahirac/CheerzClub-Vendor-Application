// ignore_for_file: file_names

import 'dart:convert';
import 'package:cheerzclubvendor/cubit/Response/response.dart';
import 'package:cheerzclubvendor/networing/api_base_helper.dart';
import 'package:cheerzclubvendor/networing/endpoints.dart';
import 'package:result_type/result_type.dart';

abstract class GetOneOrd {

  Future<Result> GetoneOrderGet(String id);

}

class GetOneOrder extends GetOneOrd {

  ApiBaseHelper _helper = ApiBaseHelper();


  @override
  Future<Result> GetoneOrderGet(String id) async {
    String responseString = await (_helper.get(
        APIEndPoints.urlString(EndPoints.vieworder) + "/" + id.toString(),
        isHeaderRequired: true));
    Response response = Response.fromJson(json.decode(responseString));
    if (response.status == 1) {
      print("*****SINGLE ORDER****"+response.data.toString());

      return Success(response.data);
    } else {
      print(response.data);
      return Failure(response.message);
    }
  }



}
