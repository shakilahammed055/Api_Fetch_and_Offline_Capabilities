import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline_app/controller/data_controller.dart';
import 'package:offline_app/widget/data_card.dart';

class DataView extends StatelessWidget {
  final DataController controller = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch & Offline Capabilities',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent));
            } else if (controller.dataList.isEmpty) {
              return Center(
                child: Text(
                  'No data available',
                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.dataList.length,
                itemBuilder: (context, index) {
                  final item = controller.dataList[index];
                  return DataCard(item: item);
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
