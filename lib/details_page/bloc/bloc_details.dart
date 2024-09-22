//https://www.fruityvice.com/api/fruit/all

import 'dart:async';

import 'package:objectdetector/details_page/bloc/provider_details.dart';
import 'package:objectdetector/details_page/model/fruits_detail.dart';

class DetailsScreenBloc {
  final detailsScreenProvider = DetailsScreenProvider();

   String labelNameDetected = '';
  FruitDetails? fruitDetails;

  Stream get getLabelName => labelNameController.stream;
  final labelNameController = StreamController<String>.broadcast();

    Stream get getFruitDetailsStream => fruitrDetailsController.stream;
  final fruitrDetailsController = StreamController<FruitDetails>.broadcast();

   void updateLabelName(String data) {
    labelNameDetected = data;
    labelNameController.sink.add(labelNameDetected);
  }

  getFruitDetails(String fruitName) async {
    fruitDetails  =
        await detailsScreenProvider.fetchFruitDetails(fruitName);
        fruitrDetailsController.sink.add(fruitDetails!);
       
  }
}

final detailsScreenBloc = DetailsScreenBloc();
