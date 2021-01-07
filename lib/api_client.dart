import 'package:devstream_app/models/ImagesListResponseModel.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const mainUrl = 'https://api.unsplash.com';
  static const apiKey = '896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043';

  Map<String, String> generateHeader() {
    Map<String, String> headers = {'Authorization': 'Client-ID $apiKey'};
    return headers;
  }

  Future<List<Images>> getImagesList({int page = 1, int perPage = 15}) async {
    http.Response response =
        await http.get(mainUrl + "/photos?page=$page&per_page=$perPage", headers: generateHeader());

    return imagesFromJson(response.body);
  }
}
