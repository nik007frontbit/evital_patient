part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}
class OrdersLoading extends OrderState {}

class OrdersSuccess extends OrderState {
  final List<OrderModel> orders;
  OrdersSuccess(this.orders);
}

class OrdersError extends OrderState {
  final String message;
  OrdersError(this.message);
}