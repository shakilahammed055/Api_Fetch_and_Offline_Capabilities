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
        final data = json.decode(response.body);
        dataList.value = data;
        await box.put('cachedData', data);
      }
    } catch (e) {
      if (box.containsKey('cachedData')) {
        dataList.value = box.get('cachedData');
        Get.snackbar('Offline Mode', 'Displaying cached data.');
      } else {
        Get.snackbar('Error', 'No data available offline.');
      }
    } finally {
      isLoading(false);
    }
  }
}
