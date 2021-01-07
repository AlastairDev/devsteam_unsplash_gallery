import 'package:devstream_app/api_client.dart';
import 'package:devstream_app/models/ImagesListResponseModel.dart';
import 'package:flutter/material.dart';

class GalleryViewModel extends ChangeNotifier {
  ApiClient apiClient = ApiClient();
  int page = 1;
  List<Images> items = [];
  bool isLoading = false;

  void loadData() async {
    isLoading = true;
    notifyListeners();
    page++;
    List<Images> loadedItems = await apiClient.getImagesList(page: page);
    items.addAll(loadedItems);
    isLoading = false;
    notifyListeners();
  }
}
