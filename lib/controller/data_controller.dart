import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class DataController extends GetxController {
  var isLoading = false.obs;
  var dataList = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading(true);
    final box = Hive.box('localData');

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        dataList.value = data;
        await box.put('cachedData', data);
      }
    } catch (e) {
      if (box.containsKey('cachedData')) {
        final cachedData = box.get('cachedData') as List<dynamic>;
        dataList.value = cachedData
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
        Get.snackbar('Offline Mode', 'Displaying cached data.');
      } else {
        Get.snackbar('Error', 'No data available offline.');
      }
    } finally {
      isLoading(false);
    }
  }
}
