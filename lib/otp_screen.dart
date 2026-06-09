import 'package:flutter/material.dart';
import 'dart:async';
import 'main_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Add focus listeners to trigger rebuilds for shadow animations
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
  }

  void _startTimer() {
    _canResend = false;
    _secondsRemaining = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        // Auto-verify when all 4 digits entered
        bool isComplete = _controllers.every((c) => c.text.isNotEmpty);
        if (isComplete) {
          _verifyOtp();
        }
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  void _verifyOtp() {
    // Show loading or directly navigate
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF111827), size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // Animated Lock Icon Header
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0F7B45).withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_person_outlined,
                    size: 40,
                    color: Color(0xFF0F7B45),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              const Text(
                'Enter OTP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 15,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(text: 'We have sent a 4-digit code to\n'),
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              
              // 4-Digit OTP Input Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  final isFocused = _focusNodes[index].hasFocus;
                  final hasText = _controllers[index].text.isNotEmpty;
                  
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 64,
                    height: 72,
                    decoration: BoxDecoration(
                      color: isFocused ? Colors.white : const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isFocused 
                            ? const Color(0xFF0F7B45) 
                            : hasText 
                                ? const Color(0xFF111827).withOpacity(0.2) 
                                : Colors.transparent,
                        width: isFocused ? 2 : 1,
                      ),
                      boxShadow: [
                        if (isFocused)
                          BoxShadow(
                            color: const Color(0xFF0F7B45).withOpacity(0.15),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          )
                        else if (hasText)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Center(
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 28, 
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) => _onChanged(value, index),
                      ),
                    ),
                  );
                }),
              ),
              
              const SizedBox(height: 48),
              
              // Verify Button
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F7B45),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadowColor: const Color(0xFF0F7B45).withOpacity(0.5),
                  ),
                  child: const Text(
                    'Verify & Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Resend Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                  ),
                  if (_canResend)
                    GestureDetector(
                      onTap: () {
                        // Logic to resend OTP
                        _startTimer();
                      },
                      child: const Text(
                        'Resend Now',
                        style: TextStyle(
                          color: Color(0xFF0F7B45),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    Text(
                      '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
}
