import 'package:flutter/material.dart';
import 'ticket_screen.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  bool _isUpcomingSelected = true;

  final List<Map<String, dynamic>> _bookings = [
    {
      'title': 'Kailasagiri',
      'date': '24 May 2025',
      'time': '10:00 AM - 12:00 PM',
      'id': 'VST1234567890',
      'status': 'Confirmed',
      'image': 'assets/images/kailasagiri.png',
      'tickets': '2 Adult, 1 Child'
    },
    {
      'title': 'INS Kursura Museum',
      'date': '10 Jun 2025',
      'time': '11:00 AM - 01:00 PM',
      'id': 'VST0987654321',
      'status': 'Confirmed',
      'image': 'assets/images/kursura.png',
      'tickets': '1 Adult'
    },
    {
      'title': 'Ramakrishna Beach',
      'date': '05 Jul 2025',
      'time': '06:00 PM',
      'id': 'VST1122334455',
      'status': 'Cancelled',
      'image': 'assets/images/rk_beach.png',
      'tickets': '2 Adult'
    },
  ];

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
          'My Bookings',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Premium Toggle Switch
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isUpcomingSelected = true;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: _isUpcomingSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(21),
                          boxShadow: _isUpcomingSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : [],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Upcoming',
                          style: TextStyle(
                            color: _isUpcomingSelected ? const Color(0xFF111827) : const Color(0xFF6B7280),
                            fontWeight: _isUpcomingSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isUpcomingSelected = false;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: !_isUpcomingSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(21),
                          boxShadow: !_isUpcomingSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : [],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Past',
                          style: TextStyle(
                            color: !_isUpcomingSelected ? const Color(0xFF111827) : const Color(0xFF6B7280),
                            fontWeight: !_isUpcomingSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              itemCount: _bookings.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final booking = _bookings[index];
                final isConfirmed = booking['status'] == 'Confirmed';
                
                // For demo purposes, hide past bookings if upcoming is selected and vice versa
                if (_isUpcomingSelected && !isConfirmed) return const SizedBox.shrink();
                if (!_isUpcomingSelected && isConfirmed) return const SizedBox.shrink();
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Top header with status
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Booking ID: ${booking['id']}',
                              style: const TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isConfirmed ? const Color(0xFFDEF7EC) : const Color(0xFFFDE8E8),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                booking['status'],
                                style: TextStyle(
                                  color: isConfirmed ? const Color(0xFF03543F) : const Color(0xFF9B1C1C),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Divider
                      Container(
                        height: 1,
                        color: Colors.grey.shade100,
                      ),
                      
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                booking['image'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey.shade100,
                                  child: const Icon(Icons.image, color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booking['title'],
                                    style: const TextStyle(
                                      color: Color(0xFF111827),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today_outlined, color: Color(0xFF6B7280), size: 14),
                                      const SizedBox(width: 6),
                                      Text(
                                        booking['date'],
                                        style: const TextStyle(
                                          color: Color(0xFF4B5563),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time, color: Color(0xFF6B7280), size: 14),
                                      const SizedBox(width: 6),
                                      Text(
                                        booking['time'],
                                        style: const TextStyle(
                                          color: Color(0xFF4B5563),
                                          fontSize: 14,
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
                      
                      // Bottom action
                      if (isConfirmed) ...[
                        Container(
                          height: 1,
                          color: Colors.grey.shade100,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => TicketScreen(
                                  attraction: {
                                    'title': booking['title'],
                                    'location': 'Visakhapatnam',
                                    'image': booking['image'],
                                  },
                                  adultsCount: booking['tickets'].contains('Adult') 
                                    ? int.tryParse(booking['tickets'].split('Adult')[0].trim()) ?? 1 
                                    : 1,
                                  childrenCount: booking['tickets'].contains('Child') 
                                    ? int.tryParse(booking['tickets'].split('Child')[0].split(',').last.trim()) ?? 0 
                                    : 0,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            alignment: Alignment.center,
                            child: const Text(
                              'View E-Ticket',
                              style: TextStyle(
                                color: Color(0xFF0F7B45),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
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
