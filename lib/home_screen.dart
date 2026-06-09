import 'dart:async';
import 'package:flutter/material.dart';
import 'explore_screen.dart';
import 'my_bookings_screen.dart';
import 'my_passes_screen.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'attraction_details_screen.dart';
import 'pass_options_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late final PageController _topSliderController;
  Timer? _sliderTimer;

  @override
  void initState() {
    super.initState();
    _topSliderController = PageController(viewportFraction: 0.9);
    _sliderTimer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_topSliderController.hasClients) {
        int nextPage = _topSliderController.page!.round() + 1;
        if (nextPage >= _famousPlaces.length) {
          nextPage = 0;
          _topSliderController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
        } else {
          _topSliderController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _topSliderController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
    }
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning, Rahul ☀️';
    } else if (hour < 17) {
      return 'Good Afternoon, Rahul 🌤️';
    } else {
      return 'Good Evening, Rahul 🌙';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAF8),
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Color(0xFF0F7B45), size: 14),
                    SizedBox(width: 4),
                    Text(
                      'Visakhapatnam',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Color(0xFF1F2937), size: 28),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                  );
                },
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            
            // Top Famous Places Slider
            _buildTopSlider(),
            
            const SizedBox(height: 24),
            
            // Quick Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryItem(Icons.beach_access_rounded, 'Beaches', const [Color(0xFFF0F9FF), Color(0xFFE0F2FE)], const Color(0xFF0EA5E9)),
                  _buildCategoryItem(Icons.account_balance_rounded, 'Museums', const [Color(0xFFFFFBEB), Color(0xFFFEF3C7)], const Color(0xFFF59E0B)),
                  _buildCategoryItem(Icons.park_rounded, 'Parks', const [Color(0xFFF0FDF4), Color(0xFFDCFCE7)], const Color(0xFF22C55E)),
                  _buildCategoryItem(Icons.local_activity_rounded, 'Events', const [Color(0xFFFAF5FF), Color(0xFFF3E8FF)], const Color(0xFFA855F7)),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // Unified Pass Card - Redesigned
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PassOptionsScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0F7B45).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/images/pass_banner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF0F7B45).withOpacity(0.9),
                          const Color(0xFF0F7B45).withOpacity(0.4),
                          Colors.transparent
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A017),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'PREMIUM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Unified Pass',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'One Pass. Many Places.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: const [
                                  Text(
                                    'Book Now',
                                    style: TextStyle(
                                      color: Color(0xFF0F7B45),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward, color: Color(0xFF0F7B45), size: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Popular Attractions Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Attractions',
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ExploreScreen()),
                      );
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFF0F7B45),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Horizontal List (Immersive Cards)
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                clipBehavior: Clip.none,
                children: [
                  _buildImmersiveCard(
                    'Kailasagiri',
                    'Visakhapatnam',
                    'assets/images/kailasagiri.png',
                    'Kailasagiri',
                    '4.6',
                    '(1,230)',
                  ),
                  _buildImmersiveCard(
                    'INS Kursura',
                    'Museum',
                    'assets/images/kursura.png',
                    'INS Kursura Museum',
                    '4.6',
                    '(850)',
                  ),
                  _buildImmersiveCard(
                    'RK Beach',
                    'Beach',
                    'assets/images/rk_beach.png',
                    'Ramakrishna Beach',
                    '4.5',
                    '(2k+)',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),

            // Nearby Attractions Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nearby Attractions',
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ExploreScreen()),
                      );
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFF0F7B45),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Nearby Horizontal List
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                clipBehavior: Clip.none,
                children: [
                  _buildImmersiveCard(
                    'TU 142 Aircraft',
                    'Museum',
                    'assets/images/tu142.png',
                    'TU 142 Aircraft Museum',
                    '4.3',
                    '(600)',
                  ),
                  _buildImmersiveCard(
                    'Borra Caves',
                    'Vizag District',
                    'assets/images/borra_caves.png',
                    'Borra Caves',
                    '4.6',
                    '(3k+)',
                  ),
                  _buildImmersiveCard(
                    'Erra Matti',
                    'Dibbalu',
                    'assets/images/erra_matti.png',
                    'Erra Matti Dibbalu',
                    '4.5',
                    '(400)',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Connect with Us Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  Text(
                    'Connect with Us',
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.xTwitter, color: Color(0xFF000000), size: 28),
                    onPressed: () => _launchURL('https://x.com/vmrdaofficial'),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.youtube, color: Color(0xFFFF0000), size: 28),
                    onPressed: () => _launchURL('https://www.youtube.com/@vmrdaofficial'),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.facebook, color: Color(0xFF1877F2), size: 28),
                    onPressed: () => _launchURL('https://www.facebook.com/VMRDA'),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.instagram, color: Color(0xFFE1306C), size: 28),
                    onPressed: () => _launchURL('https://www.instagram.com/vmrdaofficial'),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Color(0xFF25D366), size: 28),
                    onPressed: () => _launchURL('https://wa.me/'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 120), // Extra padding to clear the floating bottom nav bar
          ],
        ),
      ),
    );
  }

  Widget _buildImmersiveCard(String title, String subtitle, String imageUrl, String fullTitle, String rating, String reviews) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AttractionDetailsScreen(
              attraction: {
                'title': fullTitle,
                'location': subtitle,
                'rating': rating,
                'reviews': reviews,
                'image': imageUrl,
              },
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFD4A017), size: 14),
                  const SizedBox(width: 4),
                  Text(
                    rating,
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    reviews,
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white70, size: 12),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, List<Color> gradientColors, Color iconColor) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ExploreScreen(initialCategory: label),
          ),
        );
      },
      child: Container(
        width: 78,
        height: 85,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Glowing background blob
          Positioned(
            bottom: -20,
            right: -20,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -5,
            right: -5,
            child: Transform.rotate(
              angle: -0.15,
              child: Icon(
                icon,
                size: 45,
                color: iconColor.withOpacity(0.9),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 10,
            right: 4,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  // --- Top Slider Implementation ---
  final List<Map<String, String>> _famousPlaces = const [
    {
      'title': 'Simhachalam Temple',
      'image': 'assets/images/slider_simhachalam.png'
    },
    {
      'title': 'Kailasagiri',
      'image': 'assets/images/slider_kailasagiri.png'
    },
    {
      'title': 'Submarine Museum',
      'image': 'assets/images/slider_submarine.png'
    },
    {
      'title': 'RK Beach',
      'image': 'assets/images/slider_rkbeach.png'
    },
    {
      'title': 'Rushikonda Beach',
      'image': 'assets/images/slider_rushikonda.png'
    },
    {
      'title': 'Borra Caves',
      'image': 'assets/images/slider_borracaves.png'
    },
    {
      'title': 'Yarada Beach',
      'image': 'assets/images/slider_yaradabeach.png'
    },
  ];

  Widget _buildTopSlider() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _topSliderController,
        itemCount: _famousPlaces.length,
        itemBuilder: (context, index) {
          final place = _famousPlaces[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AttractionDetailsScreen(
                    attraction: {
                      'title': place['title'],
                      'location': 'Visakhapatnam, AP',
                      'image': place['image'],
                      'price': '₹100',
                      'rating': '4.8',
                      'reviews': '(2k+)',
                      'description': 'Experience the beauty of ${place['title']} in Visakhapatnam. A must-visit destination offering stunning views and memorable experiences.',
                      'openHours': '08:00 AM - 06:00 PM',
                    },
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: place['image']!.startsWith('http')
                    ? NetworkImage(
                        place['image']!,
                        headers: const {'User-Agent': 'FlutterApp/1.0 (https://flutter.dev)'},
                      ) as ImageProvider
                    : AssetImage(place['image']!),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              child: Text(
                place['title']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            ),
          );
        },
      ),
    );
  }
}
