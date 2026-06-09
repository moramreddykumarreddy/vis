import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isAllSelected = true;

  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Booking Confirmed',
      'subtitle': 'Your booking for Kailasagiri is confirmed. 24 May 2025',
      'time': '2m ago',
      'type': 'success',
    },
    {
      'title': 'Payment Successful',
      'subtitle': 'Payment of ₹375 was successful.',
      'time': '5m ago',
      'type': 'success',
    },
    {
      'title': 'Pass Activated',
      'subtitle': 'Your Annual Pass is now active.',
      'time': '1d ago',
      'type': 'success',
    },
    {
      'title': 'Visit Reminder',
      'subtitle': "Don't forget your visit tomorrow!",
      'time': '1d ago',
      'type': 'warning',
    },
    {
      'title': 'Exclusive Offer',
      'subtitle': 'Get 20% off on your next museum visit. Valid for 48 hours!',
      'time': '2d ago',
      'type': 'offer',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter list if "Offers" is selected
    final displayList = _isAllSelected 
        ? _notifications 
        : _notifications.where((n) => n['type'] == 'offer').toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8), // Premium off-white background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAF8),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF111827), size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Premium Toggle Pill
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isAllSelected = true),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: _isAllSelected ? const Color(0xFF0F7B45) : Colors.transparent,
                            borderRadius: BorderRadius.circular(21),
                            boxShadow: _isAllSelected ? [
                              BoxShadow(
                                color: const Color(0xFF0F7B45).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ] : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: _isAllSelected ? Colors.white : const Color(0xFF6B7280),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isAllSelected = false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: !_isAllSelected ? const Color(0xFF0F7B45) : Colors.transparent,
                            borderRadius: BorderRadius.circular(21),
                            boxShadow: !_isAllSelected ? [
                              BoxShadow(
                                color: const Color(0xFF0F7B45).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ] : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Offers',
                            style: TextStyle(
                              color: !_isAllSelected ? Colors.white : const Color(0xFF6B7280),
                              fontWeight: FontWeight.bold,
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
            
            Expanded(
              child: displayList.isEmpty 
                  ? const Center(
                      child: Text(
                        'No notifications found.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0, bottom: 40.0),
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        final notif = displayList[index];
                        
                        IconData iconData;
                        Color iconColor;
                        Color bgColor;
                        
                        if (notif['type'] == 'success') {
                          iconData = Icons.check_circle_rounded;
                          iconColor = const Color(0xFF10B981);
                          bgColor = const Color(0xFFECFDF5);
                        } else if (notif['type'] == 'warning') {
                          iconData = Icons.warning_rounded;
                          iconColor = const Color(0xFFF59E0B);
                          bgColor = const Color(0xFFFFFBEB);
                        } else {
                          iconData = Icons.local_activity_rounded;
                          iconColor = const Color(0xFF8B5CF6);
                          bgColor = const Color(0xFFF5F3FF);
                        }
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(iconData, color: iconColor, size: 24),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            notif['title'],
                                            style: const TextStyle(
                                              color: Color(0xFF111827),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: -0.2,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          notif['time'],
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      notif['subtitle'],
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
