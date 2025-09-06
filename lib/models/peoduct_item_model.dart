enum ProductSize {
  S,
  M,
  L,
  XL;

  static ProductSize fromString(String size) {
    switch (size) {
      case 'S':
        return ProductSize.S;
      case 'M':
        return ProductSize.M;
      case 'L':
        return ProductSize.L;
      case 'XL':
        return ProductSize.XL;
      default:
        return ProductSize.S;
    }
  }
}

class ProductItemModel {
  final String id;
  final String name;
  final String imgurl;
  final String description;
  final double price;
  final bool isFavorite;
  final String category;
  final double averageRate;
  final String searchKey; // ✅ جديد

  ProductItemModel({
    required this.id,
    required this.name,
    required this.imgurl,
    this.description =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    required this.price,
    this.isFavorite = false,
    required this.category,
    this.averageRate = 4.5,
    String? searchKey, // ✅ نمرره اختياري
  }) : searchKey =
            searchKey ?? name.toLowerCase(); // ✅ لو مش مررته يتولد من name

  ProductItemModel copyWith({
    String? id,
    String? name,
    String? imgurl,
    String? description,
    double? price,
    bool? isFavorite,
    String? category,
    double? averageRate,
    int? quantity,
    ProductSize? size,
    String? searchKey,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgurl: imgurl ?? this.imgurl,
      description: description ?? this.description,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
      averageRate: averageRate ?? this.averageRate,
      searchKey: searchKey ?? this.searchKey,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'price': price});
    result.addAll({'category': category});
    result.addAll({'imgurl': imgurl});
    result.addAll({'averageRate': averageRate});
    result.addAll({'description': description});
    result.addAll({'isFavorite': isFavorite});
    result.addAll({'searchKey': searchKey}); // ✅ جديد

    return result;
  }

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    return ProductItemModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imgurl: map['imgurl'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      isFavorite: map['isFavorite'] ?? false,
      category: map['category'] ?? '',
      averageRate: (map['averageRate'] ?? 0).toDouble(),
      description: map['description'] ?? '',
      searchKey:
          map['searchKey'] ?? (map['name'] ?? '').toLowerCase(), // ✅ fallback
    );
  }
}
