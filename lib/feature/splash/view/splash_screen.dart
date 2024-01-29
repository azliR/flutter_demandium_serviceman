import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({super.key, @required this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult>? _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    _route();
  }
  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged!.cancel();
  }
  void _route() {
      Get.find<SplashController>().getConfigData().then((isSuccess) {
        if(isSuccess){
          Timer(const Duration(seconds: 1), () async {
            bool isAvailableUpdate =false;

            String minimumVersion = "1.1.0";
            double? minimumBaseVersion =1.0;
            double? minimumLastVersion =0;

            String appVersion = AppConstants.appVersion;
            double? baseVersion = double.tryParse(appVersion.substring(0,3));

            double lastVersion=0;
            if(appVersion.length>3){
              lastVersion = double.tryParse(appVersion.substring(4,5))!;
            }
            if(GetPlatform.isAndroid && Get.find<SplashController>().configModel.content!.minimumVersion!=null) {

              minimumVersion = Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForAndroid!.toString();
              if(minimumVersion.length==1){
                minimumVersion = "$minimumVersion.0";
              }
              if(minimumVersion.length==3){
                minimumVersion = "$minimumVersion.0";
              }
              minimumBaseVersion = double.tryParse(minimumVersion.substring(0,3));
              minimumLastVersion = double.tryParse(minimumVersion.substring(4,5));

              if(minimumBaseVersion!>baseVersion!){
                isAvailableUpdate= true;
              }else if(minimumBaseVersion==baseVersion){
                if(minimumLastVersion!>lastVersion){
                  isAvailableUpdate = true;
                }else{
                  isAvailableUpdate = false;
                }
              }else{
                isAvailableUpdate = false;
              }
            }
            else if(GetPlatform.isIOS && Get.find<SplashController>().configModel.content!.minimumVersion!=null) {
              minimumVersion = Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForIos!;
              if(minimumVersion.length==1){
                minimumVersion = "$minimumVersion.0";
              }
              if(minimumVersion.length==3){
                minimumVersion = "$minimumVersion.0";
              }
              minimumBaseVersion = double.tryParse(minimumVersion.substring(0,3));
              if(minimumVersion.length>3){
                minimumLastVersion = double.tryParse(minimumVersion.substring(4,5));
              }
              if(minimumBaseVersion!>baseVersion!){
                isAvailableUpdate= true;
              }else if(minimumBaseVersion==baseVersion){
                if(minimumLastVersion!>lastVersion){
                  isAvailableUpdate = true;
                }else{
                  isAvailableUpdate = false;
                }
              }else{
                isAvailableUpdate = false;
              }
            }
            if(isAvailableUpdate) {
              Get.offNamed(RouteHelper.getUpdateRoute(isAvailableUpdate));
            }else{
              PriceConverter.getCurrency(Get.context!);
              if(widget.body != null) {

                String notificationType = widget.body?.type??"";

                switch(notificationType) {

                  case "chatting": {
                    Get.offNamed(RouteHelper.getInboxScreenRoute(fromNotification: "fromNotification"));
                  } break;

                  case "booking": {
                    if( widget.body!.bookingId!=null&& widget.body!.bookingId!=""){
                      Get.offAllNamed(RouteHelper.getBookingDetailsRoute( widget.body!.bookingId!,"", 'fromNotification'));
                    }else{
                      Get.offNamed(RouteHelper.getInitialRoute());
                    }
                  } break;

                  case "privacy_policy": {
                    Get.toNamed(RouteHelper.getHtmlRoute("privacy-policy"));
                  } break;

                  case "terms_and_conditions": {
                    Get.toNamed(RouteHelper.getHtmlRoute("terms-and-condition",));
                  } break;

                  default: {
                    Get.toNamed(RouteHelper.getNotificationRoute());
                  } break;
                }
              }

              else{
                PriceConverter.getCurrency(Get.context!);
                if (Get.find<AuthController>().isLoggedIn()) {
                  Get.find<ProfileController>().getUserInfo();
                  Get.find<BookingHistoryController>().getBookingHistory('all',1);

                  if( Get.find<SplashController>().showIntro()!){
                    Get.to(()=> const ChooseLanguageScreen());
                  }else{
                    Get.offNamed(RouteHelper.getInitialRoute());
                  }
                }else{
                  if( Get.find<SplashController>().showIntro()!){
                    Get.to(()=> const ChooseLanguageScreen());
                  }else{
                    Get.offNamed(RouteHelper.getSignInRoute("LogIn"));
                  }
                }
              }
            }
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Center(
          child: splashController.hasConnection ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Get.isDarkMode?Images.demandiumDarkLogo: Images.demandiumLogo, width: 180),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Text(
                AppConstants.appUser.tr,
                style: ubuntuBold.copyWith(
                  fontSize: 20,
                  color: Get.isDarkMode?Colors.white70:Theme.of(context).primaryColor,
                ),
              )
            ],
          ) : NoInternetScreen(child: SplashScreen(body: widget.body)),
        );
      }),
    );
  }
}
