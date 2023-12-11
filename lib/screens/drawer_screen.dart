import 'package:aakriti_inteligence/screens/about_us.dart';
import 'package:aakriti_inteligence/screens/home_screen.dart';
import 'package:aakriti_inteligence/screens/privacy_policy.dart';
import 'package:aakriti_inteligence/screens/term_condition.dart';
import 'package:aakriti_inteligence/utils/colors.dart';
import 'package:aakriti_inteligence/utils/my_utitlity.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(color: AppColors.kappBarColorlight),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('images/logo.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Ramesh Das',
                  style: TextStyle(
                    color: AppColors.kwhiteColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'ramesh123@gmail.com',
                  style: TextStyle(
                    color: AppColors.kwhiteColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dvr_sharp),
            title: const Text('Term & Conditions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermAndCondion(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy & Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyAndPolicy(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting & Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outlined),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone_in_talk_outlined),
            title: const Text('Contact Support'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await Utility.clearPreferenceData();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomeScreen()),
                  ModalRoute.withName('/'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
