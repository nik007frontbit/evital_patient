import 'package:dio/dio.dart';
import 'package:evital_patient/screens/order/model/order_model.dart';

import '../../../api/api.dart';

class OrderRepo {
  ProductionApi api = ProductionApi();

  Future<List<OrderModel>> findList({
    required String pageNumber,
    required String status,
    required String orderNumber,
    required String billNo,
    required String patientId,

  }) async {
    try {
      Response response = await api.sendRequest.post("/orders/list", data: {
        "user_id": "7abqoQ2Jk4kTwL/fZlSGig==",
        "patient_id": patientId,
        "device_id": "465d4664c7ea102f",
        "accesstoken": "kch8OAKLsAgxryc1",
        "fcmtoken":
            "diPc5RrGSy2oB6C6HbMC6T:APA91bHZPWmSvuoRdVnRtkqfQQHpOPB8QM8SZ7aOMBwOAv_aoMvCqnBEZOoFZmo2tsYZFCdParH5ZrWiZulvvCbNiob3LOdE_-xil0MjXzd7sQVqXdr9Gkqs0akV7BMIlAvwqcZ-tH0x",
        "app_version": "10",
        "os": "android",
        "apikey": "R08mGEm4550Bi69AHobdH9E4QY02f1N7",
        "page": pageNumber,
        "order_status": status,
        "order_number": orderNumber,
        "bill_no": billNo,
      });

      // Check the status code in the response
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['data']['results'];
        return results.map((order) => OrderModel.fromJson(order)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      // Handle any other errors (like network issues)
      throw Exception('Failed to load orders');
    }
  }
}
