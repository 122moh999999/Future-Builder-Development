
import 'package:logger/logger.dart';

var logger = Logger();
bool isInApp = false;
 final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];


UserModel userData = UserModel();

class UserModel {
  String? token;
  int? userId;
  String? employeeSig;

  String? userName, employeeName, email;
  int? employeeId, companyId;
  LocationCoordinates? companyLocation;

  UserModel(
      {this.employeeSig,
      this.token,
      this.userId,
      this.companyId,
      this.companyLocation,
      this.employeeId,
      this.employeeName,
      this.userName,
      this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    if (json['user_id'] is num) {
      userId = json['user_id'];
    }
    employeeSig = json['sig_hash'];
    email = json['email'];
    userName = json['user_name']?.toString();
    employeeName = json['employee_name'];
    employeeId = json['employee_id'];
    companyId = json['company_id'];
    companyLocation = json['company_location'] != null
        ? LocationCoordinates.fromJson(json['company_location'])
        : null;
  }

  Map toMap() => {
        'token': token,
        'email': email,
        'user_id': userId,
        'sig_hash': employeeSig,
        'user_name': userName,
        'employee_name': employeeName,
        'employee_id': employeeId,
        'company_id': companyId,
        'company_location': companyLocation?.toMap(),
      };
}

class LocationCoordinates {
  double? latitude;
  double? longitude;

  LocationCoordinates({this.latitude, this.longitude});
  LocationCoordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  Map toMap() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}
