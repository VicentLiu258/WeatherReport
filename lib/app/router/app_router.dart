import 'package:flutter/material.dart';

import '../../features/weather/presentation/pages/weather_page.dart';

class AppRouter {
  AppRouter._();

  static const String weather = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case weather:
        return MaterialPageRoute<void>(
          builder: (_) => const WeatherPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute<void>(
          builder: (_) => const _NotFoundPage(),
          settings: settings,
        );
    }
  }
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Route not found'),
      ),
    );
  }
}
