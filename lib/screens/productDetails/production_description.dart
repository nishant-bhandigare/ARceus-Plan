import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductDescription extends StatelessWidget {
  final Product product;

  const ProductDescription({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(product.category, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(product.description, style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5)),
        ],
      ),
    );
  }
}
