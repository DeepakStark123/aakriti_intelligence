import 'package:aakriti_inteligence/models/about_us_model.dart';
import 'package:aakriti_inteligence/utils/api_service.dart';
import 'package:aakriti_inteligence/utils/app_string.dart';
import 'package:aakriti_inteligence/utils/my_utitlity.dart';
import 'package:aakriti_inteligence/utils/constant.dart';
import 'package:aakriti_inteligence/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  Utility utility = Utility();
  bool loading = true;
  String htmlData = '''<p>No data found </p>''';

  setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  privacyPolicyData() async {
    setLoading(true);
    try {
      final response = await ApiService.getApi(
        endpoint: AppStrings.aboutUsApi,
      );
      debugPrint(
          'privacyPolicyData Res: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        final res = aboutUsModelFromJson(response.body.toString());
        if (res.status == 200) {
          if (context.mounted) {
            htmlData = res.data!.description ?? """<p>No Data Found</p>""";
          }
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

  @override
  void initState() {
    privacyPolicyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          text: "About-Us",
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: globalPadding,
                  vertical: 2,
                ),
                child: HtmlWidget(
                  htmlData,
                  renderMode: RenderMode.column,
                  textStyle: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
    );
  }
}
