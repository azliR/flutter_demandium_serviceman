import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:demandium_serviceman/core/core_export.dart';


class HtmlViewerScreen extends StatefulWidget {
  final HtmlType? htmlType;
  const HtmlViewerScreen({super.key, @required this.htmlType});

  @override
  State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
}

class _HtmlViewerScreenState extends State<HtmlViewerScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title:  widget.htmlType == HtmlType.termsAndCondition ? 'terms_conditions'.tr
            : widget.htmlType == HtmlType.aboutUs ? 'about_us'.tr
            : widget.htmlType == HtmlType.privacyPolicy ? 'privacy_policy'.tr
            : widget.htmlType == HtmlType.refundPolicy ? 'refund_policy'.tr
            : widget.htmlType == HtmlType.cancellationPolicy ? 'cancellation_policy'.tr
            : 'no_data_found'.tr,
      ),

      body: GetBuilder<HtmlViewController>(
        initState: (state){
          Get.find<HtmlViewController>().getPagesContent();
        },
        builder: (htmlViewController){
          String? data;
          if(htmlViewController.pagesContent != null){
            data = widget.htmlType == HtmlType.termsAndCondition ? htmlViewController.pagesContent!.termsAndConditions!.liveValues!
                : widget.htmlType == HtmlType.aboutUs ? htmlViewController.pagesContent!.aboutUs!.liveValues!
                : widget.htmlType == HtmlType.privacyPolicy ? htmlViewController.pagesContent!.privacyPolicy!.liveValues!
                : widget.htmlType == HtmlType.refundPolicy ? htmlViewController.pagesContent!.refundPolicy!.liveValues!
                : widget.htmlType == HtmlType.cancellationPolicy ? htmlViewController.pagesContent!.cancellationPolicy!.liveValues!
                : null;

            if(data != null) {
              data = data.replaceAll('href=', 'target="_blank" href=');
              return Center(
                child: Container(
                  width: Dimensions.webMaxWidth,
                  height: MediaQuery.of(context).size.height,
                  color: GetPlatform.isWeb ? Colors.white : Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                  child:SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    physics: const BouncingScrollPhysics(),
                    child: HtmlWidget(
                      data,
                      textStyle: ubuntuRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              );
            }else{
              return const SizedBox();
            }
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}