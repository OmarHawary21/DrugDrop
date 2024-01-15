import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:easy_localization/easy_localization.dart";

import 'log_in_screen.dart';
import 'settings_screen.dart';
import '../widgets/profile_item.dart';
import '../providers/auth_provider.dart';
import '../translations/locale_keys.g.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  void _showDialog(BuildContext context, String content, String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            text,
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
        content: Text(content),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.pushNamedAndRemoveUntil(context,
                      LogInScreen.routeName, (Route<dynamic> route) => false);
                },
                child: Text(LocaleKeys.yes.tr()),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(LocaleKeys.no.tr()),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context).colorScheme;
    var userInfo = Provider.of<AuthProvider>(context).userData;
    return Padding(
      padding: EdgeInsets.only(bottom: media.height * 0.08),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: media.height * 0.02),
            CircleAvatar(
              radius: media.width * 0.2,
              backgroundImage: const AssetImage('assets/images/Online Doctor-cuate.png'),
              backgroundColor: theme.background,
            ),
            SizedBox(height: media.height * 0.02),
            ProfileItem(
              LocaleKeys.name.tr(),
              userInfo['name']!,
              Icons.person,
              () {},
            ),
            SizedBox(height: media.height * 0.02),
            ProfileItem(
              LocaleKeys.phone_number.tr(),
              userInfo['phoneNumber']!,
              Icons.phone,
              () {},
            ),
            SizedBox(height: media.height * 0.02),
            ProfileItem(
              LocaleKeys.address.tr(),
              userInfo['location']!,
              Icons.location_pin,
              () {},
            ),
            SizedBox(height: media.height * 0.02),
            ProfileItem(
              LocaleKeys.settings.tr(),
              'Edit your  app settings',
              Icons.settings,
              () => Navigator.of(context).pushNamed(SettingsScreen.routeName),
            ),
            SizedBox(height: media.height * 0.02),
            ProfileItem(
              LocaleKeys.log_out.tr(),
              'Do you want to leave?',
              Icons.logout,
                    () {
                  _showDialog(
                      context,
                      '${LocaleKeys.are_u_sure_from_logging.tr()}?',
                      LocaleKeys.sorry_to_hear.tr());
                },
            ),
          ],
        ),
      ),
    );
  }
}
