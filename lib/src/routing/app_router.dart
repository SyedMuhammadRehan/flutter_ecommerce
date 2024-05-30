import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce/src/routing/go_router_refresh_stream.dart';
import 'package:flutter_ecommerce/src/screens/custom_profile_screen.dart';
import 'package:flutter_ecommerce/src/screens/custom_sign_in_screen.dart';
import 'package:flutter_ecommerce/src/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  signIn,
  homePage,
  profile,
}

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});
final goRouterProvider = Provider<GoRouter>((ref) {
  final firebaseauth = ref.watch(firebaseAuthProvider);

  return GoRouter(
    initialLocation: '/sign-in',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isloggedin = firebaseauth.currentUser != null;
      print("i am in teh log $isloggedin ");
      if (isloggedin) {
        if (state.uri.path == '/sign-in') {
          return '/home';
        }
      } else {
        if (state.uri.path.startsWith('/home')) {
          return '/sign-in';
        }
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(firebaseauth.authStateChanges()),
    routes: [
      GoRoute(
        path: '/sign-in',
        name: AppRoute.signIn.name,
        builder: (context, state) => const CustomSignInScreen(),
      ),
      GoRoute(
          path: '/home',
          name: AppRoute.homePage.name,
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'profile',
              name: AppRoute.profile.name,
              builder: (context, state) => const CustomProfileScreen(),
            ),
          ]),
    ],
  );
});
