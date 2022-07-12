import 'dart:convert';

import '../models/ordered_product.dart';
import '../models/product.dart';
import '../models/user_credentials.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const headers = {'Content-Type': 'application/json'};

  Future<dynamic> processLogin(String userName, String pass) {
    final userCredentials = UserCredentials(username: userName, password: pass);

    return http
        .post(Uri.parse('$baseUrl/auth/login'), body: userCredentials.toJson())
        .then((data) {
      if (data.statusCode == 200) {
        return json.decode(data.body);
      }
    }).catchError((err) => print(err));
  }

  Future<List<Product>> getProducts() async {
    return http.get(Uri.parse('$baseUrl/products')).then((data) {
      final products = <Product>[];

      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        for (var product in jsonData) {
          products.add(Product.fromJson(product));
        }
      }
      return products;
    }).catchError((err) => print(err));
  }

  Future<Product> getProduct(int prodID) async {
    return http.get(Uri.parse('$baseUrl/products/$prodID')).then((data) {
      var jsonData;

      if (data.statusCode == 200) {
        jsonData = json.decode(data.body);
      }
      return Product.fromJson(jsonData);
    }).catchError((err) => print(err));
  }

  Future<dynamic> getCategories() async {
    return http.get(Uri.parse('$baseUrl/products/categories')).then((data) {
      final categories = [];

      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        for (var category in jsonData) {
          categories.add(category);
        }

        return categories;
      }
    }).catchError((err) => print(err));
  }

  Future<List<Product>> getProductsByCategory(String categoryName) async {
    return http
        .get(Uri.parse('$baseUrl/products/category/$categoryName'))
        .then((data) {
      final products = <Product>[];

      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        for (var product in jsonData) {
          products.add(Product.fromJson(product));
        }
      }
      return products;
    }).catchError((err) => print(err));
  }

  Future<bool> updateCart(int cartID, int prodID) async {
    final updatedCart =
        OrderedProduct(userId: cartID, date: DateTime.now(), products: [
      {'productId': prodID, 'quantity': 2}
    ]);

    return http
        .put(Uri.parse('$baseUrl/carts/$cartID'),
            headers: headers, body: json.encode(updatedCart.toJson()))
        .then((data) {
      bool isUpdated = false;
      if (data.statusCode == 200) {
        isUpdated = true;
        final jsonData = json.decode(data.body);
        print('isUpdated: $isUpdated');
        print(jsonData);
      }
      return isUpdated;
    }).catchError((err) => print(err));
  }
}
