import 'package:aakriti_inteligence/models/login_data_model.dart';
import 'package:aakriti_inteligence/models/products_model.dart';
import 'package:aakriti_inteligence/screens/chart_screen.dart';
import 'package:aakriti_inteligence/screens/drawer_screen.dart';
import 'package:aakriti_inteligence/screens/trade_form.dart';
import 'package:aakriti_inteligence/utils/api_service.dart';
import 'package:aakriti_inteligence/utils/app_string.dart';
import 'package:aakriti_inteligence/utils/colors.dart';
import 'package:aakriti_inteligence/utils/my_utitlity.dart';
import 'package:aakriti_inteligence/utils/constant.dart';
import 'package:flutter/material.dart';
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
  List<ProductData> totalItem = [];
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
      mobileItems = [];
      totalItem = [];
      if (response.statusCode == 200) {
        final productListModel =
            productListModelFromJson(response.body.toString());
        mobileItems = productListModel.data ?? [];
        totalItem.addAll(mobileItems);
      } else {
        debugPrint("Error = ${response.statusCode} message = ${response.body}");
      }
    } catch (e) {
      debugPrint('Exception Caught: $e');
    } finally {
      setLoading(false);
    }
  }

  void filterSearchResults(String query) {
    List<ProductData> searchResults = [];
    if (query.isNotEmpty) {
      for (var item in mobileItems) {
        if (item.name.toString().toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(item);
        }
      }
    } else {
      searchResults.addAll(totalItem);
    }
    setState(() {
      mobileItems.clear();
      mobileItems.addAll(searchResults);
    });
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

  searchItem() {}

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
      drawer: CustomNavigationDrawer(
        isLogin: profileData != null ? true : false,
        userProfileData: profileData,
      ),
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
                              onChanged: (value) {
                                filterSearchResults(value);
                              },
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
                            color: AppColors.kbuttonColor,
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
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 0),
                                )
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "${AppStrings.baseUrl}${mobileItem.img}",
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
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
                                          style: const TextStyle(fontSize: 20),
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
                                                      TextDecorationStyle.wavy),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: CustomElevatedButton(
                                                backgroundColor:
                                                    AppColors.kprimaryColor,
                                                child: const Text('View'),
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
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Expanded(
                                              child: CustomElevatedButton(
                                                backgroundColor:
                                                    AppColors.kbuttonColor,
                                                child: const Text('Buy'),
                                                onPressed: () {
                                                  if (context.mounted) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const TradeScreen(),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Expanded(
                                              child: CustomElevatedButton(
                                                backgroundColor:
                                                    AppColors.kaccentColor,
                                                child: const Text('Sell'),
                                                onPressed: () {
                                                  if (context.mounted) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const TradeScreen(),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
