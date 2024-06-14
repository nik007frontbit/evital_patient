import 'package:evital_patient/screens/order/logic/order_cubit.dart';
import 'package:evital_patient/screens/order/model/order_model.dart';
import 'package:evital_patient/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.blue,
          title: const Text(
            "My Orders",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () => _showActionSheet(context, () {
                          Navigator.pop(context);
                          BlocProvider.of<OrderCubit>(context).onReset();
                        }, () {
                          Navigator.pop(context);
                          BlocProvider.of<OrderCubit>(context).onFilterApply();
                        }),
                    icon: const Icon(
                      Icons.list,
                      color: AppColors.white,
                    ));
              },
            )
          ],
        ),
        body: BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
          if (state is OrderInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersLoading &&
              (context.read<OrderCubit>().currentPage == 1)) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersSuccess) {
            return SmartRefresher(
                enablePullUp: true,
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = const SizedBox();
                    } else if (mode == LoadStatus.loading) {
                      body = const CircularProgressIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = const Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = const Text("release to load more");
                    } else {
                      body = const Text("No more Data");
                    }
                    return SizedBox(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller:
                    BlocProvider.of<OrderCubit>(context).refreshController,
                onRefresh: () =>
                    BlocProvider.of<OrderCubit>(context).onRefresh(),
                onLoading: () =>
                    BlocProvider.of<OrderCubit>(context).onLoading(),
                child: ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    return commonOrderItem(
                      orderModel: order,
                    );
                  },
                ));
          } else if (state is OrdersError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  void _showActionSheet(
      BuildContext context, Function() resetTap, Function() applyTap) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    margin: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  )
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Filter",
                      style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.grey,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    commonTextField(
                        BlocProvider.of<OrderCubit>(context).billController,
                        "Bill Number"),
                    const SizedBox(
                      height: 10,
                    ),
                    commonTextField(
                        BlocProvider.of<OrderCubit>(context).orderController,
                        "order Number"),
                    const SizedBox(
                      height: 10,
                    ),
                    commonDropdown(
                      BlocProvider.of<OrderCubit>(context).familyController,
                      'Family Member',
                      BlocProvider.of<OrderCubit>(context)
                          .familyMap
                          .keys
                          .toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    commonDropdown(
                      BlocProvider.of<OrderCubit>(context).statusController,
                      'Order Status',
                      BlocProvider.of<OrderCubit>(context)
                          .statusMap
                          .keys
                          .toList(),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: resetTap,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  border: Border.all(
                                    color: AppColors.blue,
                                  )),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    color: AppColors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Reset",
                                      style: TextStyle(
                                        color: AppColors.blue,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: applyTap,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.blue,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)),
                                  border: Border.all(
                                    color: AppColors.blue,
                                  )),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: AppColors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Apply",
                                      style: TextStyle(
                                        color: AppColors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  DropdownButtonFormField<String> commonDropdown(
    TextEditingController controller,
    String name,
    List<String> items,
  ) {
    return DropdownButtonFormField<String>(
      value: controller.text.isEmpty ? null : controller.text,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(color: AppColors.black)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          controller.text = newValue;
        }
      },
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(
          color: AppColors.blue,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.blue,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$name is Required';
        }
        return null;
      },
    );
  }

  commonTextField(
    TextEditingController controller,
    String name,
  ) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(
          color: AppColors.blue,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.blue,
        )),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$name is Required';
        }
        return null;
      },
    );
  }

  CupertinoButton commonOrderItem({
    required OrderModel orderModel,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: AppColors.grey.withOpacity(0.5),
        ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: "Bill No. ",
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 13,
                        ),
                        children: [
                      TextSpan(
                        text:
                            orderModel.billNo == "" ? "--" : orderModel.billNo,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ])),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  orderModel.orderDeliveryDatetime.toString(),
                  style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "₹ ${orderModel.amount}",
                  style: const TextStyle(
                      color: AppColors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    orderModel.orderStatus.toString(),
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "#${orderModel.orderNumber}",
                  style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}
