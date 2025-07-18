import 'package:flutter/material.dart';
import 'package:hall_dining_management/theme_provider.dart';
import 'package:provider/provider.dart';
import 'screens/forgot_password_page.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_page.dart';
import 'screens/qr_scanner_page.dart';
import 'screens/food_menu_page.dart';
import 'screens/edit_profile_page.dart';
import 'screens/app_settings_page.dart';
import 'admin_panel_pages/admin_dashboard_page.dart';
import 'admin_panel_pages/user_management_page.dart';
import 'admin_panel_pages/manage_menu_page.dart';
import 'screens/scan_logs_page.dart';
import 'admin_panel_pages/dining_stats_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Hall Dining Management',
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(79, 199, 255, 1),
        ),
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: '/login',
      routes: {
        '/forgotPassword': (context) => ForgotPasswordPage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpPage(),
        '/qrScanner': (context) => QRScannerPage(),
        '/foodMenu': (context) => FoodMenuPage(),
        '/editProfile': (context) => EditProfilePage(),
        '/settings': (context) => SettingsPage(),
        '/adminDashboard': (context) => AdminDashboardPage(),
        '/userManagement': (context) => UserManagementPage(),
        '/manageMenu': (context) => ManageMenuPage(),
        '/scanLogs': (context) => ScanLogsPage(),
        '/diningStats': (context) => DiningStatsPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
