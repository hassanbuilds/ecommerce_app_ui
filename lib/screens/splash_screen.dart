import 'dart:async';
import 'package:ecommerce_app/main.dart';
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
    // 1. AUTOMATIC NAVIGATION after 5 seconds
    _timer = Timer(const Duration(seconds: 788989), () {
      _navigateToHome();
    });
  }

  // Function to handle navigation safely
  void _navigateToHome() {
    if (mounted) {
      _timer?.cancel(); // Cancel timer if user clicked manually
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up timer when widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String movingText = "TRENDY COLLECTION • ";

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // Keeps clock/battery icons white
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // 1. TOP IMAGE - FULL WIDTH & TOUCHING TOP
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
                      ),
                    ),
                    Positioned(
                      top: 60,
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

            // 2. BUTTONS SECTION - TOUCHING THE IMAGE
            Container(
              color: Colors.black,
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TRENDY COLLECTION - 135 HEIGHT
                  Container(
                    width: double.infinity,
                    height: 135,
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
                                      movingText,
                                      style: const TextStyle(
                                        fontSize: 55,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                      ),
                                    )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(),
                                    )
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
                  ),

                  const SizedBox(height: 12),

                  // DISCOVER NOW BUTTON - 100 HEIGHT
                  InkWell(
                    onTap: () =>
                        _navigateToHome(), // 2. MANUAL NAVIGATION on click
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB08968),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: const Center(
                        child: Text(
                          "Discover Now",
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
