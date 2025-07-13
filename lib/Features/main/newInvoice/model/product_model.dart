class Product {
  final String name;
  final String defaultUnitName;
  num quantity;
  int ProductID;
  final double price;
  final num stock;

  String? notes;
  int? RowNumber;
  String? RowSate;

  Product({
    required this.defaultUnitName,
    required this.ProductID,
    required this.name,
    required this.quantity,
    required this.price,
    required this.stock,
    this.RowSate = '',
    this.RowNumber = 1,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'ProductID': ProductID,
      'name': name,
      'price': price,
      'quantity': quantity,
      'defaultUnitName': defaultUnitName,
      'stock': stock,
      'RowNumber': RowNumber,
      'RowSate': RowSate,
      'Notes': notes,
    };
  }

  Product copyWith({
    String? name,
    String? defaultUnitName,
    num? quantity,
    int? ProductID,
    double? price,
    num? stock,
    int? RowNumber,
    String? RowSate,
    String? notes,
  }) {
    return Product(
      name: name ?? this.name,
      defaultUnitName: defaultUnitName ?? this.defaultUnitName,
      quantity: quantity ?? this.quantity,
      ProductID: ProductID ?? this.ProductID,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      RowNumber: RowNumber ?? this.RowNumber,
      RowSate: RowSate ?? this.RowSate,
      notes: notes ?? notes,
    );
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      ProductID: json['ProductID'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      defaultUnitName: json['defaultUnitName'],
      stock: json['stock'],
      RowNumber: json['RowNumber'],
      RowSate: json['RowSate'],
      notes: json['Notes'], // ✅
    );
  }
}
