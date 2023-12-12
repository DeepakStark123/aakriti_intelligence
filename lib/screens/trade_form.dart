import 'dart:io';
import 'package:aakriti_inteligence/models/login_data_model.dart';
import 'package:aakriti_inteligence/utils/my_utitlity.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  bool pageLoading = true;
  bool isBtnClicked = false;
  Utility utility = Utility();
  LoginDataModel? profileData;
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  setLoading(bool value) {
    setState(() {
      pageLoading = value;
    });
  }

  // getInitilaData() async {
  //   setLoading(true);
  //   try {
  //     final response = await ApiService.getApi(
  //       endpoint: AppStrings.privacyPolicyApi,
  //     );
  //     debugPrint(
  //         'privacyPolicyData Res: ${response.statusCode} ${response.body}');
  //     if (response.statusCode == 200) {
  //       final res = privacyPolicyModelFromJson(response.body.toString());
  //       if (res.status == 200) {
  //         if (context.mounted) {
  //           htmlData = res.data!.description ?? """<p>No Data Found</p>""";
  //         }
  //       } else {
  //         if (context.mounted) {
  //           Utility.showCustomSnackbar(context, res.message ?? "Fail", false);
  //         }
  //       }
  //     } else {
  //       debugPrint("Error = ${response.statusCode} message = ${response.body}");
  //     }
  //   } catch (e) {
  //     debugPrint('Exception Caught: $e');
  //   } finally {
  //     setLoading(false);
  //   }
  // }

  getUserDaata() async {
    setLoading(true);
    try {
      profileData = await utility.getUserProfileData();
      if (profileData != null) {
        firstNameController.text = profileData?.user!.fname ?? "";
        lastNameController.text = profileData?.user!.lname ?? "";
        emailController.text = profileData?.user!.email ?? "";
        phoneNoController.text = profileData?.user!.phone ?? "";
      }
    } catch (e) {
      debugPrint("Exception Caught = $e");
    } finally {
      setLoading(false);
    }
  }

  @override
  void initState() {
    getUserDaata();
    super.initState();
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
                children: <Widget>[
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
                          "Trade Screen",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "best item here!",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 1000),
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
                                              ]),
                                          child: Column(
                                            children: <Widget>[
                                              //firstname
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey
                                                                .shade200))),
                                                child: TextFormField(
                                                  controller:
                                                      firstNameController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Enter first name",
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          border:
                                                              InputBorder.none),
                                                ),
                                              ),
                                              //lastname
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey
                                                                .shade200))),
                                                child: TextFormField(
                                                  controller:
                                                      lastNameController,
                                                  obscureText: true,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Enter last name",
                                                          hintStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                          border:
                                                              InputBorder.none),
                                                ),
                                              ),
                                              //email
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
                                                  obscureText: true,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter some text';
                                                    } else if (!RegExp(
                                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(value)) {
                                                      return 'Invalid email';
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Enter emial id",
                                                          hintStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                          border:
                                                              InputBorder.none),
                                                ),
                                              ),
                                              //phone-number
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey
                                                                .shade200))),
                                                child: TextFormField(
                                                  controller: phoneNoController,
                                                  obscureText: true,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Enter phone number",
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          border:
                                                              InputBorder.none),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      FadeInUp(
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        child: SizedBox(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                debugPrint("form valid");
                                              }
                                            },
                                            child: const Center(
                                              child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
