import 'package:anime_lab/features/home/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:anime_lab/routes/route_path_name.dart';
import 'package:anime_lab/features/auth/screens/onboarding_screen.dart';
import 'package:anime_lab/features/auth/screens/login_screen.dart';
import 'package:anime_lab/features/auth/screens/signup_screen.dart';

final appRouter = GoRouter(
  initialLocation: RoutePathName.onboarding,
  routes: [
    GoRoute(
      path: RoutePathName.onboarding,
      name: RoutePathName.onboardingName,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RoutePathName.login,
      name: RoutePathName.loginName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePathName.signup,
      name: RoutePathName.signupName,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: RoutePathName.home,
      name: RoutePathName.homeName,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
