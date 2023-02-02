import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import '../../../service/order_service/order_service_util.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);

  Widget build(context, OrderController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: OrderService.orders.length,
                itemBuilder: (context, index) {
                  var item = OrderService.orders[index];

                  var date =
                      DateFormat("d MMM y kk:mm").format(item["created_at"]);
                  return ListTile(
                    leading: Text(
                      "#${index + 1}",
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(date),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID: ${item["id"]}"),
                        Text("${item["payment_method"]}"),
                      ],
                    ),
                    trailing: Text("${item["total"] ?? 0}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<OrderView> createState() => OrderController();
}
