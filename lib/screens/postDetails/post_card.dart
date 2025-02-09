import 'package:arceus_plan/screens/postDetails/postDetails.dart';
import 'package:flutter/material.dart';
import '../../models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PostDetailsScreen(),
          ),
        );
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
              Container(
                width: 3,
                height: 140,
                color: Colors.pinkAccent,
                margin: const EdgeInsets.only(right: 12),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 22,
                          backgroundImage: NetworkImage(post.profileImage),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.username,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              post.handle,
                              style: const TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(post.content, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        post.imageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
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
        if (text.isNotEmpty)
          ...[
            const SizedBox(width: 4),
            Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
      ],
    );
  }
}
