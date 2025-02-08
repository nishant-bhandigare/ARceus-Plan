import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:arceus_plan/screens/postDetails/postDetails.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ["Trending", "Following", "Events"];

  final List<Post> trendingPosts = [
    Post(
      username: "Ann Korkowski",
      handle: "@anniekork",
      profileImage: "https://randomuser.me/api/portraits/women/44.jpg",
      content: "Transform your living room into a cozy oasis! 😍",
      imageUrl: "assets/images/living-room-1.jpg",
      likes: "23.5k",
      comments: "3.3k",
      shares: "104k",
    ),
    Post(
      username: "John Doe",
      handle: "@johndoe",
      profileImage: "https://randomuser.me/api/portraits/men/32.jpg",
      content: "Excited to share my latest design! 🚀🔥",
      imageUrl: "assets/images/khloe-arledge-8Rz_RIyp5FM-unsplash.jpg",
      likes: "12.3k",
      comments: "1.5k",
      shares: "50k",
    ),
  ];

  final List<Post> followingPosts = [
    Post(
      username: "Lisa Brown",
      handle: "@lisab",
      profileImage: "https://randomuser.me/api/portraits/women/55.jpg",
      content: "Loved the latest UI/UX trends! Here’s my take. 💡",
      imageUrl: "assets/images/khloe-arledge-8Rz_RIyp5FM-unsplash.jpg",
      likes: "9.1k",
      comments: "2.4k",
      shares: "30k",
    ),
  ];

  final List<Post> eventPosts = [
    Post(
      username: "TechCon",
      handle: "@techcon2024",
      profileImage: "https://randomuser.me/api/portraits/men/45.jpg",
      content: "Join us for the biggest tech event of the year! 🚀",
      imageUrl: "assets/images/andrea-davis-zOPRKaYLSdE-unsplash.jpg",
      likes: "50k",
      comments: "10k",
      shares: "200k",
    ),
    Post(
      username: "DesignCon",
      handle: "@designcon",
      profileImage: "https://randomuser.me/api/portraits/women/33.jpg",
      content: "The biggest design conference is here! 🎨",
      imageUrl: "assets/images/khloe-arledge-8Rz_RIyp5FM-unsplash.jpg",
      likes: "35k",
      comments: "7.2k",
      shares: "120k",
    ),
  ];

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


class Post {
  final String username;
  final String handle;
  final String profileImage;
  final String content;
  final String imageUrl;
  final String likes;
  final String comments;
  final String shares;

  Post({
    required this.username,
    required this.handle,
    required this.profileImage,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PostDetailsScreen(),));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 3, height: 140, color: Colors.pinkAccent, margin: const EdgeInsets.only(right: 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(backgroundColor: Colors.orange, radius: 22, backgroundImage: NetworkImage(post.profileImage)),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.username, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(post.handle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(post.content, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(post.imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIconWithText(Icons.favorite, post.likes, Colors.red),
                        _buildIconWithText(Icons.comment, post.comments, Colors.grey),
                        _buildIconWithText(Icons.share, post.shares, Colors.grey),
                        _buildIconWithText(Icons.bookmark_border, "", Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithText(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        if (text.isNotEmpty) ...[const SizedBox(width: 4), Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))],
      ],
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

