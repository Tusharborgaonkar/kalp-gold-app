import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/classic_action_button.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback? onLogin;
  const LoginScreen({super.key, this.onLogin});

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
                // Logo Header
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
                          const SizedBox(height: 100), // Space for floating buttons
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Footer
                _buildFooter(),
              ],
            ),
          ),

          // Floating Action Buttons
          _buildFloatingButtons(),
        ],
      ),
    );
  }

  Widget _buildLogoHeader() {
    return Container(
      width: double.infinity,
      color: AppColors.primary, // Using Deep Navy from constants
      height: 60, // Set height instead of padding with logo
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
          // Card Header
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
          
          // Card Body
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTextField('Name'),
                const SizedBox(height: 12),
                _buildTextField('Mobile Number'),
                const SizedBox(height: 24),
                
                // Generate OTP Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onLogin ?? () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Generate OTP',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Card Footer
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

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.grey),
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
            // Call Button
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
            
            // WhatsApp Button
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

