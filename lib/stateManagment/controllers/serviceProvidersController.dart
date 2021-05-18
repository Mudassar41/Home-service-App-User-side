import 'package:get/get.dart';
import 'package:user_side/models/providersData.dart';
import 'package:user_side/services/apiServices.dart';

class ServiceProviderController extends GetxController {
  var lat=0.0.obs;
  var lang=0.0.obs;
  var catId = ''.obs;
  var isLoading = true.obs;
  var dataList = <ProvidersData>[].obs as List<ProvidersData>;
  @override
  void refresh() {
    super.refresh();
    print("updated");
    fetchCategoriesData(catId.value);
  }

  void fetchCategoriesData(String tag) async {
    isLoading(true);
    try {
      var list = await ApiServices.searchCategiesData(tag);
      if (list != null) {
        dataList = list;
      }
    } finally {
      isLoading(false);
    }
  }
}
