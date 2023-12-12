import 'package:aakriti_inteligence/models/login_data_model.dart';
import 'package:aakriti_inteligence/screens/about_us.dart';
import 'package:aakriti_inteligence/screens/home_screen.dart';
import 'package:aakriti_inteligence/screens/login_screen.dart';
import 'package:aakriti_inteligence/screens/privacy_policy.dart';
import 'package:aakriti_inteligence/screens/term_condition.dart';
import 'package:aakriti_inteligence/utils/app_string.dart';
import 'package:aakriti_inteligence/utils/colors.dart';
import 'package:aakriti_inteligence/utils/my_utitlity.dart';
import 'package:aakriti_inteligence/widgets/custom_btn.dart';
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
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                ],
              ),
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
                            builder: (BuildContext context) =>
                                const HomeScreen()),
                        ModalRoute.withName('/'),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginScreen()),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer(
      {super.key, required this.isLogin, this.userProfileData});
  final bool isLogin;
  final LoginDataModel? userProfileData;

  @override
  CustomNavigationDrawerState createState() => CustomNavigationDrawerState();
}

class CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
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

  Widget customTile({
    required String text,
    required IconData leadingIcon,
    required Function()? onTap,
  }) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      child: ListTile(
        // contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        leading: Icon(leadingIcon),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }

  @override
  void initState() {
    getDefaultData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Drawer(
      child: SingleChildScrollView(
        child: SizedBox(
          height: deviceHeight,
          width: deviceWidth / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.06,
                    ),
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/logo.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      userEmail,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.only(
                  left: deviceWidth / 20,
                  right: deviceWidth / 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customTile(
                      text: "Home",
                      onTap: () {
                        Navigator.pop(context);
                      },
                      leadingIcon: Icons.home,
                    ),
                    const Divider(),
                    customTile(
                      text: "Term & Conditions",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermAndCondion(),
                          ),
                        );
                      },
                      leadingIcon: Icons.dvr_sharp,
                    ),
                    const Divider(),
                    customTile(
                      text: "Privacy & Policy",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyAndPolicy(),
                          ),
                        );
                      },
                      leadingIcon: Icons.privacy_tip,
                    ),
                    const Divider(),
                    customTile(
                      text: "Setting & Profile",
                      onTap: () {
                        Navigator.pop(context);
                      },
                      leadingIcon: Icons.settings,
                    ),
                    const Divider(),
                    customTile(
                      text: "About Us",
                      leadingIcon: Icons.info_outlined,
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
                    customTile(
                      text: "Contact Support",
                      leadingIcon: Icons.phone_in_talk_outlined,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.kbuttonColor,
                        child: Text(widget.isLogin ? 'Logout' : 'Login'),
                        onPressed: () async {
                          if (widget.isLogin) {
                            await Utility.clearPreferenceData();
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const HomeScreen()),
                                ModalRoute.withName('/'),
                              );
                            }
                          } else {
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginScreen()),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Text("Version 1.0.0"),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
