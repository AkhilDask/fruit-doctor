import 'dart:convert';
import 'dart:io';

import 'package:objectdetector/details_page/model/fruits_detail.dart';

class DetailsScreenProvider {
  fetchFruitDetails(String fruitName) async {
    try {
      String url = 'https://www.fruityvice.com/api/fruit/$fruitName';

      HttpClient client1 = HttpClient();
      client1.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      HttpClientRequest request = await client1.getUrl(Uri.parse(url));

      HttpClientResponse response = await request.close();

      var result = StringBuffer();
      await for (var contents in response.transform(const Utf8Decoder())) {
        result.write(contents);
      }

      final myList = jsonDecode(result.toString());
      
      return FruitDetails.fromJson(myList);
    } catch (e) {
      print(e);
    }
  }
}
