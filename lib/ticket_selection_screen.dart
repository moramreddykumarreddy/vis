import 'package:flutter/material.dart';
import 'visit_details_screen.dart';

class TicketSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> attraction;
  final bool initialUnifiedPassSelected;

  const TicketSelectionScreen({
    super.key, 
    required this.attraction,
    this.initialUnifiedPassSelected = false,
  });

  @override
  State<TicketSelectionScreen> createState() => _TicketSelectionScreenState();
}

class _TicketSelectionScreenState extends State<TicketSelectionScreen> {
  late bool _isUnifiedPassSelected;
  int _selectedPassIndex = 0; // 0 for Daily, 1 for Annual
  
  // General Ticket Quantities
  int _adultCount = 1;
  int _childCount = 0;
  
  // Pricing
  int _adultPrice = 100;
  int _childPrice = 50;
  final int _dailyPassPrice = 150;
  final int _annualPassPrice = 500;

  @override
  void initState() {
    super.initState();
    _isUnifiedPassSelected = widget.initialUnifiedPassSelected;
    String priceStr = widget.attraction['price'] ?? '₹100';
    if (priceStr.toLowerCase() == 'free') {
      _adultPrice = 0;
      _childPrice = 0;
    } else {
      String numericOnly = priceStr.replaceAll(RegExp(r'[^0-9]'), '');
      if (numericOnly.isNotEmpty) {
        _adultPrice = int.parse(numericOnly);
        _childPrice = (_adultPrice * 0.5).round(); // Child is 50%
      }
    }
  }

  int get _totalPrice {
    if (_isUnifiedPassSelected) {
      return _selectedPassIndex == 0 ? _dailyPassPrice : _annualPassPrice;
    } else {
      return (_adultCount * _adultPrice) + (_childCount * _childPrice);
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF111827), size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          'Select Tickets',
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
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Attraction Summary Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: widget.attraction['image'] != null && widget.attraction['image']!.startsWith('http')
                                ? Image.network(
                                    widget.attraction['image']!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    headers: const {'User-Agent': 'FlutterApp/1.0 (https://flutter.dev)'},
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey.shade300,
                                      child: const Icon(Icons.image, color: Colors.grey),
                                    ),
                                  )
                                : Image.asset(
                                    widget.attraction['image'] ?? '',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey.shade300,
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
                                  widget.attraction['title'] ?? 'Attraction',
                                  style: const TextStyle(
                                    color: Color(0xFF111827),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Color(0xFF0F7B45), size: 14),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        widget.attraction['location'] ?? 'Location',
                                        style: const TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 13,
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Premium Toggle Buttons
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isUnifiedPassSelected = false;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: !_isUnifiedPassSelected ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: !_isUnifiedPassSelected
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
                                  'General Ticket',
                                  style: TextStyle(
                                    color: !_isUnifiedPassSelected ? const Color(0xFF111827) : const Color(0xFF6B7280),
                                    fontWeight: !_isUnifiedPassSelected ? FontWeight.bold : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isUnifiedPassSelected = true;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: _isUnifiedPassSelected ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: _isUnifiedPassSelected
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
                                  'Unified Pass',
                                  style: TextStyle(
                                    color: _isUnifiedPassSelected ? const Color(0xFF111827) : const Color(0xFF6B7280),
                                    fontWeight: _isUnifiedPassSelected ? FontWeight.bold : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    if (_isUnifiedPassSelected) ...[
                      // Unified Pass View
                      const Text(
                        'Select Pass Type',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPassCard(0, 'Daily Pass', 'Valid for 1 Day', '₹150', false),
                      const SizedBox(height: 16),
                      _buildPassCard(1, 'Annual Pass', 'Valid for 1 Year', '₹500', true),
                      
                      const SizedBox(height: 32),
                      const Text(
                        'Includes Entry to',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildBulletPoint('Kailasagiri Hill Park'),
                      _buildBulletPoint('INS Kursura Submarine Museum'),
                      _buildBulletPoint('TU 142 Aircraft Museum'),
                      _buildBulletPoint('All VMRDA Parks & Attractions'),
                      
                    ] else ...[
                      // General Ticket View
                      const Text(
                        'Select Visitors',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      _buildVisitorCounter(
                        'Adult',
                        'Age 12+ years',
                        _adultPrice,
                        _adultCount,
                        (newCount) {
                          if (newCount >= 1) { // Require at least 1 adult
                            setState(() => _adultCount = newCount);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildVisitorCounter(
                        'Child',
                        'Age 3-11 years',
                        _childPrice,
                        _childCount,
                        (newCount) {
                          if (newCount >= 0) {
                            setState(() => _childCount = newCount);
                          }
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFCD34D)),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.info_outline, color: Color(0xFFD97706), size: 20),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Children below 3 years have free entry. Valid ID may be required at the gate.',
                                style: TextStyle(
                                  color: Color(0xFF92400E),
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ),
            
            // Bottom Sticky Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹$_totalPrice',
                          style: const TextStyle(
                            color: Color(0xFF111827),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => VisitDetailsScreen(attraction: widget.attraction),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F7B45),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassCard(int index, String title, String subtitle, String price, bool isPopular) {
    bool isSelected = _selectedPassIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPassIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF0F7B45) : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0F7B45).withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (isPopular)
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'BEST VALUE',
                      style: TextStyle(
                        color: Color(0xFFD97706),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Text(
                  price,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitorCounter(String title, String subtitle, int price, int count, Function(int) onChanged) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '₹$price',
                style: const TextStyle(
                  color: Color(0xFF0F7B45),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => onChanged(count - 1),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: count > (title == 'Adult' ? 1 : 0) ? const Color(0xFFF3F4F6) : Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.remove,
                    color: count > (title == 'Adult' ? 1 : 0) ? const Color(0xFF111827) : Colors.grey.shade400,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                count.toString(),
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => onChanged(count + 1),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFF111827),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF0F7B45), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
