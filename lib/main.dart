import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/trade/presentation/screens/trade_screen.dart';
import 'features/orders/presentation/screens/orders_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/rates/presentation/screens/live_rates_screen.dart';
import 'core/constants/constants.dart';

void main() {
  runApp(const GoldSilverApp());
}

class GoldSilverApp extends StatelessWidget {
  const GoldSilverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainNavigationScreen(),
      },
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  String? _pendingMetal;

  void _onTradeRequested(String? metal) {
    setState(() {
      _pendingMetal = metal;
      _selectedIndex = 2; // Index of TradeScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onTrade: () => _onTradeRequested(null)),
      LiveRatesScreen(onTrade: (metal) => _onTradeRequested(metal)),
      TradeScreen(initialMetal: _pendingMetal),
      const OrdersScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Stack(
          children: [
            BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                  if (index != 2) _pendingMetal = null;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textSecondary.withValues(alpha: 0.5),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_outlined),
                  activeIcon: Icon(Icons.grid_view_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up_outlined),
                  activeIcon: Icon(Icons.trending_up_rounded),
                  label: 'Rates',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.swap_horiz_outlined),
                  activeIcon: Icon(Icons.swap_horiz_rounded),
                  label: 'Trade',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined),
                  activeIcon: Icon(Icons.receipt_long_rounded),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  activeIcon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              left: (MediaQuery.of(context).size.width / 5) * _selectedIndex + (MediaQuery.of(context).size.width / 10) - 15,
              top: 0,
              child: Container(
                width: 30,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
