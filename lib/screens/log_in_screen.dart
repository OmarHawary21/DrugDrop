import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'home_bottom_bar.dart';
import 'forgot_password_screen.dart';
import 'intro_screen.dart';
import '../widgets/logo.dart';
import '../widgets/olives.dart';
import '../providers/auth_provider.dart';

class LogInScreen extends StatelessWidget {
  static const routeName = '/log-in';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);

    return Scaffold(
      body: FadeInUp(
        duration: const Duration(milliseconds: 2000),
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
                      height: media.size.height * 0.25,
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
                Olives(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var _isVisible;

class Forms extends StatefulWidget {
  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    'phoneNumber': '',
    'password': '',
  };
  var _isLoading = false;

  @override
  void initState() {
    _isVisible = true;
    super.initState();
  }

  void _showDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'An error Occurred',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        content: Text(content),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  void submit() async {
    final validator = _formKey.currentState?.validate();
    if (validator == null || !validator) {
      return;
    }
    _formKey.currentState?.save();
    setState(() => _isLoading = true);
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login(_authData['phoneNumber']!, _authData['password']!);
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeBottomBar.routeName, (Route<dynamic> route) => false);
    } catch (error) {
      _showDialog(context,
          'Worng phone number or password please check the spelling and try again.');
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              maxLength: 8,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15),
                prefixIcon: const Icon(Icons.phone),
                prefixIconColor: theme.colorScheme.primary,
                prefix: const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Text('09'),
                ),
                prefixStyle: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                label: const Text('Phone Number'),
                isDense: true,
                filled: true,
                fillColor: theme.colorScheme.secondary,
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (phoneNumber) {
                if (phoneNumber!.isEmpty) {
                  return 'This field is required';
                } else if (phoneNumber.length < 8) {
                  return 'Must be 8 digits';
                }
              },
              onSaved: (phoneNumber) =>
                  _authData['phoneNumber'] = phoneNumber.toString(),
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: _isVisible,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15),
                prefixIcon: const Icon(Icons.lock),
                prefixIconColor: theme.colorScheme.primary,
                label: const Text('Password'),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _isVisible = !_isVisible),
                  icon: Icon(
                      _isVisible ? Icons.visibility : Icons.visibility_off),
                ),
                suffixIconColor: theme.colorScheme.primary,
                isDense: true,
                filled: true,
                fillColor: theme.colorScheme.secondary,
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (phoneNumber) {
                if (phoneNumber!.isEmpty) {
                  return 'This field is required';
                }
              },
              onSaved: (password) =>
                  _authData['password'] = password.toString(),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: submit,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeCap: StrokeCap.round,
                    )
                  : const Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => Navigator.of(context)
                  .pushNamed(ForgotPasswordScreen.routeName),
              child: const FittedBox(
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Row(
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
                        IntroScreens.routeName,
                        (Route<dynamic> route) => false);
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
          ],
        ),
      ),
    );
  }
}
