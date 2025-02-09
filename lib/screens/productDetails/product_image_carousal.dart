import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> imageList;

  const ProductImageCarousel({super.key, required this.imageList});

  @override
  _ProductImageCarouselState createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CarouselSlider(
              items: widget.imageList.map((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(image, fit: BoxFit.cover),
                );
              }).toList(),
              options: CarouselOptions(
                height: 150,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.imageList.length,
                    (index) => _buildIndicator(index == _currentIndex),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 10 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
