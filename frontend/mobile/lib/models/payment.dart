class Payment {
  final int id;
  final String paymentCode;
  final double amount;
  final double? customerGiven;
  final double? changeDue;
  final String status;
  final String? paymentMethod;
  final String currency;
  final String? transactionId;
  final String? note;
  final DateTime? paymentDay;
  final int userId;
  final int? cartId;

  Payment({
    required this.id,
    required this.paymentCode,
    required this.amount,
    this.customerGiven,
    this.changeDue,
    required this.status,
    this.paymentMethod,
    required this.currency,
    this.transactionId,
    this.note,
    this.paymentDay,
    required this.userId,
    this.cartId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      paymentCode: json['payment_code'],
      amount: json['amount'] != null ? double.parse(json['amount'].toString()) : 0.0,
      customerGiven: json['customer_given'] != null ? double.parse(json['customer_given'].toString()) : null,
      changeDue: json['change_due'] != null ? double.parse(json['change_due'].toString()) : null,
      status: json['status'] ?? 'pending',
      paymentMethod: json['payment_method'],
      currency: json['currency'] ?? 'USD',
      transactionId: json['transaction_id'],
      note: json['note'],
      paymentDay: json['payment_day'] != null ? DateTime.parse(json['payment_day']) : null,
      userId: json['user_id'],
      cartId: json['cart_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'payment_code': paymentCode,
      'amount': amount,
      'customer_given': customerGiven,
      'change_due': changeDue,
      'status': status,
      'payment_method': paymentMethod,
      'currency': currency,
      'transaction_id': transactionId,
      'note': note,
      'payment_day': paymentDay?.toIso8601String(),
      'user_id': userId,
      'cart_id': cartId,
    };
  }

  Payment copyWith({
    int? id,
    String? paymentCode,
    double? amount,
    double? customerGiven,
    double? changeDue,
    String? status,
    String? paymentMethod,
    String? currency,
    String? transactionId,
    String? note,
    DateTime? paymentDay,
    int? userId,
    int? cartId,
  }) {
    return Payment(
      id: id ?? this.id,
      paymentCode: paymentCode ?? this.paymentCode,
      amount: amount ?? this.amount,
      customerGiven: customerGiven ?? this.customerGiven,
      changeDue: changeDue ?? this.changeDue,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      currency: currency ?? this.currency,
      transactionId: transactionId ?? this.transactionId,
      note: note ?? this.note,
      paymentDay: paymentDay ?? this.paymentDay,
      userId: userId ?? this.userId,
      cartId: cartId ?? this.cartId,
    );
  }
}
