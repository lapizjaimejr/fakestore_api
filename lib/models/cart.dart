class Cart {
  int? id;
  int? userId;
  DateTime? date;
  List<dynamic>? products;

  Cart({
    this.id,
    this.userId,
    this.date,
    this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> item) {
    return Cart(
      id: item['id'],
      userId: item['userId'],
      date: DateTime.parse(item['date']),
      products: item['products'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'products': products,
    };
  }
}
