import 'package:flutter/material.dart';
import 'package:myshop/ui/screens.dart';
import 'package:provider/provider.dart';

import 'user_product_list_tile.dart';
import 'products_manager.dart';
import '../shared/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';
  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async{
    await context.read<ProductManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh:() => _refreshProducts(context),
            child: buildUserProductListView(),
          );
        },
      ),
    );
  }

  Widget buildUserProductListView() {
    return Consumer<ProductManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductListTile(
                productsManager.items[i]
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }
}