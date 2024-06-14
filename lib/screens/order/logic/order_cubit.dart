import 'package:bloc/bloc.dart';
import 'package:evital_patient/screens/order/logic/order_repo.dart';
import 'package:evital_patient/screens/order/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  Map<String, String> statusMap = {
    'All': '',
    'Pending': 'pending',
    'Confirmed': 'confirmed',
    'Shipped': 'shipped',
    'Completed': 'completed',
    'Invalid': 'invalid',
    'Cancelled': 'cancelled',
    'Ready for Pickup': 'ready_for_pickup',
  };
  Map<String, String> familyMap = {
    'All': '',
    'All1': '',
    'All2': '',
  };

  final TextEditingController statusController =
      TextEditingController(text: "All");
  final TextEditingController billController = TextEditingController(text: "");
  final TextEditingController orderController = TextEditingController(text: "");
  final TextEditingController familyController =
      TextEditingController(text: "All");
  int currentPage = 0;
  bool isLoading = false;
  bool isRemain = true;
  List<OrderModel> orders = [];
  OrderRepo orderRepo = OrderRepo();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    familyController.text = "All";
    statusController.text = "All";
    billController.text = "";
    orderController.text = "";
    isRemain = true;
    // monitor network fetch
    if (isLoading) return;
    isLoading = true;
    emit(OrdersLoading());
    currentPage = 0;
    orders = [];
    if (isRemain) {
      await fetchOrders(
        pageNumber: currentPage + 1,
        status: statusMap[statusController.text.toString()] ?? "",
        orderNumber: orderController.text,
        billNo: billController.text,
        patientId: familyMap[familyController.text.toString()] ?? "",
      );
    }

    isLoading = false;
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onReset() async {
    familyController.text = "All";
    statusController.text = "All";
    billController.text = "";
    orderController.text = "";
    isRemain = true;
    // monitor network fetch
    isLoading = true;
    emit(OrdersLoading());
    currentPage = 0;
    orders = [];
    if (isRemain) {
      await fetchOrders(
        pageNumber: currentPage + 1,
        status: statusMap[statusController.text.toString()] ?? "",
        orderNumber: orderController.text,
        billNo: billController.text,
        patientId: familyMap[familyController.text.toString()] ?? "",
      );
    }
    isLoading = false;
  }

  void onFilterApply() async {
    isRemain = true;
    // monitor network fetch
    if (isLoading) return;
    isLoading = true;
    emit(OrdersLoading());
    currentPage = 0;
    orders = [];
    if (isRemain) {
      await fetchOrders(
        pageNumber: currentPage + 1,
        status: statusMap[statusController.text.toString()] ?? "",
        orderNumber: orderController.text,
        billNo: billController.text,
        patientId: familyMap[familyController.text.toString()] ?? "",
      );
    }

    isLoading = false;
    // if failed,use refreshFailed()
    // refreshController.refreshCompleted();
  }

  void onLoading() async {
    if (isRemain) {
      await fetchOrders(
        pageNumber: currentPage + 1,
        status: statusMap[statusController.text.toString()] ?? "",
        orderNumber: orderController.text,
        billNo: billController.text,
        patientId: familyMap[familyController.text.toString()] ?? "",
      );
    }
    refreshController.loadComplete();
  }

  OrderCubit() : super(OrderInitial()) {
    isRemain = true;
    if (isLoading) return;
    isLoading = true;
    emit(OrdersLoading());
    fetchOrders(
      pageNumber: currentPage + 1,
      status: statusMap[statusController.text.toString()] ?? "",
      orderNumber: orderController.text,
      billNo: billController.text,
      patientId: familyMap[familyController.text.toString()] ?? "",
    );
  }

  Future<void> fetchOrders({
    required int pageNumber,
    required String status,
    required String orderNumber,
    required String billNo,
    required String patientId,
  }) async {
    try {
      final response = await orderRepo.findList(
        pageNumber: "$pageNumber",
        status: status,
        orderNumber: orderNumber,
        billNo: billNo,
        patientId: '',
      );
      if (isRemain == true && response.length < 20) {
        isRemain = false;

      }
      orders.addAll(response);
      currentPage = pageNumber;
      emit(OrdersSuccess(orders));
    } catch (e) {
      emit(OrdersError('An error occurred: $e'));
    } finally {
      isLoading = false;
    }
  }
}
