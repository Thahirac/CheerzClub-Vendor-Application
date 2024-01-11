import 'dart:convert';
import 'dart:io';
//import 'package:Vfuel/Utils/managers/user_manager.dart';
import 'package:cheerzclubvendor/utils/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'app_exception.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ApiBaseHelper {
  Map<String, String> commonHeaders = {
    'Content-Type': 'application/json; charset=utf-8',
  };

  Future<dynamic> get(String url, {bool isHeaderRequired = false}) async {
    var responseJson;
    if (isHeaderRequired) {
      var token = await UserManager.instance.getToken();
      print(token);

      commonHeaders.addAll({'Authorization': 'Bearer $token'});
    }
    try {
      final response = await http.get(Uri.parse(url), headers: commonHeaders);
      responseJson = _returnResponse(response);
    } on SocketException {
      Fluttertoast.showToast(
          msg: "No Internet connection",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print('No network connection');

      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body,
      {bool isHeaderRequired = false}) async {
    print('Api Post, url $url');
    var responseJson;
    if (isHeaderRequired) {
      var token = await UserManager.instance.getToken();
      commonHeaders.addAll({'Authorization': 'Bearer $token'});
    }
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(body), headers: commonHeaders);
      responseJson = _returnResponse(response);

      print(
          "------------------------track lineStart--------------------------------");
      print(
          "------------------------track line--------------------------------");
      print(
          "------------------------track line--------------------------------");
      print(
          "------------------------track line--------------------------------");
      print(
          "------------------------track line--------------------------------");
      print(
          "------------------------track lineEnd--------------------------------");

      print(url);
      // print("Response:" + response.body);
    } on SocketException {
      Fluttertoast.showToast(
          msg: "No Internet connection",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print('No network connection');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body,
      {bool isHeaderRequired = false}) async {
    //print(body.toString());
    print('Api Put, url $url');
    if (isHeaderRequired) {
      var token = await UserManager.instance.getToken();
      commonHeaders.addAll({'Authorization': 'Bearer $token'});
    }
    var responseJson;
    try {
      final response = await http.put(Uri.parse(url),
          body: json.encode(body), headers: commonHeaders);
      responseJson = _returnResponse(response);
    } on SocketException {
      Fluttertoast.showToast(
          msg: "No Internet connection",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print('No network connection');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url,
      {dynamic body = null, bool isHeaderRequired = false}) async {
    print('Api delete, url $url');
    if (isHeaderRequired) {
      var token = await UserManager.instance.getToken();
      commonHeaders.addAll({'Authorization': 'Bearer $token'});
    }
    var apiResponse;
    try {
      final response =
      await http.delete(Uri.parse(url), headers: commonHeaders);
      apiResponse = _returnResponse(response);
    } on SocketException {
      Fluttertoast.showToast(
          msg: "No Internet connection",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print('No network connection');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      //(responseJson);
      return response.body.toString();
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
