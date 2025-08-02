import 'package:go_router/go_router.dart';
import 'package:anime_lab/routes/route_path_name.dart';
import 'package:anime_lab/features/auth/onboarding/screens/onboarding_screen.dart';

final appRouter = GoRouter(
  initialLocation: RoutePathName.onboarding,
  routes: [
    GoRoute(
      path: RoutePathName.onboarding,
      name: RoutePathName.onboardingName,
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
);
