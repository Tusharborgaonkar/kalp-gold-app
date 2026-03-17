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

  void _onBackRequested() {
    setState(() {
      _selectedIndex = 0; // Index of HomeScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      LiveRatesScreen(
        onTrade: (metal) => _onTradeRequested(metal),
        onBack: _onBackRequested,
      ),
      const Center(child: Text('Messages Screen', style: TextStyle(color: Colors.white))), // Placeholder
      TradeScreen(initialMetal: _pendingMetal),
      LoginScreen(onLogin: () {
        setState(() {
          _selectedIndex = 0; // Switch to Live Rates tab on login
        });
      }),
      ProfileScreen(onLogout: () {
        setState(() {
          _selectedIndex = 3; // Switch to Login tab
        });
      }),
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
              backgroundColor: const Color(0xFF1B2C4E), // Dark Navy matching screenshot
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withValues(alpha: 0.6),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up, size: 28),
                  label: 'Live Rates',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance, size: 28), // Bank icon as seen in mockup
                  label: 'Messages',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.description_outlined, size: 28), // Trades icon
                  label: 'Trades',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_pin, size: 28), // Login icon
                  label: 'Login',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu, size: 28),
                  label: 'Menu',
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
                  color: Colors.white,
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
