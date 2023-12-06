import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/orders_provider.dart';

const String host = '192.168.43.239';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, child) =>
            MaterialApp(
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
                    color: Color.fromRGBO(219, 243, 250, 1),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  toolbarHeight: MediaQuery
                      .of(context)
                      .size
                      .height * 0.08,
                  color: const Color.fromRGBO(3, 37, 78, 1),
                  titleTextStyle: const TextStyle(
                    color: Color.fromRGBO(219, 243, 250, 1),
                    fontSize: 20,
                    fontFamily: 'PollerOne',
                  ),
                ),
                bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: const Color.fromRGBO(3, 37, 78, 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery
                        .of(context)
                        .size
                        .height * 0.08,
                  ),
                ),),
              initialRoute: auth.isAuth ? HomeBottomBar.routeName : SplashScreen.routeName,
              routes: {
                SplashScreen.routeName: (_) => SplashScreen(),
                LogInScreen.routeName: (_) => LogInScreen(),
                IntroScreens.routeName: (_) => IntroScreens(),
                SignUpScreen.routeName: (_) => SignUpScreen(),
                ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
                OTPScreen.routeName: (_) => OTPScreen(),
                ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
                HomeBottomBar.routeName: (_) => HomeBottomBar(),
                CartScreen.routeName: (_) => CartScreen(),
                OrdersScreen.routeName: (_) => OrdersScreen(),
                CategoriesScreen.routeName: (_) => CategoriesScreen(),
                CategoryDrugsScreen.routeName: (_) => CategoryDrugsScreen(),
              },
            ),
      ),
    );
  }
}
