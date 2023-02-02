import 'package:flutter/material.dart';
import 'package:hyper_ui/service/product_service/product_service.dart';
import 'package:hyper_ui/state_util.dart';
import '../view/product_form_view.dart';

class ProductFormController extends State<ProductFormView>
    implements MvcController {
  static late ProductFormController instance;
  late ProductFormView view;

  @override
  void initState() {
    instance = this;
    if (widget.item != null) {
      id = widget.item!["id"];
      photo = widget.item!["photo"];
      productName = widget.item!["product_name"];
      price = widget.item!["price"];
      description = widget.item!["description"];
    }
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  int? id;
  String? photo;
  String? productName;
  double? price;
  String? description;

  bool get isEditMode {
    return widget.item != null;
  }

  doSave() async {
    print("photo : $photo");
    print("productName : $productName");
    print("price : $price");
    print("description : $description");

    if (isEditMode) {
      ProductService.update(
        id: id!,
        value: {
          "id": id,
          "photo": photo,
          "product_name": productName,
          "price": price,
          "description": description,
        },
      );
    } else {
      ProductService.add({
        "photo": photo,
        "product_name": productName,
        "price": price,
        "description": description,
      });
    }

    Get.back();
  }
}
