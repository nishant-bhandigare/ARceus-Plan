import 'package:arceus_plan/screens/productDetails/add_to_cart_button.dart';
import 'package:arceus_plan/screens/productDetails/product_image_carousal.dart';
import 'package:arceus_plan/screens/productDetails/production_description.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../arvr/arViewScreen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ProductImageCarousel(imageList: widget.product.imageUrls),
            const SizedBox(height: 10),
            ProductDescription(product: widget.product),
            const SizedBox(height: 10),
            const ColorAndQuantitySelector(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AddToCartButton(imgString: widget.product.imageUrls[0],),
    );
  }
}

class ColorAndQuantitySelector extends StatefulWidget {
  const ColorAndQuantitySelector({super.key});

  @override
  _ColorAndQuantitySelectorState createState() => _ColorAndQuantitySelectorState();
}

class _ColorAndQuantitySelectorState extends State<ColorAndQuantitySelector> {
  int quantity = 1;
  final List<Color> colors = [Colors.grey, Colors.teal, Colors.amber];
  int selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Color Selection
          Row(
            children: [
              const Text(
                "Color",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 10),
              Row(
                children: List.generate(colors.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColorIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: colors[index],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedColorIndex == index ? Colors.black : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          // Quantity Selector
          Row(
            children: [
              _buildQuantityButton(Icons.remove, () {
                if (quantity > 1) {
                  setState(() {
                    quantity--;
                  });
                }
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "$quantity",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              _buildQuantityButton(Icons.add, () {
                setState(() {
                  quantity++;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: Icon(icon, size: 18, color: Colors.black54),
      ),
    );
  }
}

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({super.key, required this.imgString});
  final String imgString;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Add to Cart Button
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                print("Button Pushed");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ARViewScreen(
                        itemImg: widget.imgString,
                      ),
                    ),
                  );
              },
              child: const Text(
                "Add to Cart",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Cart Icon Button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                print("Navigating to ARViewScreen with image: ${widget.imgString}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ARViewScreen(
                      itemImg: widget.imgString,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}