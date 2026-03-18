import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/diamond_pattern_painter.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          // Geometric Background Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                painter: DiamondPatternPainter(),
              ),
            ),
          ),
          
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                
                // Call Us Section
                _buildSectionLabel('Call Us'),
                _buildCard(
                  child: Column(
                    children: [
                      const Text(
                        'SUVIDHI JEWELEX LLP',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildContactItem(
                        icon: Icons.phone_android,
                        iconColor: Colors.green,
                        label: 'Booking',
                        value: '8154 995 995',
                      ),
                      _buildContactItem(
                        icon: Icons.phone_android,
                        iconColor: Colors.green,
                        label: 'For Contact',
                        value: '94288 46615\n94277 80252',
                      ),
                      _buildContactItem(
                        icon: Icons.phone_android,
                        iconColor: Colors.green,
                        label: 'For Delivery',
                        value: '7573 995 995',
                      ),
                      _buildContactItem(
                        icon: Icons.phone,
                        iconColor: Colors.blue,
                        label: 'For Account',
                        value: '7574 995 995',
                      ),
                    ],
                  ),
                ),
                
                // Address Section
                _buildSectionLabel('Address'),
                _buildCard(
                  child: Column(
                    children: [
                      const Icon(Icons.location_on, color: Colors.orange, size: 40),
                      const SizedBox(height: 12),
                      const Text(
                        '426 - E, 4th floor,\nSuper Mall, Near Lal bunglow,\nC.G.Road, Navrangpura,\nAhmedabad - 09',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Map Placeholder (Simulated)
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.map, size: 48, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Map View Placeholder', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.open_in_new, size: 16),
                        label: const Text('Open in Maps'),
                      ),
                    ],
                  ),
                ),
                
                // Email Section
                _buildCard(
                  child: Column(
                    children: [
                      const Icon(Icons.email, color: Colors.red, size: 40),
                      const SizedBox(height: 12),
                      const Text(
                        'Email id',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'suvidhijewelex@gmail.com',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Website Section
                _buildCard(
                  child: Column(
                    children: [
                      const Icon(Icons.language, color: Colors.blue, size: 40),
                      const SizedBox(height: 12),
                      const Text(
                        'Website',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'www.suvidhijewelex.com',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 30),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
