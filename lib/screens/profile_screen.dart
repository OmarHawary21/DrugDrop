//import '/translations/locale_keys.g.dart';
//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/widgets/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        SizedBox(height: media.height * 0.04),
        CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage('assets/images/Online Doctor-cuate.png'),
          backgroundColor: theme.background,
        ),
        SizedBox(height: media.height * 0.04),
        ProfileItem('Name', 'Taghreed Sweideh', Icons.person),
        SizedBox(height: media.height * 0.02),
        ProfileItem('Phone', '0957515618', Icons.phone),
        SizedBox(height: media.height * 0.02),
        ProfileItem('Address', 'Damascus,Syria', Icons.location_pin),
        SizedBox(height: media.height * 0.02),
        // ProfileItem('Email', 'taghreedsweideh@gmail.com', Icons.mail),
        // SizedBox(height: media.height * 0.02),
        // ElevatedButton(
        //     onPressed: () {},
        //     style: ElevatedButton.styleFrom(
        //       padding: const EdgeInsets.all(10),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //       backgroundColor: Theme.of(context).colorScheme.primary,
        //       foregroundColor: Colors.white,
        //     ),
        //     child: const Text('Edit Profile')),
      ],
    );
  }
}
