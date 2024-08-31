import 'package:flutter/material.dart' hide Step;
import 'package:intl/intl.dart';
import 'package:pedometer_db/step_log_db.dart';
// import 'package:move_to_earn/utils/step_log_db/step_log_db.dart';

class StepLog extends StatelessWidget {
  const StepLog({super.key});

  String _formatTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Steplog Screen'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: SteplogDatabase.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Render the data in a ListView
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text(
                    'id: ${item['id']}, total: ${item['total']}, last: ${item['last']}, plus: ${item['plus']}, time: ${_formatTimestamp(item['timestamp'])}',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
