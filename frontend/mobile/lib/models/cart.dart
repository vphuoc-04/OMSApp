class Cart {
  final int id;
  final int productId;
  final String name;
  final double price;
  final String img;
  final int quantity;
  final double totalPrice;
  final DateTime invoiceDate;

  Cart({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.img,
    required this.quantity,
    required this.totalPrice,
    required this.invoiceDate,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      productId: json['product_id'] ?? 0, 
      name: json['name'] ?? '', 
      price: json['price'] != null ? double.parse(json['price'].toString()) : 0.0, 
      quantity: json['quantity'] ?? 0, 
      img: json['img'] ?? '', 
      totalPrice: json['total_price'] != null ? double.parse(json['total_price'].toString()) : 0.0, 
      invoiceDate: json['invoice_date'] != null ? DateTime.parse(json['invoice_date']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'total_price': totalPrice,
      'invoice_date': invoiceDate.toIso8601String(),
    };
  }
}
