import 'dart:async';
import 'package:ecommerce_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 5), () => _navigateToHome());
  }

  void _navigateToHome() {
    if (mounted) {
      _timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. GET SCREEN SIZE
    final size = MediaQuery.of(context).size;
    final bool isWeb = size.width > 800;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        // 2. CENTER FOR WEB (Adds margins on big screens)
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isWeb ? 500 : double.infinity,
            ),
            child: Column(
              children: [
                // TOP IMAGE
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'images/splash_screen.jpg',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                          top: isWeb ? 40 : 60, // Slightly lower on mobile
                          left: 0,
                          right: 0,
                          child: const Text(
                            'Lumière',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ).animate().fadeIn(duration: 800.ms),
                      ],
                    ),
                  ),
                ),

                // BUTTONS SECTION
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.fromLTRB(10, 15, 10, isWeb ? 40 : 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // TRENDY COLLECTION
                      _buildMarqueeButton(context, isWeb),

                      const SizedBox(height: 12),

                      // DISCOVER NOW BUTTON
                      _buildDiscoverButton(isWeb),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 3. SEPARATE WIDGETS FOR CLEANER CODE
  Widget _buildMarqueeButton(BuildContext context, bool isWeb) {
    return Container(
      width: double.infinity,
      height: isWeb ? 100 : 135, // Shorter on Web to fit the screen
      decoration: BoxDecoration(
        color: const Color(0xFFC5C9B8),
        borderRadius: BorderRadius.circular(35),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Center(
              child:
                  Text(
                        "TRENDY COLLECTION • ",
                        style: TextStyle(
                          fontSize: isWeb
                              ? 40
                              : 55, // Smaller text for Web browsers
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .moveX(
                        begin: 0,
                        end: -450,
                        duration: 5.seconds,
                        curve: Curves.linear,
                      ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDiscoverButton(bool isWeb) {
    return InkWell(
      onTap: () => _navigateToHome(),
      child: Container(
        width: double.infinity,
        height: isWeb ? 80 : 100, // Slightly thinner on Web
        decoration: BoxDecoration(
          color: const Color(0xFFB08968),
          borderRadius: BorderRadius.circular(35),
        ),
        child: const Center(
          child: Text(
            "Discover Now",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
