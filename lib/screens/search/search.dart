import 'package:arceus_plan/screens/productDetails/productDetails.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Catalog", style: TextStyle(fontSize: 40),),
              ),
              SizedBox(height: 10),
              CategoryList(),
              PromoBanner(),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ProductCard(
                        imageUrl: 'assets/images/rot_chair.png', // Replace with actual asset or URL
                        category: 'Chair',
                        title: 'Rot chair',
                        price: 109.99,
                        rating: 4.5,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ProductCard(
                        imageUrl: 'assets/images/sofa_yellow.png', // Replace with actual asset or URL
                        category: 'Sofa',
                        title: 'Yellow Sofa',
                        price: 109.99,
                        rating: 4.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ProductCard(
                        imageUrl: 'assets/images/sofa_white.png', // Replace with actual asset or URL
                        category: 'Sofa',
                        title: 'Sofa White',
                        price: 109.99,
                        rating: 4.5,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ProductCard(
                        imageUrl: 'assets/images/bed_double.png', // Replace with actual asset or URL
                        category: 'Bed',
                        title: 'Double Bed',
                        price: 109.99,
                        rating: 4.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
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

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final double price;
  final double rating;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProductDetailsScreen(),));
              },
              child: SizedBox(
                width: double.infinity,
                height: 150,
                child: Image.asset(imageUrl, height: 120, width: 120,),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            category,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _buildStarRating(rating),
              const SizedBox(width: 6),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${price.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.black, size: 16);
        } else if (index == fullStars && hasHalfStar) {
          return const Icon(Icons.star_half, color: Colors.black, size: 16);
        } else {
          return const Icon(Icons.star_border, color: Colors.black, size: 16);
        }
      }),
    );
  }
}
