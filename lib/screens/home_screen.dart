import 'package:aakriti_inteligence/models/login_data_model.dart';
import 'package:aakriti_inteligence/models/products_model.dart';
import 'package:aakriti_inteligence/screens/chart_screen.dart';
import 'package:aakriti_inteligence/screens/drawer_screen.dart';
import 'package:aakriti_inteligence/utils/api_service.dart';
import 'package:aakriti_inteligence/utils/app_string.dart';
import 'package:aakriti_inteligence/utils/colors.dart';
import 'package:aakriti_inteligence/utils/my_utitlity.dart';
import 'package:aakriti_inteligence/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:aakriti_inteligence/screens/login_screen.dart';
import 'package:aakriti_inteligence/widgets/custom_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Utility utility = Utility();
  List<ProductData> mobileItems = [];
  bool loading = true;
  LoginDataModel? profileData;
  String username = AppStrings.appName;

  setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  productsData() async {
    setLoading(true);
    try {
      final response = await ApiService.getApi(
        endpoint: AppStrings.productsApi,
      );
      debugPrint('productsData Res: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        final productListModel =
            productListModelFromJson(response.body.toString());
        mobileItems = productListModel.data ?? [];
        // Utility.showCustomSnackbar(
        //     context, productListModel.message ?? "Success", true);
      } else {
        debugPrint("Error = ${response.statusCode} message = ${response.body}");
      }
    } catch (e) {
      debugPrint('Exception Caught: $e');
    } finally {
      setLoading(false);
    }
  }

  getProfileData() async {
    profileData = await utility.getUserProfileData();
    if (profileData != null) {
      var firstName = profileData?.user!.fname ?? "";
      var lastName = profileData?.user!.lname ?? "";
      username = "$firstName $lastName";
    } else {
      username = AppStrings.appName;
    }
    setState(() {});
  }

  void showTransparentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Coming soon',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Stay tuned for exciting updates!',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    productsData();
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const DrawerScreen(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: globalPadding),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hello welcome",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: globalNormalTextSize14,
                              ),
                            ),
                            Text(
                              username.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: globalNormalTextSize16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: AssetImage(
                            'images/logo.png',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                hintText: 'Search items...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black54),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: AppColors.kprimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              _key.currentState!.openDrawer();
                            },
                            child: const Icon(
                              Icons.menu,
                              color: AppColors.kwhiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 50),
                        itemCount: mobileItems.length,
                        itemBuilder: (context, index) {
                          final ProductData mobileItem = mobileItems[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      child: Image(
                                        image: NetworkImage(
                                          "${AppStrings.baseUrl}${mobileItem.img}",
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mobileItem.name ?? "",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Rs ${mobileItem.sp ?? "0"} /",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                " ${mobileItem.mrp ?? "0"}",
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 16,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .wavy),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomElevatedButton(
                                                backgroundColor:
                                                    AppColors.kprimaryColor,
                                                child: const Text('View Chart'),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MycartScreen(),
                                                    ),
                                                  );
                                                },
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              CustomElevatedButton(
                                                backgroundColor:
                                                    AppColors.kbuttonColor,
                                                child: const Text('Buy Now'),
                                                onPressed: () async {
                                                  if (await Utility
                                                          .getLogin() !=
                                                      "") {
                                                    if (context.mounted) {
                                                      showTransparentDialog(
                                                          context);
                                                    }
                                                  } else {
                                                    if (context.mounted) {
                                                      var res =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LoginScreen(),
                                                        ),
                                                      );
                                                      if (res == true) {
                                                        productsData();
                                                      }
                                                    }
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
