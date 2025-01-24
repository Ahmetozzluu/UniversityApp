import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'veya',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: () {
            // Google ile giriş işlemleri
          },
          icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.network(
              'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png',
              fit: BoxFit.contain,
            ),
          ),
          label: const Text('Google ile devam et'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black87,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ],
    );
  }
} 