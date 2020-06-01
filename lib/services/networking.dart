import 'package:http/http.dart' as Http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  Future getDate() async {
    Http.Response response = await Http.get(url);
    var dataJson;
    if (response.statusCode == 200) {
      String data = response.body;
      //print(data);
      dataJson = jsonDecode(data);
    } else {
      dataJson = response.statusCode.toString();
      print(response.statusCode);
    }
    return dataJson;
  }
}
