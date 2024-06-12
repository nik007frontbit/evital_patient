import 'package:dio/dio.dart';
import 'package:evital_patient/api/api.dart';

class SignUpRepo {
  Api api = Api();

  Future<Map<String, dynamic>> sendOpt({
    required String firstName,
    required String lastName,
    required String phone,
    required String referral,
  }) async {
    try {
      Response response = await api.sendRequest.post("/signup_sendotp", data: {
        "mobile": phone,
        "firstname": firstName,
        "lastname": lastName,
        "referral_code": referral,
        "platform": "android",
        "user_id": "",
        "patient_id": "",
        "device_id": "9348d663fde2493f",
        "accesstoken": "",
        "fcmtoken":
            "cjGb_15pQCWrrbSqVtu7oV:APA91bEEgVgLOpRKx43ruK4-JI80HGqZ9KUzSwz1zMc8f--rFjyLSl8WyBfL01gNLmhyqkfsF2FWD94CLE-Hfi2q1DMmnOC9apyhF62PH2lqfwussbqfHGnQJX-ODrRk3MU9emOBxTiX",
        "app_version": "33",
        "os": "android",
        "apikey": "adDEWRWEF46546DFDSFsdfsfsdfsdfsl"
      });

      // Check the status code in the response
      if (response.data['status_code'] == "1") {
        // OTP sent successfully
        return {
          'success': true,
          'message': response.data['status_message'],
          'mobile': response.data['data']['mobile'],
        };
      } else {
        // Handle error case
        return {
          'success': false,
          'message':
              response.data['status_message'] ?? 'Unknown error occurred',
        };
      }
    } catch (e) {
      // Handle any other errors (like network issues)
      return {
        'success': false,
        'message': 'Failed to send OTP. Please try again.',
      };
    }
  }

  Future<Map<String, dynamic>> sendSignDetails({
    required String firstName,
    required String lastName,
    required String phone,
    required String referral,
    required String password,
    required String otp,
    required String pinCode,
  }) async {
    try {
      Response response = await api.sendRequest.post("/signup", data: {
        "mobile": phone,
        "firstname": firstName,
        "lastname": lastName,
        "password": password,
        "otp": otp,
        "pincode": pinCode,
        "referral_code": referral,
        "platform": "android",
        "utm_source": "C00NC",
        "utm_medium": "android",
        "utm_campaign": "white_label",
        "user_id": "",
        "patient_id": "",
        "device_id": "9348d663fde2493f",
        "accesstoken": "",
        "fcmtoken":
            "cjGb_15pQCWrrbSqVtu7oV:APA91bEEgVgLOpRKx43ruK4-JI80HGqZ9KUzSwz1zMc8f--rFjyLSl8WyBfL01gNLmhyqkfsF2FWD94CLE-Hfi2q1DMmnOC9apyhF62PH2lqfwussbqfHGnQJX-ODrRk3MU9emOBxTiX",
        "app_version": "33",
        "os": "android",
        "apikey": "adDEWRWEF46546DFDSFsdfsfsdfsdfsl",
      });

      // Check the status code in the response
      if (response.data['status_code'] == "1") {
        // OTP sent successfully
        return {
          'success': true,
          'message': response.data['status_message'],
          'mobile': response.data['data']['mobile'] ?? phone,
        };
      } else {
        // Handle error case
        return {
          'success': false,
          'message':
              response.data['status_message'] ?? 'Unknown error occurred',
        };
      }
    } catch (e) {
      // Handle any other errors (like network issues)
      return {
        'success': false,
        'message': 'Failed to send OTP. Please try again.',
      };
    }
  }
}
