import 'package:flutter/foundation.dart';
import 'package:zapx/Zap/extensions/zap_translate.dart';
import 'package:zapx/zapx.dart';

class ValidatorUtils {
  static String? urlValidator(String? v) {
    if (v!.isEmpty) {
      return "Please enter url".ztr;
    } else if (!Zap.isValidUrl(v)) {
      return 'Please enter a valid url'.ztr;
    }
    return null;
  }

  static String? emptyValidator(String? v) {
    if (v==null ||v.trim().isEmpty) {
      return "This field is required".ztr;
    }
    return null;
  }

  static String? authValidator(String? v, String field) {
    if (field == 'email') {
      if (v!.isEmpty) {
        return "Please enter email".ztr;
      } else if (!Zap.isValidEmail(v)) {
        return 'Please enter a valid email'.ztr;
      }
    } else if (field == 'user') {
      if (v!.isEmpty) {
        return "please enter username".ztr;
      }
    } else if (field == 'password') {
      if (v!.isEmpty) {
        return "Please enter password".ztr;
      }else if(kDebugMode){
        return null;
      } else if (v.length < (6)) {
        return 'Password must be at least 6 characters'.ztr;
      }
    }
    return null;
  }
}
