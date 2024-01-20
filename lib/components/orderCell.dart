import 'package:Vookad/config/colors.dart';
import 'package:Vookad/models/orders.dart';
import 'package:flutter/material.dart';
class OrderCell extends StatelessWidget {
  final Order order;
  const OrderCell({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
            color: AppColors.white, // Set your desired background color here
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.12),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],// Optional: Add rounded corners
          ),
      child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order on ${order.createdAt}"
            ),
            Text(
              "₹ ${order.total}",
              style: const TextStyle(color: AppColors.bgPrimary, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cooked by ${order.items.first.chefName}",
              style:const TextStyle(color: AppColors.bgPrimary, fontSize: 14)
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.bgPrimary,
              ),
              child: Text(
              order.status,
              style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            ),
          ],
        ),
        DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('quantity')),
            ],
            rows: order.items.map((e) =>
                DataRow(cells: [
                  DataCell(Text(e.pdtName)),
                  DataCell(Text(e.pdt.name)),
                  DataCell(Text(e.quantity.toString())),
                ])
              ).toList(),
        )
      ],
    ),
    );
  }
}
