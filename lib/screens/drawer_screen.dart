import 'package:aakriti_inteligence/models/login_data_model.dart';
import 'package:aakriti_inteligence/screens/about_us.dart';
import 'package:aakriti_inteligence/screens/home_screen.dart';
import 'package:aakriti_inteligence/screens/login_screen.dart';
import 'package:aakriti_inteligence/screens/privacy_policy.dart';
import 'package:aakriti_inteligence/screens/term_condition.dart';
import 'package:aakriti_inteligence/utils/app_string.dart';
import 'package:aakriti_inteligence/utils/colors.dart';
import 'package:aakriti_inteligence/utils/my_utitlity.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key, required this.isLogin, this.userProfileData});
  final bool isLogin;
  final LoginDataModel? userProfileData;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String userName = AppStrings.appName;
  String userEmail = "Welcom Back";

  getDefaultData() {
    if (widget.userProfileData != null) {
      var firstName = widget.userProfileData?.user!.fname ?? "";
      var lastName = widget.userProfileData?.user!.lname ?? "";
      userEmail = widget.userProfileData?.user!.lname ?? "";
      userName = firstName + lastName;
    } else {
      userName = AppStrings.appName;
      userEmail = "Welcom Back";
    }
    setState(() {});
  }

  @override
  void initState() {
    getDefaultData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(color: AppColors.kappBarColorlight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('images/logo.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  userName,
                  style: const TextStyle(
                    color: AppColors.kwhiteColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  userEmail,
                  style: const TextStyle(
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
            leading: Icon(widget.isLogin ? Icons.logout : Icons.login),
            title: Text(widget.isLogin ? 'Logout' : 'Login'),
            onTap: () async {
              if (widget.isLogin) {
                await Utility.clearPreferenceData();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const HomeScreen()),
                    ModalRoute.withName('/'),
                  );
                }
              } else {
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginScreen()),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
