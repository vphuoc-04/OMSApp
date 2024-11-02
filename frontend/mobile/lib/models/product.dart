class Product {
  final int id;
  final int? addedBy;
  final String productCode;
  final String name;
  final String? description;
  final String? img;
  final int quantity;
  final double price;
  final double? originalPrice;
  final int? categoryId;
  final String status;
  final double? weight;
  final double? length;
  final double? width;
  final double? height;
  final Map<String, dynamic>? attributes; 
  final DateTime dateAdded;
  final DateTime? expiryDate;
  final int? spicinessLevel;

  Product({
    required this.id,
    this.addedBy,
    required this.productCode,
    required this.name,
    this.description,
    this.img,
    required this.quantity,
    required this.price,
    this.originalPrice,
    this.categoryId,
    required this.status,
    this.weight,
    this.length,
    this.width,
    this.height,
    this.attributes,
    required this.dateAdded,
    this.expiryDate,
    this.spicinessLevel,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      addedBy: json['added_by'],
      productCode: json['product_code'],
      name: json['name'],
      description: json['description'],
      img: json['img'],
      quantity: json['quantity'],
      price: double.parse(json['price'].toString()),
      originalPrice: json['original_price'] != null ? double.parse(json['original_price'].toString()) : null,
      categoryId: json['category_id'],
      status: json['status'],
      weight: json['weight'] != null ? double.parse(json['weight'].toString()) : null,
      length: json['length'] != null ? double.parse(json['length'].toString()) : null,
      width: json['width'] != null ? double.parse(json['width'].toString()) : null,
      height: json['height'] != null ? double.parse(json['height'].toString()) : null,
      attributes: json['attributes'] is Map<String, dynamic> ? json['attributes'] : null, 
      dateAdded: DateTime.parse(json['date_added']),
      expiryDate: json['expiry_date'] != null ? DateTime.parse(json['expiry_date']) : null,
      spicinessLevel: json['spiciness_level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'added_by': addedBy,
      'product_code': productCode,
      'name': name,
      'description': description,
      'img': img,
      'quantity': quantity,
      'price': price,
      'original_price': originalPrice,
      'category_id': categoryId,
      'status': status,
      'weight': weight,
      'length': length,
      'width': width,
      'height': height,
      'attributes': attributes,
      'date_added': dateAdded.toIso8601String(),
      'expiry_date': expiryDate?.toIso8601String(),
      'spiciness_level': spicinessLevel,
    };
  }
}
