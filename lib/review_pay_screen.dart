import 'package:flutter/material.dart';
import 'payment_success_screen.dart';

class ReviewPayScreen extends StatefulWidget {
  final Map<String, dynamic> attraction;
  final int adultsCount;
  final int childrenCount;
  final int totalAmount;

  const ReviewPayScreen({
    super.key,
    required this.attraction,
    required this.adultsCount,
    required this.childrenCount,
    required this.totalAmount,
  });

  @override
  State<ReviewPayScreen> createState() => _ReviewPayScreenState();
}

class _ReviewPayScreenState extends State<ReviewPayScreen> {
  int _selectedPaymentMethod = 0; // 0: UPI, 1: Card, 2: Net Banking, 3: Wallets

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
          'Review & Pay',
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
                    // Premium Ticket Stub Summary
                    Container(
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
                      child: Column(
                        children: [
                          // Top Part: Attraction
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: widget.attraction['image'] != null && widget.attraction['image']!.startsWith('http')
                                      ? Image.network(
                                          widget.attraction['image']!,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                          headers: const {'User-Agent': 'FlutterApp/1.0 (https://flutter.dev)'},
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            width: 70,
                                            height: 70,
                                            color: Colors.grey.shade300,
                                            child: const Icon(Icons.image, color: Colors.grey),
                                          ),
                                        )
                                      : Image.asset(
                                          widget.attraction['image'] ?? '',
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            width: 70,
                                            height: 70,
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
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on, color: Color(0xFF0F7B45), size: 14),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              widget.attraction['location'] ?? 'Location',
                                              style: const TextStyle(
                                                color: Color(0xFF6B7280),
                                                fontSize: 14,
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
                          
                          // Divider with cutouts
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF8FAF8),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              Container(
                                width: 12,
                                height: 24,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF8FAF8),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Bottom Part: Details
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildDetailColumn('Date', '24 May 2025'),
                                    _buildDetailColumn('Time', '10:00 AM - 12:00 PM'),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildDetailColumn('Tickets', '${widget.adultsCount} Adult, ${widget.childrenCount} Child'),
                                    _buildDetailColumn('Total', '₹${widget.totalAmount}', isHighlight: true),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Payment Tiles
                    _buildPaymentOption(0, 'UPI (GPay, PhonePe, Paytm)', 'assets/images/upi_icon.png', Icons.qr_code_scanner),
                    const SizedBox(height: 12),
                    _buildPaymentOption(1, 'Credit / Debit Card', 'assets/images/card_icon.png', Icons.credit_card),
                    const SizedBox(height: 12),
                    _buildPaymentOption(2, 'Net Banking', 'assets/images/netbanking_icon.png', Icons.account_balance),
                  ],
                ),
              ),
            ),
            
            // Bottom Sticky Pay Footer
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
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PaymentSuccessScreen(
                            attraction: widget.attraction,
                            adultsCount: widget.adultsCount,
                            childrenCount: widget.childrenCount,
                            totalAmount: widget.totalAmount,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F7B45),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Pay securely ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '₹${widget.totalAmount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.lock_outline, color: Colors.white, size: 16),
                      ],
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

  Widget _buildDetailColumn(String title, String value, {bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: isHighlight ? const Color(0xFF0F7B45) : const Color(0xFF111827),
            fontSize: isHighlight ? 18 : 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(int index, String title, String imageAsset, IconData fallbackIcon) {
    final isSelected = _selectedPaymentMethod == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF0F7B45) : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(fallbackIcon, color: const Color(0xFF4B5563), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFF0F7B45) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFF0F7B45) : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
