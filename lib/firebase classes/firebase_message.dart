import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/from_github.dart';
import  'package:firebase_app/main.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  @override
  void initState() {
    void initNotifications() async {

      final pushNotificationService =
      PushNotificationService(_firebaseMessaging);
      pushNotificationService.initialise();

    }
    super.initState();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "You are Logged in succesfully",
              style: TextStyle(color: Colors.lightBlue, fontSize: 32),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "${widget.user.phoneNumber}",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  class PushNotificationService {
    final FirebaseMessaging _fcm;

    PushNotificationService(this._fcm);

    Future initialise() async {
      if (Platform.isIOS) {
        NotificationSettings settings = await _fcm.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
        print('User granted permission: ${settings.authorizationStatus}');
      }

      // If you want to test the push notification locally,
      // you need to get the token and input to the Firebase console
      // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
      String? token = await _fcm.getToken();
      print("FirebaseMessaging token: $token");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification!;
        print("notification is ${notification.body}");
        print("notification is ${notification.android?.imageUrl}");
        Notifications notify = Notifications(
            body: notification.body,
            title: notification.title,
            imageUrl: notification.android?.imageUrl);
        NotificationsRepo.getNotification(notify);
        showSimpleNotification(
            Container(
                child: Text("message ${message.notification?.body.toString()}")),
            position: NotificationPosition.top,
            // duration: const Duration(seconds: 5),
            slideDismissDirection: DismissDirection.horizontal,
            background: AppColors.primaryColor);
        // showNotification(notification);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        showSimpleNotification(
          Container(
              child: Text("message ${message.notification?.body.toString()}")),
          position: NotificationPosition.top,
        );
        print("onMessageOpenedApp: $message");
      });
    }
  }
Future verfiyNumber(String number,
  void Function(String, int?) userVerIdFun, BuildContext context) async {
  try {
  number = "+967${number}";
  print("sending message to $number");
  await FirebaseAuth.instance
      .verifyPhoneNumber(
  phoneNumber: number,
  verificationCompleted: (PhoneAuthCredential credential) {
  FirebaseAuth auth = FirebaseAuth.instance;
  auth.signInWithCredential(credential).catchError((e) {
  return {"success": false, "data": e};
  });
  },
  verificationFailed: (FirebaseException e) async {
  print("here is an issue getting messsages done");
  FailedDailog.showfailureDailog(
  context: context,
  pop: false,
  error:
  'لم نستطع إرسال رسالة التأكيد لك الرجاء اعادة المحاولة لاحقا \n $e');
  throw {"success": false, "data": e};

  },
  codeAutoRetrievalTimeout: (String verificationId) async {
// if (await SharedPrefHelper.checkKey('token'))
// showWhiteToste(msg: 'الم يصلك رمز؟', isStatus: 1);
  },
  codeSent: userVerIdFun,
  )
      .catchError((e) {
  print("there is an iisssuueee gettingthe messages ");
  });
  return {"success": true, "data": "تم ارسال الرسالة بنجاح"};
  } catch (e) {

  print("error completing verefication request");
  return e;
  }
  }
