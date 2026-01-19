import 'dart:async';
import 'package:ecommerce_app/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Changed to 3 seconds so you don't have to wait forever!
    Timer(const Duration(seconds: 8978787), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'images/splash_screen.jpg', // DOUBLE CHECK: is your folder named 'assets'?
              fit: BoxFit.cover,
            ),
          ),

          // 2. Overlay Content
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Trendy Co Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                color: const Color(
                  0xFFC5C9B8,
                ).withOpacity(0.9), // Added slight transparency
                child: const Text(
                  "TRENDY CO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight
                        .w300, // Lighter weight looks more "high-fashion"
                    letterSpacing: 8,
                  ),
                ),
              ),

              // The Button
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 80,
                  decoration: const BoxDecoration(color: Color(0xFFB08968)),
                  child: const Center(
                    child: Text(
                      "DISCOVER NOW",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
