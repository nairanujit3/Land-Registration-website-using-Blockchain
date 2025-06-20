import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'package:land_registration/widget/header.dart';
import 'package:land_registration/screens/home_page.dart';
import 'package:land_registration/widget/homePageDecription.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/utils.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      backgroundColor: Color.fromARGB(255, 229, 231, 163),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the About Us page!',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                'Website Creators:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CreatorInfo(
                    name: 'Hiten Patel',
                    email: 'hitenpatel@gmail.com',
                    phone: '+919898123456',
                    image: 'assets/hiten1.jpg',
                    boxWidth: 200,
                  ),
                  CreatorInfo(
                    name: 'Anujit Nair',
                    email: 'anujitnair@gmail.com',
                    phone: '+919824215785',
                    image: 'assets/anujit.jpg',
                    boxWidth: 200,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CreatorInfo(
                    name: 'Shubham Agrawal',
                    email: 'shubham@gmail.com',
                    phone: '+919912357684',
                    image: 'assets/shubham.jpg',
                    boxWidth: 200,
                  ),
                  CreatorInfo(
                    name: 'Vivek Parmar',
                    email: 'vivekparmar@gmail.com',
                    phone: '+916354210987',
                    image: 'assets/vivek.jpg',
                    boxWidth: 200,
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Technology Used:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Align(
              // alignment: Alignment.centerLeft,
              // child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TechnologyItem(
                    image: 'assets/flutter.png',
                    text: 'Flutter',
                  ),
                  TechnologyItem(
                    image: 'assets/ethereum.png',
                    text: 'Ethereum Blockchain',
                  ),
                  // Add other technologies here
                ],
              ),
              // ),
              // Align(
              //   alignment: Alignment.centerLeft,
              // child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TechnologyItem(
                    image: 'assets/Ganache.png',
                    text: 'Ganache',
                  ),
                  TechnologyItem(
                    image: 'assets/dart.jpg',
                    text: 'Dart',
                  ),
                  // Add other technologies here
                ],
              ),
              // ),
              // Align(
              // alignment: Alignment.centerLeft,
              // child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TechnologyItem(
                    image: 'assets/Solidity.png',
                    text: 'Solidity',
                  ),
                  TechnologyItem(
                    image: 'assets/Remix.jpg',
                    text: 'Remix',
                  ),
                  // Add other technologies here
                ],
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreatorInfo extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String image;
  final double boxWidth;

  const CreatorInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.boxWidth,
    Key? key,
  }) : super(key: key);

  @override
  _CreatorInfoState createState() => _CreatorInfoState();
}

class _CreatorInfoState extends State<CreatorInfo> {
  bool isDetailsVisible = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isDetailsVisible = true),
      onExit: (_) => setState(() => isDetailsVisible = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.boxWidth,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 234, 211, 83),
          borderRadius: BorderRadius.circular(10),
          boxShadow: isDetailsVisible
              ? [
                  BoxShadow(
                    color: const Color.fromARGB(255, 219, 154, 154)
                        .withOpacity(0.8),
                    spreadRadius: 4,
                    blurRadius: 8,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(widget.image),
            ),
            const SizedBox(height: 20),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (isDetailsVisible) ...[
              const SizedBox(height: 10),
              SelectableText(
                'Email: ${widget.email}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              SelectableText(
                'Phone: ${widget.phone}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class TechnologyItem extends StatelessWidget {
  final String image;
  final String text;

  const TechnologyItem({
    required this.image,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Image.asset(
            image,
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
