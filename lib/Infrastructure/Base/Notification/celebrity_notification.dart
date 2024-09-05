// import 'dart:developer';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:celebrity_quiz/Infrastructure/Base/SharedPrefence/shared_pref.dart';
// import 'package:celebrity_quiz/Infrastructure/Commons/Constant/fiebase_constant.dart';
// import 'package:celebrity_quiz/Infrastructure/Commons/Constant/storage_constants.dart';
// import 'package:celebrity_quiz/UI/SplashSection/Splash_screen/splash_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CelebrityNotification {
//   getNotificationReq(context) async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     updateToken();
//     FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
//
//         log("device Token splash :  $fcmToken");});
//     final intercomToken = await FirebaseMessaging.instance.getToken();
//     if (intercomToken != null) {
//       messaging.getInitialMessage().then((RemoteMessage? message) {
//         if (message != null) {
//           firebaseMessagingOnMessageHandler(message,context: context);
//         }
//       });
//
//       messaging.setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//
//       NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//       log('User granted permission: ${settings.authorizationStatus}');
//       FirebaseMessaging.onMessageOpenedApp.listen(
//         firebaseMessagingOnMessageHandler,
//       );
//       FirebaseMessaging.onMessage.listen(
//         _firebaseMessagingOnMessageHandlerOne,
//       );
//       FirebaseMessaging.onBackgroundMessage(
//         firebaseMessagingOnMessageHandler,
//       );
//     }else{
//       log("intercomToken is null");
//     }
//
//
//   }
//
//   /* Future<bool> displayNotificationRationale() async {
//     bool userAuthorized = false;
//     BuildContext? context = MyApp.navigatorKey.currentContext;
//     await showDialog(
//         context: context!,
//         builder: (BuildContext ctx) {
//           return AlertDialog(
//             title: Text('Get Notified!',
//                 style: Theme.of(context).textTheme.titleLarge),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Image.asset(
//                         'assets/animated-bell.gif',
//                         height: MediaQuery.of(context).size.height * 0.3,
//                         fit: BoxFit.fitWidth,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                     'Allow Awesome Notifications to send you beautiful notifications!'),
//               ],
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(ctx).pop();
//                   },
//                   child: Text(
//                     'Deny',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.red),
//                   )),
//               TextButton(
//                   onPressed: () async {
//                     userAuthorized = true;
//                     Navigator.of(ctx).pop();
//                   },
//                   child: Text(
//                     'Allow',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.deepPurple),
//                   )),
//             ],
//           );
//         });
//     return userAuthorized &&
//         await AwesomeNotifications().requestPermissionToSendNotifications();
//   }*/
//
//   Future<void> _firebaseMessagingOnMessageHandlerOne(
//       RemoteMessage message,
//       ) async {
//     await Firebase.initializeApp();
//     ReceivedAction? initialAction;
//
//     AwesomeNotifications().initialize(
//         null, //'resource://drawable/res_app_icon',//
//         [
//           NotificationChannel(
//               channelKey: 'alerts',
//               channelName: 'Alerts',
//               channelDescription: 'Notification tests as alerts',
//               playSound: true,
//               onlyAlertOnce: true,
//               // groupAlertBehavior: GroupAlertBehavior.Children,
//               importance: NotificationImportance.High,
//               defaultPrivacy: NotificationPrivacy.Private,
//               defaultColor: Colors.deepPurple,
//               ledColor: Colors.deepPurple)
//         ],
//         debug: true);
//
//     //if (Platform.isIOS) return;
//
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     initialAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: false);
//
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     // if (!isAllowed) isAllowed = await displayNotificationRationale();
//     if (!isAllowed) return;
//     // If `onMessage` is triggered with a notification, construct our own
//     // local notification to show to users using the created channel.
//     if (notification != null && android != null) {
//       await AwesomeNotifications().createNotification(
//           content: NotificationContent(
//               id: notification.hashCode,
//               channelKey: 'alerts',
//               title: notification.title,
//               body: notification.body,
//               bigPicture: notification.android?.imageUrl,
//               largeIcon: notification.android?.imageUrl,
//               notificationLayout: NotificationLayout.BigPicture,
//               payload: {'notificationId': '1234567890'}),
//
//           actionButtons: [
//             NotificationActionButton(key: 'REDIRECT', label: 'Watch'),
//             NotificationActionButton(
//                 key: 'DISMISS',
//                 label: 'Dismiss',
//                 actionType: ActionType.DismissAction,
//                 isDangerousOption: true)
//           ]);
//     } else {
//       notification.printError();
//     }
//
//     log("Handling a foreground message");
//   }
//
//   void updateToken() async {
//     FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
//       try {
//         log("device Token splash :  $fcmToken");
//         var fcmCollection = FirebaseFirestore.instance
//             .collection('users')
//             .doc(userDeviceID)
//             .collection(FirebaseConstant.userDeviceToken);
//         await fcmCollection.get().then(
//               (value) async {
//             if (value.docs.isNotEmpty) {
//               for (var element in value.docs) {
//                 if (element.id ==
//                     await SharedPref().getStringValuesSF(StorageConstants.userDeviceToken)) {
//                   fcmCollection.doc(element.id).delete();
//                 }
//               }
//             }
//           },
//         );
//
//         await SharedPref().addStringToSF(StorageConstants.userDeviceToken, fcmToken);
//         //Auth().storeUserFirebaseToken(fcmToken);
//       } catch (e) {
//         log("error find when user update token");
//       }
//     }).onError((err) {
//       log("Error in getting token");
//     });
//   }
// }
//
// Future<void> firebaseMessagingOnMessageHandler(
//     RemoteMessage message,
//     {context}) async {
//   await Firebase.initializeApp();
//
//   log('A new onMessageOpenedApp event was published!');
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//
//   if (notification != null && android != null) {
//     showDialog(
//         context: context!,
//         builder: (_) {
//           return AlertDialog(
//             title: Text(notification.title!),
//             content: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(notification.body!),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//   log("Handling a background message");
// }