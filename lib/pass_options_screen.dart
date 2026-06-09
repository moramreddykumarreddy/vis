import 'package:flutter/material.dart';
import 'ticket_selection_screen.dart';

class PassOptionsScreen extends StatelessWidget {
  const PassOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAF8),
        elevation: 0,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF111827), size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          'Unified Passes',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 24.0, left: 4.0, right: 4.0),
              child: Text(
                'Explore Visakhapatnam effortlessly with our curated bundles.',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),
            _buildPassOptionCard(
              context,
              'assets/images/pass_vmrda.png',
              'Ultimate VMRDA Pass',
              'Access to all premium Parks & Museums across the city.',
              '₹350',
            ),
            const SizedBox(height: 24),
            _buildPassOptionCard(
              context,
              'assets/images/pass_parks.png',
              'Parks & Kailasagiri Pass',
              'Explore lush greenery and panoramic hilltop views.',
              '₹150',
            ),
            const SizedBox(height: 24),
            _buildPassOptionCard(
              context,
              'assets/images/pass_museums.png',
              'Heritage Museums Pass',
              'Dive into naval history and local culture.',
              '₹200',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPassOptionCard(BuildContext context, String imageAsset, String title, String subtitle, String price) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TicketSelectionScreen(
              initialUnifiedPassSelected: true,
              attraction: {
                'title': title,
                'location': 'Visakhapatnam',
                'image': imageAsset,
                'price': price,
                'rating': '4.9',
                'reviews': '(5k+)',
                'description': subtitle,
                'openHours': '09:00 AM - 08:00 PM',
              },
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: const Color(0xFFF3F4F6),
                image: DecorationImage(
                  image: imageAsset.startsWith('http') 
                      ? NetworkImage(imageAsset, headers: const {'User-Agent': 'FlutterApp/1.0 (https://flutter.dev)'}) as ImageProvider 
                      : AssetImage(imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Bottom Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            price,
                            style: const TextStyle(
                              color: Color(0xFF0F7B45),
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 4.0, left: 4.0),
                            child: Text(
                              '/ person',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F7B45).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF0F7B45),
                          size: 16,
                        ),
                      ),
                    ],
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
