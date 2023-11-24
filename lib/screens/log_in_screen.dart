import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'home_bottom_bar.dart';
import 'forgot_password_screen.dart';
import 'intro_screen.dart';
import '../widgets/logo.dart';
import '../widgets/olives.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/log-in';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

var _isVisible;

// void _canLogin(String phoneNumber, String password) {}

class _LogInScreenState extends State<LogInScreen> {
  @override
  void initState() {
    _isVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);

    return Scaffold(
      body: FadeInUp(
        duration: Duration(milliseconds: 2000),
        child: SingleChildScrollView(
          child: Container(
            height: media.size.height - media.padding.top,
            margin: EdgeInsets.only(
              top: media.padding.top,
              bottom: media.padding.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(),
                Column(
                  children: [
                    SizedBox(
                      height: media.size.height * 0.3,
                      child: Image.asset('assets/images/Login.png'),
                    ),
                    FittedBox(
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'PollerOne',
                          fontSize: 20,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        'sign in to continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Forms(),
                const Spacer(),
                Buttons(),
                // const Spacer(),
                Olives(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Forms extends StatefulWidget {
  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    return Form(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: TextFormField(
              maxLength: 8,
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: theme.colorScheme.primary),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(230, 240, 255, 1),
                constraints: BoxConstraints(
                  maxHeight: media.size.height * 0.055,
                  maxWidth: media.size.width * 0.8,
                ),
                isDense: true,
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: const Text('Phone Number'),
                prefixIcon: Icon(
                  Icons.phone,
                  color: theme.colorScheme.primary,
                  size: 18,
                ),
                prefix: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    '09',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ),
              ),
            ),
          ),
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              obscureText: _isVisible,
              textInputAction: TextInputAction.done,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(230, 240, 255, 1),
                constraints: BoxConstraints(
                  maxHeight: media.size.height * 0.055,
                  maxWidth: media.size.width * 0.8,
                ),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: const Text('Password'),
                prefixIcon: Icon(
                  Icons.lock,
                  color: theme.colorScheme.primary,
                  size: 18,
                ),
                suffixIcon: IconButton(
                  splashRadius: 20,
                  onPressed: () => setState(() => _isVisible = !_isVisible),
                  icon: Icon(
                    _isVisible ? Icons.visibility : Icons.visibility_off,
                    color: theme.colorScheme.primary,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.35,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeBottomBar.routeName, (Route<dynamic> route) => false);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName),
            child: const FittedBox(
              child: Text(
                'Forgot your password?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FittedBox(
                child: Text('Don\'t have an account? '),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      IntroScreens.routeName, (Route<dynamic> route) => false);
                },
                child: const FittedBox(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
