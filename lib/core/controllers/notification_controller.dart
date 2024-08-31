import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:move_to_earn/core/controllers/app_controller.dart';

class NotificationController extends GetxController {
  AppController appController = Get.find();

  int unread = 0;
  List<dynamic> notificationList = [];
  StreamSubscription? stream;

  List<dynamic> all = [];

  @override
  void dispose() async {
    super.dispose();
    await cancelStream();
  }

  listenNotification() {
    if (appController.user.value.id != null) {
      try {
        print(appController.user.value.id.toString());
        FirebaseFirestore.instance
            .collection("user_data")
            .doc(appController.user.value.id.toString())
            .snapshots()
            .listen((DocumentSnapshot event) {
          if (event.data() != null) {
            print("notification listen");
            if (event['notification_unread'] != null) {
              if (event['notification_unread'] < 0) {
                event.reference.update({"notification_unread": 0});
              }
              unread = event['notification_unread'];
            } else {
              unread = 0;
            }

            update();
          }
        });
      } catch (e) {
        e.printError();
      }
    }
  }

  getAll() {
    try {
      FirebaseFirestore.instance
          .collection("notification")
          .where("public", isEqualTo: true)
          .orderBy("created_at", descending: true)
          .get()
          .then((QuerySnapshot event) {
        all = event.docs.map((doc) {
          dynamic tmp = doc.data();
          tmp['id'] = doc.id;
          return tmp;
        }).toList();

        update();
      });
    } catch (e) {
      e.printError();
    }
  }

  getNotifications() async {
    if (appController.user.value.id != null) {
      try {
        stream = FirebaseFirestore.instance
            .collection("user_data")
            .doc(appController.user.value.id.toString())
            .collection("notification")
            .orderBy("created_at", descending: true)
            .limit(150)
            .snapshots()
            .listen((event) {
          notificationList = event.docs.map((doc) {
            var tmp = doc.data();
            tmp['id'] = doc.id;
            return tmp;
          }).toList();
          update();
        });
      } catch (e) {
        e.printError();
      }
    }
  }

  cancelStream() {
    if (stream != null) {
      stream!.cancel();
    }
  }

  readNotification(dynamic item) {
    if (appController.user.value.id != null &&
            item != null &&
            item['id'] != null &&
            item['read_it'] == null ||
        (item['read_it'] != null && item['read_it'] == false)) {
      try {
        FirebaseFirestore.instance
            .collection("user_data")
            .doc(appController.user.value.id.toString())
            .collection("notification")
            .doc(item['id'])
            .update({"read_it": true});
        FirebaseFirestore.instance
            .collection("user_data")
            .doc(appController.user.value.id.toString())
            .get()
            .then((value) {
          if (value.data() != null &&
              value.data()!['notification_unread'] != null &&
              value.data()!['notification_unread'] > 0) {
            value.reference
                .update({"notification_unread": FieldValue.increment(-1)});
          }
        });
      } catch (e) {
        e.printError();
      }
    }
  }

  deleteNotification(dynamic item) {
    if (appController.user.value.id != null &&
        item != null &&
        item['id'] != null) {
      try {
        FirebaseFirestore.instance
            .collection("user_data")
            .doc(appController.user.value.id.toString())
            .collection("notification")
            .doc(item["id"])
            .delete();
        getNotifications();
        update();
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> clearNotifications() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("user_data")
        .doc(appController.user.value.id.toString())
        .collection("notification")
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
      var data = await doc.data();
      if (data != null) {
        readNotification(data);
      }

      await doc.reference.delete();
    }

    getNotifications();
    update();
  }

  readAllNotification() async {
    CollectionReference notificationsRef = FirebaseFirestore.instance
        .collection("user_data")
        .doc(appController.user.value.id.toString())
        .collection("notification");

    // Query for all documents in the notification subcollection
    QuerySnapshot querySnapshot = await notificationsRef.get();

    // Process each document in the query result
    querySnapshot.docs.forEach((doc) {
      // Access the ID of each document
      String notificationId = doc.id;

      // Access the data of each document
      var notificationData = doc.data();

      // Print or process the notification ID and data as needed
      print("Notification ID: $notificationId, Data: $notificationData");
      FirebaseFirestore.instance
          .collection("user_data")
          .doc(appController.user.value.id.toString())
          .collection("notification")
          .doc(notificationId)
          .update({"read_it": true});
      FirebaseFirestore.instance
          .collection("user_data")
          .doc(appController.user.value.id.toString())
          .get()
          .then((value) {
        if (value.data() != null &&
            value.data()!['notification_unread'] != null &&
            value.data()!['notification_unread'] > 0) {
          value.reference
              .update({"notification_unread": FieldValue.increment(-1)});
        }
      });
    });

    print("All notifications read successfully.");

    getNotifications();
    update();
  }
}
