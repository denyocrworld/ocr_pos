import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import 'package:hyper_ui/service/order_service/order_service_util.dart';
import 'package:hyper_ui/service/product_service/product_service.dart';

class PosController extends State<PosView> implements MvcController {
  static late PosController instance;
  late PosView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  double get total {
    double itemTotal = 0.0;

    for (var product in ProductService.products) {
      product["qty"] ??= 0;
      itemTotal += product["qty"] * product["price"];
    }
    return itemTotal;
  }

  String? paymentMethod;
  doCheckout() async {
    await OrderService.checkout(
      paymentMethod: paymentMethod ?? "Cash",
      items: ProductService.products,
      total: total,
    );

    if (OrderController.instance.mounted) {
      OrderController.instance.setState(() {});
    }

    Get.back();

    showInfoDialog("Order berhasil!");
  }
}
