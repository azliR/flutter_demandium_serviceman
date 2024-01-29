import 'dart:convert';
import 'dart:math';
import 'package:demandium_serviceman/core/core_export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class NotificationHelper {
  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onDidReceiveNotificationResponse: (payload) async {
      try{
        PriceConverter.getCurrency(Get.context!);
        if(payload.payload!=null && payload.payload!=''){
          NotificationBody notificationBody = NotificationBody.fromJson(jsonDecode(payload.payload!));
          if(notificationBody.type=="chatting"){

            if(Get.currentRoute.contains(RouteHelper.chatScreen)){
              Get.back();
              Get.back();
            } else if(Get.currentRoute.contains(RouteHelper.chatInbox)){
              Get.back();
            }

            Get.toNamed(RouteHelper.getChatScreenRoute(
              notificationBody.channelId??"",
              notificationBody.userName??"",
              notificationBody.userProfileImage??"",
              notificationBody.userPhone??"",
              fromNotification: "fromNotification",
            ));
          }
          else if(notificationBody.type=='booking' && notificationBody.bookingId!=null && notificationBody.bookingId!=''){
            Get.toNamed(RouteHelper.getBookingDetailsRoute(notificationBody.bookingId.toString(),'','fromNotification'));
          } else if(notificationBody.type=='privacy_policy' && notificationBody.title!=null && notificationBody.title!=''){
            Get.toNamed(RouteHelper.getHtmlRoute("privacy-policy"));
          }else if(notificationBody.type=='terms_and_conditions' && notificationBody.title!=null && notificationBody.title!=''){
            Get.toNamed(RouteHelper.getHtmlRoute("terms-and-condition"));
          }else{
            Get.toNamed(RouteHelper.getNotificationRoute());
          }
        }
      }catch (e) {
        if (kDebugMode) {
          print("");
        }
      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      }
      if(message.data['type']=='chatting'){

        if(Get.currentRoute.contains(RouteHelper.chatScreen) && (message.data['channel_id']!="" && message.data['channel_id']!=null)
            && (message.data['channel_id'] == Get.find<ConversationController>().channelId)){
          Get.find<ConversationController>().getConversation(message.data['channel_id'], 1);
        } else{
          NotificationHelper.showNotification(message,flutterLocalNotificationsPlugin,false);
        }
      } else if(message.data['type']=='general'){
        Get.find<NotificationController>().getNotifications(1);
      }
      else{
        NotificationHelper.showNotification(message,flutterLocalNotificationsPlugin,false);
      }

    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      try{
        PriceConverter.getCurrency(Get.context!);
        if(message!=null && message.data.isNotEmpty) {
          NotificationBody notificationBody = convertNotification(message.data);
          if(notificationBody.type=="chatting" && notificationBody.channelId!=""){

            if(Get.currentRoute.contains(RouteHelper.chatScreen)){
              Get.back();
              Get.back();
            } else if(Get.currentRoute.contains(RouteHelper.chatInbox)){
              Get.back();
            }

            Get.toNamed(RouteHelper.getChatScreenRoute(
              notificationBody.channelId??"",
              notificationBody.userName??"",
              notificationBody.userProfileImage??"",
              notificationBody.userPhone??"",
              fromNotification: "fromNotification",
            ));
          }

          else if(notificationBody.type=='booking' && notificationBody.bookingId!=null && notificationBody.bookingId!=''){
            Get.toNamed(RouteHelper.getBookingDetailsRoute(notificationBody.bookingId.toString(),'','fromNotification'));
          }
          else if(notificationBody.type=='privacy_policy' && notificationBody.title!=null && notificationBody.title!=''){
            Get.toNamed(RouteHelper.getHtmlRoute("privacy-policy"));
          }
          else if(notificationBody.type=='terms_and_conditions' && notificationBody.title!=null && notificationBody.title!=''){
            Get.toNamed(RouteHelper.getHtmlRoute("terms-and-condition"));
          }else{
            Get.toNamed(RouteHelper.getNotificationRoute());
          }
        }
      }catch (e) {
        if (kDebugMode) {
          print("");
        }
      }
    });
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    if(!GetPlatform.isIOS) {
      String? title;
      String? body;
      String? orderID;
      String? image;
      String playLoad = jsonEncode(message.data);

      if (kDebugMode) {
        print(orderID);
      }
      if(data) {
        title = message.data['title']?.replaceAll('_', ' ').toString().capitalize;
        body = message.data['body'];
        orderID = message.data['order_id'];
        image = (message.data['image'] != null && message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http') ? message.data['image']
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}' : null;
      }else {
        title = message.notification!.title;
        body = message.notification!.body;
        orderID = message.notification!.titleLocKey;
        if(GetPlatform.isAndroid) {
          image = (message.notification!.android!.imageUrl != null && message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl!.startsWith('http') ? message.notification!.android!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.android!.imageUrl}' : null;
        }else if(GetPlatform.isIOS) {
          image = (message.notification!.apple!.imageUrl != null && message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl!.startsWith('http') ? message.notification!.apple!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.apple!.imageUrl}' : null;
        }
      }

      if(image != null && image.isNotEmpty) {
        try{
          await showBigPictureNotificationHiddenLargeIcon(title!, body!, playLoad, image, fln);
        }catch(e) {
          await showBigTextNotification(title!, body!, playLoad, fln);
        }
      }else {
        await showBigTextNotification(title!, body!,playLoad, fln);
      }
    }
  }

  static Future<void> showTextNotification(String title, String body, String playLoad, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'ondemandservice', 'ondemandservice', playSound: true,
      importance: Importance.max, priority: Priority.max, sound: RawResourceAndroidNotificationSound('notification'),
    );
    int randomNumber = Random().nextInt(100);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(randomNumber, title, body, platformChannelSpecifics, payload: playLoad);
  }

  static Future<void> showBigTextNotification(String title, String body, String playLoad, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, htmlFormatBigText: true,
      contentTitle: title, htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'ondemandservice', 'ondemandservice', importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.max, playSound: true,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    int randomNumber = Random().nextInt(100);
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(randomNumber, title, body, platformChannelSpecifics, payload: playLoad);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title, String body, String playLoad, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'ondemandservice', 'ondemandservice',
      largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max, playSound: true,
      styleInformation: bigPictureStyleInformation, importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    int randomNumber = Random().nextInt(100);
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(randomNumber, title, body, platformChannelSpecifics, payload: playLoad);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationBody convertNotification(Map<String, dynamic> data){
    return NotificationBody.fromJson(data);
  }

}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  }
}