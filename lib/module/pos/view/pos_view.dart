import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';
import 'package:hyper_ui/service/product_service/product_service.dart';

class PosView extends StatefulWidget {
  const PosView({Key? key}) : super(key: key);

  Widget build(context, PosController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pos"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: ProductService.products.length,
                itemBuilder: (context, index) {
                  var item = ProductService.products[index];
                  item["qty"] ??= 0;

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(
                          item["photo"] ??
                              "https://i.ibb.co/S32HNjD/no-image.jpg",
                        ),
                      ),
                      title: Text(item["product_name"]),
                      subtitle: Text("${item["price"]} USD"),
                      trailing: SizedBox(
                        width: 120.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 12.0,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    if (item["qty"] == 0) return;
                                    item["qty"]--;
                                    controller.setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 9.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${item["qty"]}",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 12.0,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    item["qty"]++;
                                    controller.setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 9.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(12.0),
            child: QDropdownField(
              label: "Payment:",
              validator: Validator.required,
              items: const [
                {
                  "label": "Cash",
                  "value": "1",
                },
                {
                  "label": "Bank Transfer",
                  "value": "2",
                },
                {
                  "label": "OVO",
                  "value": "3",
                },
                {
                  "label": "GOPAY",
                  "value": "4",
                },
              ],
              onChanged: (value, label) {
                controller.paymentMethod = label;
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "${controller.total}",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () => controller.doCheckout(),
              child: const Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<PosView> createState() => PosController();
}
