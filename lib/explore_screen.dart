import 'package:flutter/material.dart';
import 'attraction_details_screen.dart';

class ExploreScreen extends StatefulWidget {
  final String? initialCategory;
  const ExploreScreen({super.key, this.initialCategory});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All', 'Temples', 'Parks', 'Museums', 'Beaches', 'Events'];

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      int index = _categories.indexOf(widget.initialCategory!);
      if (index != -1) {
        _selectedCategoryIndex = index;
      }
    }
  }

  // Massive list of rich dummy data
  final List<Map<String, dynamic>> _allAttractions = [
    {
      'id': '1',
      'title': 'Simhachalam Temple',
      'category': 'Temples',
      'location': 'Visakhapatnam',
      'rating': '4.8',
      'reviews': '(2k+)',
      'image': 'assets/images/slider_simhachalam.png',
      'price': '₹100',
      'description': 'Experience the beauty of Simhachalam Temple in Visakhapatnam. A must-visit destination offering stunning views and memorable experiences.',
      'openHours': '08:00 AM - 06:00 PM',
      'amenities': ['Parking', 'Food Stalls', 'Restrooms'],
    },
    {
      'id': '2',
      'title': 'Kailasagiri Park',
      'category': 'Parks',
      'location': 'Visakhapatnam',
      'rating': '4.6',
      'reviews': '(1,230)',
      'image': 'assets/images/slider_kailasagiri.png',
      'price': '₹50',
      'description': 'A beautiful hilltop park offering panoramic sea views of the Bay of Bengal, winding paths, beautiful statues including the massive Shiva-Parvathi idol, and a fun ropeway ride. Perfect for family picnics and evening strolls.',
      'openHours': '10:00 AM - 8:00 PM',
      'amenities': ['Parking', 'Food Stalls', 'Restrooms', 'Ropeway', 'Kids Play Area'],
    },
    {
      'id': '3',
      'title': 'INS Kursura Submarine Museum',
      'category': 'Museums',
      'location': 'RK Beach Road',
      'rating': '4.8',
      'reviews': '(3,450)',
      'image': 'assets/images/slider_submarine.png',
      'price': '₹40',
      'description': 'Experience life underwater inside a real decommissioned Kalvari-class submarine. A unique museum that showcases the history and lifestyle of Indian Navy submariners.',
      'openHours': '2:00 PM - 8:30 PM (Closed on Mondays)',
      'amenities': ['Guided Tours', 'AC', 'Souvenir Shop'],
    },
    {
      'id': '4',
      'title': 'Ramakrishna Beach (RK Beach)',
      'category': 'Beaches',
      'location': 'Visakhapatnam City',
      'rating': '4.5',
      'reviews': '(5k+)',
      'image': 'assets/images/slider_rkbeach.png',
      'price': 'Free',
      'description': 'The most famous beach in Visakhapatnam. Enjoy the stunning sunrise, evening street food, and nearby attractions like the submarine museum and victory at sea memorial.',
      'openHours': 'Open 24 Hours',
      'amenities': ['Street Food', 'Walking Track', 'Seating'],
    },
    {
      'id': '5',
      'title': 'Rushikonda Beach',
      'category': 'Beaches',
      'location': 'Bheemili Road',
      'rating': '4.7',
      'reviews': '(4.2k)',
      'image': 'assets/images/slider_rushikonda.png',
      'price': 'Free',
      'description': 'A pristine, golden sand beach known as the "Jewel of the East Coast". Perfect for swimming, water sports, and relaxing under the sun.',
      'openHours': '6:00 AM - 7:00 PM',
      'amenities': ['Water Sports', 'Restrooms', 'Food Stalls', 'Parking'],
    },
    {
      'id': '6',
      'title': 'Borra Caves',
      'category': 'Parks', 
      'location': 'Araku Valley',
      'rating': '4.6',
      'reviews': '(3k+)',
      'image': 'assets/images/slider_borracaves.png',
      'price': '₹80',
      'description': 'Discover the deepest million-year-old limestone caves in India. Famous for their breathtaking stalactite and stalagmite formations illuminated by colorful lights.',
      'openHours': '10:00 AM - 5:00 PM',
      'amenities': ['Parking', 'Restrooms', 'Guides'],
    },
    {
      'id': '7',
      'title': 'Yarada Beach',
      'category': 'Beaches',
      'location': 'Yarada',
      'rating': '4.8',
      'reviews': '(1.5k+)',
      'image': 'assets/images/slider_yaradabeach.png',
      'price': 'Free',
      'description': 'Experience the beauty of Yarada Beach in Visakhapatnam. A must-visit destination offering stunning views and memorable experiences.',
      'openHours': '06:00 AM - 06:00 PM',
      'amenities': ['Parking', 'Food Stalls'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    String selectedCategory = _categories[_selectedCategoryIndex];
    List<Map<String, dynamic>> displayedAttractions = _allAttractions.where((a) {
      if (selectedCategory == 'All') return true;
      return a['category'] == selectedCategory;
    }).toList();

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
          'Explore',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF111827), size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: Color(0xFF111827), size: 26),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Premium Categories
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAF8),
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: List.generate(_categories.length, (index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF111827) : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF111827) : Colors.grey.shade300,
                            width: 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : [],
                        ),
                        child: Text(
                          _categories[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF4B5563),
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          
          // Airbnb-style Attractions List
          Expanded(
            child: displayedAttractions.isEmpty 
              ? const Center(child: Text("No attractions found in this category."))
              : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              physics: const BouncingScrollPhysics(),
              itemCount: displayedAttractions.length,
              itemBuilder: (context, index) {
                final attraction = displayedAttractions[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AttractionDetailsScreen(attraction: attraction),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Immersive Image Card
                        Stack(
                          children: [
                            Container(
                              height: 240,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(attraction['image']),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 28,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Details underneath
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    attraction['title'],
                                    style: const TextStyle(
                                      color: Color(0xFF111827),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${attraction['location']}, Andhra Pradesh',
                                    style: const TextStyle(
                                      color: Color(0xFF6B7280),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Text(
                                        'From ',
                                        style: TextStyle(
                                          color: Color(0xFF4B5563),
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        attraction['price'],
                                        style: const TextStyle(
                                          color: Color(0xFF111827),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        ' / person',
                                        style: TextStyle(
                                          color: Color(0xFF4B5563),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.star, color: Color(0xFF111827), size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  attraction['rating'],
                                  style: const TextStyle(
                                    color: Color(0xFF111827),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
