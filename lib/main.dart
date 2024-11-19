import 'package:drivado_test_app/screens/dashboard_screen.dart';
import 'package:drivado_test_app/services/company_services.dart';
import 'package:drivado_test_app/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CompanyProvider()),
      ],
      child: DrivadoTestAPP(),
    ),
  );
}

class DrivadoTestAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DashboardScreen(),
    );
  }
}
