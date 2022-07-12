import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/product.dart';
import '../services/api_service.dart';
import 'all_category.dart';
import 'cart_screen.dart';
import 'product_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  ApiService get service => GetIt.I<ApiService>();

  Future<List<Product>> getAllProducts() async {
    return await service.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.view_list),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AllCategoryScreen()),
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.shopping_cart),
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (_) => const CartScreen(),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: getAllProducts(),
            builder: (_, AsyncSnapshot<List<Product>> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              final products = snapshot.data!;
              return ListView.separated(
                separatorBuilder: (_, __) => const Divider(thickness: 1),
                itemCount: products.length,
                itemBuilder: ((context, index) {
                  final product = snapshot.data![index];
                  return ListTile(
                    title: Text(product.title.toString()),
                    leading: Image.network(
                      product.image.toString(),
                      height: 50,
                      width: 50,
                    ),
                    subtitle: Text(product.price.toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(id: product.id),
                        ),
                      );
                    },
                  );
                }),
              );
            }),
      ),
    );
  }
}
