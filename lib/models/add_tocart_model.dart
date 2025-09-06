import 'package:ecommerce_new/models/peoduct_item_model.dart';

class AddToCartModel {
  final String id;
  final ProductItemModel Product;
  final ProductSize size;
  final int quantity;

  AddToCartModel({
    required this.id,
    required this.Product,
    required this.size,
    required this.quantity,
  });
  double get totalprice => Product.price * quantity;

  AddToCartModel copyWith({
    String? id,
    ProductSize? size,
    int? quantity,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      Product: Product ?? this.Product,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'product': Product.toMap()});
    result.addAll({'size': size.name});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'] ?? '',
      Product: ProductItemModel.fromMap(map['product']),
      size: ProductSize.fromString(map['size']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }
}

List<AddToCartModel> dummycart = [];
