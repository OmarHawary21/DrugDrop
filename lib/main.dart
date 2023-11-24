import 'package:flutter/material.dart';

import 'screens/log_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/home_bottom_bar.dart';
import 'screens/categories_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/category_drugs_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DrugDrop',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 252, 252, 1),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(3, 37, 78, 1),
          secondary: const Color.fromRGBO(219, 243, 250, 1),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(3, 37, 78, 1),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.08,
          color: const Color.fromRGBO(230, 240, 255, 1),
          titleTextStyle: const TextStyle(
            color: Color.fromRGBO(3, 37, 78, 1),
            fontSize: 20,
            fontFamily: 'PollerOne',
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => SplashScreen(),
        LogInScreen.routeName: (_) => LogInScreen(),
        IntroScreens.routeName:(_) => IntroScreens(),
        SignUpScreen.routeName: (_) => SignUpScreen(),
        ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
        OTPScreen.routeName: (_) => OTPScreen(),
        ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
        HomeBottomBar.routeName: (_) => HomeBottomBar(),
        CategoriesScreen.routeName: (_) => CategoriesScreen(),
        CategoryDrugsScreen.routeName: (_) => CategoryDrugsScreen(),
      },
    );
  }
}
