import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/constants.dart';
import '../widgets/kyc_intro_step.dart';
import '../widgets/kyc_details_step.dart';
import '../widgets/kyc_pan_step.dart';
import '../widgets/kyc_aadhaar_step.dart';
import '../widgets/kyc_selfie_step.dart';
import '../widgets/kyc_review_step.dart';

class KYCFlowScreen extends StatefulWidget {
  final VoidCallback onVerificationComplete;
  const KYCFlowScreen({super.key, required this.onVerificationComplete});

  @override
  State<KYCFlowScreen> createState() => _KYCFlowScreenState();
}

class _KYCFlowScreenState extends State<KYCFlowScreen> {
  int _currentStep = 0;
  final int _totalSteps = 6;
  final PageController _pageController = PageController();

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onVerificationComplete();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary, size: 20),
          onPressed: _previousStep,
        ),
        title: _buildStepIndicator(),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentStep = index),
        children: [
          KYCIntroStep(onContinue: _nextStep),
          KYCDetailsStep(onContinue: _nextStep),
          KYCPanStep(onContinue: _nextStep),
          KYCAadhaarStep(onContinue: _nextStep),
          KYCSelfieStep(onContinue: _nextStep),
          KYCReviewStep(onContinue: _nextStep),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_totalSteps, (index) {
        final isActive = index <= _currentStep;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.silverLight,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
