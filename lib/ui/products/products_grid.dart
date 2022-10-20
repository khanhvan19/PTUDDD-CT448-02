import 'package:flutter/material.dart';

import 'product_grid_tile.dart';
import 'products_manager.dart';

import '../../models/products.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  const ProductsGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductManager();
    // final products = showFavorites ? productsManager.favoriteItems : productsManager.items;
    final products = context.select<ProductManager, List<Product>>(
      (productsManager) => showFavorites 
        ? productsManager.favoriteItems 
        : productsManager.items
    );
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGridTile(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}