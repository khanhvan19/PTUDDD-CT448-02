import 'package:flutter/material.dart';
import 'package:myshop/ui/shared/app_drawer.dart';
import 'package:provider/provider.dart';

import 'order_manager.dart';
import 'order_item_card.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('build orders');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yours Orders'),
      ),
      drawer: const AppDrawer(),
      body: Consumer<OrdersManager>(
        builder: (ctx, ordersManager, child) {
          return ListView.builder(
            itemCount: ordersManager.orderCount,
            itemBuilder: (ctx, i) => OrderItemCard(ordersManager.orders[i]),
          );
        },
      ),
    );
  }
}