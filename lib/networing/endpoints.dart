enum EndPoints {
  login,
  mydashboard,
  checkorderdetails,
  orderdelivery,
  notification,
  singlenotification,
  vieworder
}

class APIEndPoints {
  ///live link
  static String baseUrl = "https://";
  ///development link
  //static String baseUrl = "https://";
  static String urlString(EndPoints endPoint) {
    return baseUrl + endPoint.endPointString;
  }
}

extension EndPointsExtension on EndPoints {
  // ignore: missing_return
  String get endPointString {
    switch (this) {
      case EndPoints.login:
        return "auth/login";
      case EndPoints.mydashboard:
        return "dashboard";
      case EndPoints.checkorderdetails:
        return "check-order";
      case EndPoints.orderdelivery:
        return "deliver-order";
      case EndPoints.notification:
        return "notifications";
      case EndPoints.singlenotification:
        return "view/notification";
      case EndPoints.vieworder:
        return "view/order";
    }
  }
}
