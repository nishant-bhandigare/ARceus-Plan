import 'package:flutter/material.dart';
import '../../data/product_data.dart';
import '../productDetails/product_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Adjust to match your design
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Catalog", style: TextStyle(fontSize: 40),),
            ),
            const SizedBox(height: 10),
            const CategoryList(),
            const PromoBanner(),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            _buildProductGrid(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (int i = 0; i < products.length; i += 2)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: ProductCard(product: products[i])),
                  const SizedBox(width: 15),
                  if (i + 1 < products.length)
                    Expanded(child: ProductCard(product: products[i + 1])),
                  if (i + 1 >= products.length) const Spacer(), // Balance row if odd number of items
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCircleButton(
              icon: Icons.arrow_back,
              onPressed: () {},
            ),
            Row(
              children: [
                _buildCircleButton(
                  icon: Icons.search,
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                Stack(
                  children: [
                    _buildCircleButton(
                      icon: Icons.shopping_bag_outlined,
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  final List<CategoryItem> categories = [
    CategoryItem(label: "All", icon: null),
    CategoryItem(label: "Sofa", icon: Icons.chair_outlined),
    CategoryItem(label: "Bath", icon: Icons.bathtub_outlined),
    CategoryItem(label: "Drawer", icon: Icons.kitchen_outlined),
    CategoryItem(label: "Lights", icon: Icons.ac_unit_rounded),
    CategoryItem(label: "Beds", icon: Icons.bed_outlined),
    CategoryItem(label: "Office", icon: Icons.desk_outlined),
    CategoryItem(label: "Outdoor", icon: Icons.park_outlined),
    CategoryItem(label: "Decor", icon: Icons.emoji_objects_outlined),
    CategoryItem(label: "Kitchen", icon: Icons.blender_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.grey[300],
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ]
                        : [],
                  ),
                  child: Center(
                    child: categories[index].icon == null
                        ? Text(
                      categories[index].label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                        : Icon(
                      categories[index].icon,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CategoryItem {
  final String label;
  final IconData? icon;

  CategoryItem({required this.label, this.icon});
}

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.amberAccent, // Background color
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "New furniture and accessories",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Learn More",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_right_alt, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Image.asset('assets/images/single_sofa.png', height: 100, width: 120,),
            ),
          ],
        ),
      ),
    );
  }
}
