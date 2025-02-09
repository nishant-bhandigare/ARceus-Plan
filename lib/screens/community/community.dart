import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../data/post_data.dart';
import '../../models/post_model.dart';
import '../postDetails/post_card.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ["Trending", "Following", "Events"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleButton(icon: Icons.person),
                _buildCircleButton(icon: Icons.search),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text("Good morning !!!", style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 8),
            const Text("Community", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildTabBar(),
            const SizedBox(height: 20),
            Expanded(
              child: _selectedTab == 2 ? _buildEventCarousel() : _buildPostList(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      child: Icon(icon, color: Colors.grey.shade600),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_tabs.length, (index) {
          bool isActive = index == _selectedTab;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: isActive ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _tabs[index],
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPostList() {
    List<Post> posts = _selectedTab == 0 ? trendingPosts : followingPosts;
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index]);
      },
    );
  }

  Widget _buildEventCarousel() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: CarouselScreen(events: eventPosts), // Pass eventPosts dynamically
    );
  }

}


class CarouselScreen extends StatelessWidget {
  final List<Post> events;

  const CarouselScreen({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.8,
      ),
      items: events.map((event) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(event.imageUrl, fit: BoxFit.cover),
              _buildGradientOverlay(),
              _buildContent(event),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
        ),
      ),
    );
  }

  Widget _buildContent(Post event) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.white, size: 28),
              onPressed: () {},
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.username, style: const TextStyle(color: Colors.white70, fontSize: 16)),
              Text(event.content, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 20),
                  const SizedBox(width: 4),
                  Text(event.likes, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(event.comments, style: const TextStyle(color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("See more", style: TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

