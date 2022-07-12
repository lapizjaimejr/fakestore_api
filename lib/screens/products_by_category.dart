import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/product.dart';
import '../services/api_service.dart';
import 'product_detail.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final String categoryName;
  ApiService get service => GetIt.I<ApiService>();

  const ProductsByCategoryScreen({Key? key, required this.categoryName})
      : super(key: key);

  Future<List<Product>> getProductsByCategory(categoryName) async {
    return await service.getProductsByCategory(categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: getProductsByCategory(categoryName),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data!;

          return ListView.separated(
            separatorBuilder: (_, __) => const Divider(thickness: 1),
            itemCount: products.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(products[index].title.toString()),
                leading: Image.network(
                  products[index].image.toString(),
                  height: 50,
                  width: 50,
                ),
                subtitle: Text(products[index].price.toString()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailScreen(id: products[index].id),
                    ),
                  );
                },
              );
            }),
          );
        },
      ),
    );
  }
}
