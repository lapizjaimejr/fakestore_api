class OrderedProduct {
  int? userId;
  DateTime? date;
  List<Map<String, dynamic>>? products;

  OrderedProduct({this.userId, this.date, this.products});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'date': date!.toIso8601String(),
        'products': products,
      };
}
