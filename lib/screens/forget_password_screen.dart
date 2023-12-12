import 'dart:io';

import 'package:aakriti_inteligence/models/generate_otp_model.dart';
import 'package:aakriti_inteligence/models/login_data_model.dart';
import 'package:aakriti_inteligence/utils/api_service.dart';
import 'package:aakriti_inteligence/utils/app_string.dart';
import 'package:aakriti_inteligence/utils/colors.dart';
import 'package:aakriti_inteligence/utils/my_utitlity.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int durationTime = 1000;
  bool pageLoading = true;
  bool isUserLogin = false;
  bool otpField = false;
  bool loading = false;

  setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

//-------Login-With-Otp-----------------
  gererateOtp(String email) async {
    setLoading(true);
    var data = {"email": email.trim()};
    try {
      final response = await ApiService.postApi(
        endpoint: AppStrings.generateOtpApi,
        body: data,
      );
      debugPrint('GererateOtp Res: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var res = restaurantsModelFromJson(response.body.toString());
        if (res.status == 200) {
          if (context.mounted) {
            Utility.showCustomSnackbar(context, res.message ?? "Success", true);
          }
          setState(() {
            otpField = true;
          });
        } else {
          if (context.mounted) {
            Utility.showCustomSnackbar(context, res.message ?? "Fail", false);
          }
        }
      } else {
        debugPrint("Error = ${response.statusCode} message = ${response.body}");
      }
    } catch (e) {
      debugPrint('Exception Caught: $e');
    } finally {
      setLoading(false);
    }
  }

  forgetPassword({
    required String email,
    required String otp,
    required String password,
    required String repassword,
  }) async {
    setLoading(true);
    var data = {
      "email": email.trim(),
      "otp": otp.trim(),
      "password": password.trim(),
      "repassword": repassword.trim(),
    };
    try {
      final response = await ApiService.postApi(
        endpoint: AppStrings.forgetPasswordApi,
        body: data,
      );
      debugPrint('forgetPassword Res: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var res = loginDataModelFromJson(response.body.toString());
        if (res.status == 200) {
          await Utility.saveLogin(res.user!.email ?? "");
          await Utility.saveUserData(response.body.toString());
          if (context.mounted) {
            Utility.showCustomSnackbar(context, res.message ?? "Success", true);
          }
          clearform(isPopScreen: true);
        } else {
          if (context.mounted) {
            Utility.showCustomSnackbar(context, res.message ?? "Fail", false);
          }
        }
      } else {
        debugPrint("Error = ${response.statusCode} message = ${response.body}");
      }
    } catch (e) {
      debugPrint('Exception Caught: $e');
    } finally {
      setLoading(false);
    }
  }

  getInitilaData() async {
    try {
      LoginDataModel? data = await Utility().getUserProfileData();
      if (data != null) {
        setState(() {
          emailController.text = data.user!.email ?? "";
          pageLoading = false;
          isUserLogin = true;
        });
      } else {
        setState(() {
          pageLoading = false;
          isUserLogin = false;
        });
      }
      debugPrint("is user login = $isUserLogin");
    } catch (e) {
      debugPrint('Exception Caught: $e');
    }
  }

  clearform({bool isPopScreen = false}) {
    emailController.clear();
    otpController.clear();
    passwordController.clear();
    resetPasswordController.clear();
    otpField = false;
    loading = false;
    pageLoading = false;
    if (isPopScreen) {
      Navigator.pop(context, true);
    } else {
      if (!context.mounted) return;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getInitilaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          const Color(0xFF2ecc71),
          const Color(0xFF2ecc71).withOpacity(0.8),
          const Color(0xFF2ecc71).withOpacity(0.4),
        ])),
        child: pageLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Platform.isIOS
                                ? Icons.arrow_back_ios
                                : Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Forget Password",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Welcome Back",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      FadeInUp(
                                        duration: Duration(
                                            milliseconds: durationTime),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color.fromRGBO(
                                                      225, 95, 27, .3),
                                                  blurRadius: 20,
                                                  offset: Offset(0, 10))
                                            ],
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey
                                                                .shade200))),
                                                child: TextFormField(
                                                  controller: emailController,
                                                  readOnly: otpField,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter email';
                                                    } else if (!RegExp(
                                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(value)) {
                                                      return 'Invalid email';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "Get Verification Code On Email",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                              if (otpField == true) ...[
                                                //otp
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200))),
                                                  child: TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter otp';
                                                      }
                                                      return null;
                                                    },
                                                    controller: otpController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: "Enter Otp",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                                //password
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200))),
                                                  child: TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter password';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        passwordController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Enter Password",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                                //resetpassword
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200))),
                                                  child: TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter reset password';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        resetPasswordController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Enter Reset Password",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                      FadeInUp(
                                        duration: Duration(
                                            milliseconds: durationTime),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(),
                                            InkWell(
                                              onTap: () {
                                                clearform();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: const Text("Clear Form"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      FadeInUp(
                                        duration: Duration(
                                            milliseconds: durationTime),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                clearform();
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "If you already have account?"),
                                                    Text(
                                                      " Login",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .kbuttonColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      FadeInUp(
                                        duration: Duration(
                                            milliseconds: durationTime),
                                        child: SizedBox(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (otpField == true) {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  forgetPassword(
                                                    email: emailController.text,
                                                    otp: otpController.text,
                                                    password:
                                                        passwordController.text,
                                                    repassword:
                                                        resetPasswordController
                                                            .text,
                                                  );
                                                }
                                              } else {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (!loading) {
                                                    gererateOtp(
                                                      emailController.text,
                                                    );
                                                  }
                                                }
                                              }
                                            },
                                            child: Center(
                                              child: loading
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : Text(
                                                      otpField
                                                          ? "Forget Password"
                                                          : "Get Verification Code",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
