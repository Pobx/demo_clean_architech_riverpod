import 'package:auto_route/auto_route.dart';
import 'package:demo_clean_architech_riverpod/features/splash/presentation/providers/splash_provider.dart';
import 'package:demo_clean_architech_riverpod/routes/app_route.gr.dart';
import 'package:flutter/material.dart';
import 'package:demo_clean_architech_riverpod/routes/app_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = '/splashScreen';

  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final AppRouter appRouter = AppRouter();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      final isUserLoggedIn = await ref.read(userLoginCheckProvider.future);
      final route = isUserLoggedIn
          ? const DashboardRoute()
          : LoginRoute() as PageRouteInfo;

      if (!mounted) {
        return false;
      }

      context.router.pushAndPopUntil(route, predicate: (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
      ),
    );
  }
}
