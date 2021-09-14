import 'package:demo_05/providers/orders.dart';
import 'package:demo_05/widgets/app_drawer.dart';
import 'package:demo_05/widgets/order_item.dart' as ord;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => ord.OrderItem(orderData.orders[i]),
      ),
    );
  }
}
