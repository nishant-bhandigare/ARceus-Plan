import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class RouterComponent extends StatelessWidget{
  const RouterComponent({super.key, required this.text, required this.url});
  final String text;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 120,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        // border: Border.all(),
        color : Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () async {
              final Uri uri = Uri.parse(url);
              if (!await launchUrl(uri)) {
              throw 'Could not launch $uri';
              }
            },
            // child: const CircleAvatar(
            //   backgroundColor: Colors.blue,
            //   child: Icon(Icons.bolt, color: Colors.white),
            // ),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Lottie.asset("assets/animations/bolt.json"),
            ),
          ),
        ],
      ),
    );
  }

}