import 'package:flutter/material.dart';
import 'package:universtyapp/features/university/domain/models/university_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universtyapp/core/utils/responsive_builder.dart';

class UniversityLocation extends StatelessWidget {
  final Location location;

  const UniversityLocation({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBuilder.isDesktop(context);
    final height = isDesktop ? 300.0 : 150.0;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isDesktop ? 20 : 16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: isDesktop ? 15 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.blue.shade700,
              size: ResponsiveBuilder.getFontSize(context, 24),
            ),
            title: Text(
              location.address,
              style: TextStyle(
                fontSize: ResponsiveBuilder.getFontSize(context, 16),
              ),
            ),
            subtitle: Text(
              '${location.latitude}, ${location.longitude}',
              style: TextStyle(
                fontSize: ResponsiveBuilder.getFontSize(context, 14),
              ),
            ),
          ),
          TextButton.icon(
            icon: const Icon(Icons.map),
            label: Text(
              'Google Maps\'te Aç',
              style: TextStyle(
                fontSize: ResponsiveBuilder.getFontSize(context, 14),
              ),
            ),
            onPressed: () async {
              final url = Uri.parse(
                'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}',
              );
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
          ),
        ],
      ),
    );
  }
} 