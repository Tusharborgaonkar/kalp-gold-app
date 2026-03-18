import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // Light grey background
      appBar: AppBar(
        title: const Text(
          'MESSAGES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
            fontSize: 18,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sub-header (similar to reference)
            Container(
              color: AppColors.primaryLight,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'LIVE RATES',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    'TREND',
                    style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Message Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Date Header
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        '01-02-2025 02:16 PM',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    
                    // Logo Placeholder (optional, as seen in screenshot)
                    Center(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.image_outlined, color: Colors.grey, size: 32),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Message Content
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Text(
                            'Dear Bullion & Jewelers Friends',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 24),
                          _BulletPoint('Open an online booking account without any type of Margin & Deposit with Suvidhi Jewelex LLP.'),
                          _BulletPoint('Monday to Friday Online Booking Available from 09:05 am to 11.25 pm'),
                          _BulletPoint('Saturday Online Booking Available from 11:30 am to 06.00 pm'),
                          _BulletPoint('Pending Order Limit facility Available from 09.15 am and its valid till 11.25 pm'),
                          _BulletPoint('We Supply *Gold & Silver*'),
                          _BulletPoint('Minimum booking in Gold is 10gm, and Silver is 5 kg.'),
                          _BulletPoint('Provide Us Your \'GST Certificate For Start Booking Service.'),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Contact Footer
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Mo: 8154 995 995',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'FOR LIVE RATE DOWNLOAD OUR APPLICATION FROM',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textSecondary.withValues(alpha: 0.8),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Footer Brading
            const Center(
              child: Text(
                '© 2018 by Suvidhi Jewelex LLP',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 100), // Space for FABs and Bottom Nav
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'msgCallBtn',
              onPressed: () {},
              backgroundColor: AppColors.error,
              child: const Icon(Icons.phone, color: Colors.white, size: 28),
            ),
            FloatingActionButton(
              heroTag: 'msgWaBtn',
              onPressed: () {},
              backgroundColor: AppColors.success,
              child: const Icon(Icons.chat, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('* ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
