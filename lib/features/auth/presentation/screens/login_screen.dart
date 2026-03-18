import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/classic_action_button.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onLogin;
  const LoginScreen({super.key, this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  
  bool _showOtpField = false;
  bool _isLoading = false;
  String? _mockOtp;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _generateOtp() async {
    // Proceed without validation as requested by user
    setState(() => _isLoading = true);
    
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _isLoading = false;
      _showOtpField = true;
      _mockOtp = '1234'; // Simulated OTP
    });

    _showSuccess('OTP Sent: 1234');
  }

  void _handleLogin() {
    final otp = _otpController.text.trim();
    if (otp == _mockOtp) {
      if (widget.onLogin != null) {
        widget.onLogin!();
      } else {
        // Standalone navigation fallback (e.g. from SplashScreen)
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } else {
      _showError('Invalid OTP. Please enter 1234');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: Image.asset(
              'assets/images/diamond_pattern.png',
              fit: BoxFit.cover,
              color: Colors.white.withValues(alpha: 0.94),
              colorBlendMode: BlendMode.screen,
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                _buildLogoHeader(),
                
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          _buildLoginCard(context),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
                
                _buildFooter(),
              ],
            ),
          ),

          _buildFloatingButtons(),
        ],
      ),
    );
  }

  Widget _buildLogoHeader() {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      height: 60,
    );
  }

  Widget _buildLoginCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (!_showOtpField) ...[
                  _buildTextField(
                    'Name', 
                    controller: _nameController, 
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    'Mobile Number', 
                    controller: _mobileController, 
                    isPhone: true, 
                    action: TextInputAction.done,
                    onSubmitted: (_) => _generateOtp(),
                  ),
                ] else ...[
                  Text(
                    'OTP sent to ${_mobileController.text}',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    'Enter OTP', 
                    controller: _otpController, 
                    isPhone: true, 
                    action: TextInputAction.done,
                    onSubmitted: (_) => _handleLogin(),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _showOtpField = false),
                    child: const Text('Change Details', style: TextStyle(color: AppColors.primary)),
                  ),
                ],
                const SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : (_showOtpField ? _handleLogin : _generateOtp),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading 
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text(
                          _showOtpField ? 'Login' : 'Generate OTP',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            width: double.infinity,
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: const Text(
              'To Register Call on +91 8154995995',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    required TextEditingController controller,
    bool isPhone = false,
    TextInputAction? action,
    ValueChanged<String>? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      textInputAction: action,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isPhone ? 25 : 4),
          borderSide: const BorderSide(color: Colors.black87),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isPhone ? 25 : 4),
          borderSide: const BorderSide(color: Colors.black87),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isPhone ? 25 : 4),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: const Text(
        '© 2018 by Suvidhi Jewelex LLP',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFC02F2F),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: const Icon(Icons.phone, color: Colors.white),
            ),
            
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: const Icon(Icons.chat_bubble, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

