import 'package:flutter/material.dart';

import '../../router_component.dart';

class DiscoverScreen extends StatelessWidget{
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 20),
              IkeaInspiration(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(backgroundColor: Colors.orange, radius: 22, backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/32.jpg")),
            // Stack(
            //   children: [
            //     _buildCircleButton(
            //       icon: Icons.shopping_bag_outlined,
            //       onPressed: () {},
            //     ),
            //     Positioned(
            //       right: 8,
            //       top: 8,
            //       child: Container(
            //         width: 8,
            //         height: 8,
            //         decoration: const BoxDecoration(
            //           color: Colors.red,
            //           shape: BoxShape.circle,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            RouterComponent(text: 'FAQ Bot', url: "ttp://192.168.119.57:8501/",),
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

class IkeaInspiration extends StatelessWidget {
  const IkeaInspiration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(),borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Get inspired",
            style: TextStyle(fontSize: 14),
          ),
          const Text(
            "Inspiration from ARceus",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildInspirationCard(
                  imagePath: "assets/images/adam-winger-PCDlE94JjcI-unsplash.jpg",
                  label: "Kitchen",
                ),
                const SizedBox(width: 8),
                _buildInspirationCard(
                  imagePath: "assets/images/afif-ramdhasuma-H8ATMkhYnIo-unsplash.jpg",
                  label: "Workspace",
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // Navigate to inspirations page
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Browse all inspirations",
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.arrow_right_alt,size: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInspirationCard({required String imagePath, required String label}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

