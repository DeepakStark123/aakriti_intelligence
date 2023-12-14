import 'package:aakriti_inteligence/models/login_data_model.dart';
import 'package:aakriti_inteligence/screens/about_us.dart';
import 'package:aakriti_inteligence/screens/edit_profile.dart';
import 'package:aakriti_inteligence/screens/login_screen.dart';
import 'package:aakriti_inteligence/screens/privacy_policy.dart';
import 'package:aakriti_inteligence/screens/term_condition.dart';
import 'package:aakriti_inteligence/utils/app_string.dart';
import 'package:aakriti_inteligence/utils/colors.dart';
import 'package:aakriti_inteligence/utils/my_utitlity.dart';
import 'package:aakriti_inteligence/widgets/custom_btn.dart';
import 'package:aakriti_inteligence/widgets/custom_text.dart';
import 'package:flutter/material.dart';

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
      child: SizedBox(
        height: deviceHeight,
        width: deviceWidth / 1.5,
        child: SingleChildScrollView(
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
                    CustomTextWidget(
                      text: userName,
                      fontSize: 18,
                    ),
                    CustomTextWidget(
                      text: userEmail,
                      fontSize: 14,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
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
                        child: CustomTextWidget(
                          text: widget.isLogin ? 'Logout' : 'Login',
                          color: AppColors.kwhiteColor,
                        ),
                        onPressed: () async {
                          if (widget.isLogin) {
                            Utility.logoutFromApp(context);
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
                    child: CustomTextWidget(
                      text: "Version 1.0.0",
                    ),
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
