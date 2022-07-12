import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  ApiService get service => GetIt.I<ApiService>();

  Future<Cart> getCart(cartID) async {
    return await service.getAllFromCart(cartID);
  }

  Future<Product> getProduct(prodID) async {
    return await service.getProduct(prodID);
  }

  Future<bool> deleteCart(cartID) async {
    return await service.deleteCart(cartID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: getCart('1'),
        builder: (BuildContext context, AsyncSnapshot<Cart?> cartSnapshot) {
          if (!cartSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartSnapshot.data == null) {
            return const Center(
              child: Text('No data available'),
            );
          }

          final products = cartSnapshot.data!.products;
          return ListView.separated(
            itemCount: products!.length,
            separatorBuilder: (_, __) => const Divider(thickness: 1),
            itemBuilder: (_, index) {
              final product = products[index];
              return FutureBuilder(
                future: getProduct(product['productId']),
                builder: (BuildContext context,
                    AsyncSnapshot<Product?> productSnapshot) {
                  if (!productSnapshot.hasData) {
                    return const LinearProgressIndicator();
                  }

                  final p = productSnapshot.data;
                  if (p == null) {
                    return const Text('No product found');
                  }

                  return ListTile(
                    title: Text(p.title.toString()),
                    leading: Image.network(
                      p.image.toString(),
                      height: 40,
                    ),
                    subtitle: Text(
                      'Quantity: ' + product['quantity'].toString(),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await deleteCart('1');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cart deleted successfully.'),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 90,
        width: double.infinity,
        color: Colors.green,
        child: TextButton(
          onPressed: () {},
          child: const Text(
            'Order Now',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
