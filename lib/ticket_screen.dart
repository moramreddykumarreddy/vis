import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  final Map<String, dynamic> attraction;
  final int adultsCount;
  final int childrenCount;

  const TicketScreen({
    super.key,
    required this.attraction,
    required this.adultsCount,
    required this.childrenCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827), // Dark premium background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white, size: 24),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Text(
                'Your E-Ticket',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0F7B45).withOpacity(0.3),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Top header with gradient
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF0F7B45), Color(0xFF16A34A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: attraction['image'] != null && attraction['image']!.startsWith('http')
                                    ? Image.network(
                                        attraction['image']!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        headers: const {'User-Agent': 'FlutterApp/1.0 (https://flutter.dev)'},
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey.shade300,
                                          child: const Icon(Icons.image, color: Colors.grey),
                                        ),
                                      )
                                    : Image.asset(
                                        attraction['image'] ?? '',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey.shade300,
                                          child: const Icon(Icons.image, color: Colors.grey),
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    attraction['title'] ?? 'Attraction',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    attraction['location'] ?? 'Location',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Ticket details
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildDetailColumn('Date', '24 May 2025'),
                                _buildDetailColumn('Time', '10:00 AM', alignment: CrossAxisAlignment.end),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildDetailColumn('Ticket Type', 'General Admission'),
                                _buildDetailColumn('Quantity', '${adultsCount + childrenCount} Person(s)', alignment: CrossAxisAlignment.end),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildDetailColumn('Booking ID', 'VST-1234-5678'),
                                _buildDetailColumn('Status', 'CONFIRMED', alignment: CrossAxisAlignment.end, color: const Color(0xFF0F7B45)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Perforated Divider
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF111827),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    (constraints.constrainWidth() / 10).floor(),
                                    (index) => Container(
                                      width: 5,
                                      height: 2,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            width: 16,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF111827),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // QR Code Section
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade200, width: 2),
                              ),
                              child: const Icon(
                                Icons.qr_code_2,
                                size: 160,
                                color: Color(0xFF111827),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Scan at the entrance gate',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Bottom Download Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, color: Colors.white, size: 20),
                  label: const Text(
                    'Save to Device',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.15),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String title, String value, {CrossAxisAlignment alignment = CrossAxisAlignment.start, Color color = const Color(0xFF111827)}) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
