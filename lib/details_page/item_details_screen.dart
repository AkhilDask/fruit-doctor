import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectdetector/details_page/bloc/bloc_details.dart';

class ItemdetailsPage extends StatefulWidget {
  const ItemdetailsPage(
      {super.key, required this.imageFile, required this.itemName});
  final String? itemName;
  final XFile? imageFile;
  @override
  State<ItemdetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemdetailsPage> {
  
  @override
  void initState()  {
    
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF7A9BEE),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        elevation: 1,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Details',
          style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: size.height - 82.0,
                width: size.width,
                color: Colors.transparent,
              ),
              Positioned(
                top: 75.0,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0)),
                      color: Colors.white),
                  height: size.height - 100.0,
                  width:size.width,
                ),
              ),
              Positioned(
                top: 30,
                left: (size.width / 2) - 100.0,
                child: Hero(
                    tag: 'itemdetails',
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: MemoryImage(
                          File(widget.imageFile!.path).readAsBytesSync(),
                        ),
                        fit: BoxFit.cover,
                      )),
                      height: 200.0,
                      width: 200.0,
                    )),
              ),
              Positioned(
                  top: 250.0,
                  left: 25.0,
                  right: 25.0,
                  child: Column(
                    children: [
                      Text(
                        '${widget.itemName}',
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder(
                  stream: detailsScreenBloc.getFruitDetailsStream,
                  initialData: detailsScreenBloc.fruitDetails,
                  builder: (context, snapshot) {
                    if (detailsScreenBloc.fruitDetails != null && detailsScreenBloc.fruitDetails!.name.isNotEmpty) {
                      return 
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                            height: size.height * 0.2,
                           
                            child: Row(
                              children: [
                                cardWidget('Calories',
                                   detailsScreenBloc.fruitDetails!.nutritions.calories.toString()),
                                cardWidget(
                                    'Fat',  detailsScreenBloc.fruitDetails!.nutritions.fat.toString()),
                                cardWidget('Sugar',
                                     detailsScreenBloc.fruitDetails!.nutritions.sugar.toString()),
                                cardWidget(
                                    'Carbohydrates',
                                     detailsScreenBloc.fruitDetails!.nutritions.carbohydrates
                                        .toString()),
                                cardWidget('Protein',
                                     detailsScreenBloc.fruitDetails!.nutritions.protein.toString()),
                              ],
                            )
                        
                            ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                   const SizedBox(
                        height: 30,
                      ),
                  SizedBox(
                    height: 120,
                    width: 350,
                    child: Text(
                      '${detailsScreenBloc.fruitDetails!.name}, belonging to the family ${detailsScreenBloc.fruitDetails!.family} and the order ${detailsScreenBloc.fruitDetails!.order} .This fruit, classified under the genus ${detailsScreenBloc.fruitDetails!.genus}.',),
                  )
                       
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget cardWidget(String info, String title) {
    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(244, 151, 187, 248),
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(info, style: const TextStyle(color: Colors.pink,fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
