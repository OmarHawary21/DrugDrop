import 'dart:math';

import 'package:drug_drop2/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_item_model.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItemModel orderItem;

  const OrderItem(this.orderItem);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${LocaleKeys.total_price.tr()}: ${widget.orderItem.total} ${LocaleKeys.sp.tr()}',
              style: TextStyle(
                color: primary,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '${LocaleKeys.date.tr()}: ${DateFormat('hh:mm  dd/MM/yyyy').format(widget.orderItem.dateTime)}',
              style: TextStyle(
                color: primary,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                color: primary,
              ),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.all(10),
              height: min(
                  widget.orderItem.products.length *
                      MediaQuery.of(context).size.height *
                      0.35,
                  MediaQuery.of(context).size.height * 0.35),
              child: ListView(
                children: widget.orderItem.products
                    .map(
                      (prod) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  prod.title,
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${LocaleKeys.price.tr()}: ${prod.price}  ${LocaleKeys.sp.tr()}',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 13),
                                    Text(
                                      'x${prod.quantity}',
                                      style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: primary,
                            indent: 20,
                            endIndent: 20,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
