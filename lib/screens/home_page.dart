import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:land_registration/screens/wallet_connect.dart';
import 'package:land_registration/widget/header.dart';
import 'package:land_registration/widget/homePageDecription.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/utils.dart';
// import 'package:flutter_icons/flutter_icons.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToAboutUs() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    if (width > 600) {
      width = 590;
      isDesktop = true;
    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/landimg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: <Widget>[
                // Top Header
                const Material(
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 150.0,
                      top: 15,
                      right: 50,
                      bottom: 15,
                    ),
                    child: HeaderWidget(),
                  ),
                ),
                SizedBox(height: 10), // Adjust as needed
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Description(),
                      Center(
                        child: Container(
                          width: 600,
                          height: 804,
                          child: SvgPicture.asset(
                            'assets/landimg.jpg',
                            height: 20.0,
                            width: 20.0,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Scroll to the "About Us" section
                        _scrollToAboutUs();
                      },
                      child: const Text('Learn More'),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomAnimatedContainer('Contract Owner', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckPrivateKey(
                            val: "owner",
                          ),
                        ),
                      );
                      Navigator.of(context).pushNamed(
                        '/login',
                        arguments: "owner",
                      );
                    }),
                    CustomAnimatedContainer('Land Inspector', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckPrivateKey(
                            val: "LandInspector",
                          ),
                        ),
                      );
                      Navigator.of(context).pushNamed(
                        '/login',
                        arguments: "LandInspector",
                      );
                    }),
                    CustomAnimatedContainer('User', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckPrivateKey(
                            val: "UserLogin",
                          ),
                        ),
                      );
                      Navigator.of(context).pushNamed(
                        '/login',
                        arguments: "UserLogin",
                      );
                    }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              final Uri phoneLaunchUri = Uri(
                                scheme: 'tel',
                                path: '+919106342402',
                              );
                              launch(phoneLaunchUri.toString());
                            },
                            icon: Icon(Icons.contact_phone),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const SizedBox(
                                    width: 10), // Add spacing between elements
                                IconButton(
                                  onPressed: () async {
                                    final Uri whatsappLaunchUri = Uri(
                                      scheme: 'https',
                                      host: 'wa.me',
                                      path:
                                          '+919737936205', // Replace with the desired phone number
                                    );
                                    if (await canLaunch(
                                        whatsappLaunchUri.toString())) {
                                      launch(whatsappLaunchUri.toString());
                                    } else {
                                      showToast(
                                          'Could not launch WhatsApp', // Show a message if WhatsApp cannot be launched
                                          context: context,
                                          backgroundColor: Colors.red);
                                    }
                                  },
                                  icon: Image.asset(
                                    'assets/whatsapp.png', // Replace with the path to your custom WhatsApp icon image asset
                                    width:
                                        32, // Customize the width of the icon
                                    height:
                                        32, // Customize the height of the icon
                                  ),
                                ),
                              ],
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              final Uri emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: 'patelhiten2312@gmail.com',
                                  queryParameters: {'subject': 'Contact Us'});
                              launch(emailLaunchUri.toString());
                            },
                            icon: Icon(Icons.email),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     // Handle Instagram button press
                          //     // Add your Instagram page logic here
                          //   },
                          //   icon: Icon(FontAwesome.instagram),
                          // ),
                        ],
                      ),
                      // const Text(
                      //   'About Us',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 24,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // const Text(
                      //   'At Land Registration, we are dedicated to revolutionizing the land registration process through the power of blockchain technology. Our mission is to create a transparent, secure, and efficient system for recording and verifying land ownership information. By leveraging the decentralized and immutable nature of blockchain, we aim to overcome the challenges associated with traditional paper-based land registration systems.',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Scroll to the "About Us" section
                      //     _scrollToAboutUs();
                      //   },
                      //   child: const Text('Learn More'),
                      // ),
                    ],
                  ),
                ),

                // Placeholder for About Us section
                Container(
                  // height: 1000,
                  color: const Color.fromARGB(255, 178, 221, 240),
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'About Us Section',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'At Land Registration, we are dedicated to revolutionizing the land registration process through the power of blockchain technology.\n'
                        'Our mission is to create a transparent, secure, and efficient system for recording and verifying land ownership information.\n'
                        'By leveraging the decentralized and immutable nature of blockchain, we aim to overcome the challenges associated with traditional paper-based land registration systems.',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'How to Use This Website:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Step 1: Create an Account or Log In\n'
                        'To get started, create a new account or log in if you already have one. You can use your email or social media accounts to sign up.\n'
                        '\n'
                        'Step 2: Add Your Land Information\n'
                        'After logging in, you can add information about the land you own. Provide details such as area, address, land price, and more.\n'
                        '\n'
                        'Step 3: Verify Your Ownership\n'
                        'Our team will verify your land ownership information to ensure its accuracy and authenticity.\n'
                        '\n'
                        'Step 4: Explore Land Gallery\n'
                        'Discover various lands available for sale or exchange in the Land Gallery. You can view details and contact landowners for more information.\n'
                        '\n'
                        'Step 5: Send or Receive Land Requests\n'
                        'You can send land requests to other landowners or receive requests from interested buyers. Negotiate and finalize the deals securely.\n'
                        '\n'
                        'Step 6: Complete the Transaction\n'
                        'Once both parties agree, complete the transaction by making the necessary payments and fulfilling the legal requirements.\n'
                        '\n'
                        'Step 7: Enjoy Transparent Land Registration\n'
                        'Congratulations! You have successfully completed the land registration process using our blockchain-based platform. Enjoy the benefits of a transparent and secure land ownership system.\n',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
