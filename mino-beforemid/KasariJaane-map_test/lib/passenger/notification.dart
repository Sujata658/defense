import 'package:flutter/material.dart';
import 'package:kasarijaane/model/notification_model.dart';
import 'package:kasarijaane/api_service.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<NotificationModel>? notificationModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    notificationModel = await (NotificationService().getNotifications());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: notificationModel == null || notificationModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: notificationModel!.length,
              itemBuilder: (BuildContext context, int index) {
                DateTime dateObj = notificationModel![index].createdAt;
                DateTime now = DateTime.now();
                int timeDiff = now.difference(dateObj).inHours;
                int timeDiffInMin = now.difference(dateObj).inMinutes;
                if (timeDiff == 0) {
                  timeDiff = timeDiffInMin;
                }

                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.notifications),
                  ),
                  title: Text(notificationModel![index].title),
                  subtitle: Text(notificationModel![index].message),
                  trailing: Text('$timeDiff hours ago'),
                  onTap: () {
                    // Add your code to handle the tap here
                  },
                );
              },
            ),
    );
  }
}
