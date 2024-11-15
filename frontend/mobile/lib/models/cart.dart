class Cart {
  final int productId;
  final String name;
  final double price;
  final int quantity;
  final double totalPrice;
  final DateTime invoiceDate;

  Cart({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.invoiceDate,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      productId: json['product_id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      quantity: json['quantity'],
      totalPrice: double.parse(json['total_price'].toString()),
      invoiceDate: DateTime.parse(json['invoice_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'total_price': totalPrice,
      'invoice_date': invoiceDate.toIso8601String(),
    };
  }
}