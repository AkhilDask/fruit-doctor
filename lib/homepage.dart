import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:objectdetector/details_page/detection_page.dart';
import 'package:objectdetector/details_page/item_details_screen.dart';
import 'package:objectdetector/details_page/scanner_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return 
    // Scaffold(
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //       elevation: 0,
    //       title: const Row(
    //         children: [
    //           Text(
    //             'Fruit Detector',
    //             style: TextStyle(
    //               color: Colors.black,
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //     body: Stack(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(0.0),
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 child: Stack(
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.all(10.0),
    //                       child: GridView.count(
    //                         crossAxisCount: 3,
    //                         childAspectRatio: 0.8,
    //                         physics: const NeverScrollableScrollPhysics(),
    //                         children: [
    //                           InkWell(
    //                             onTap: () {
    //                               Get.to(
    //                                   ScannerPage(scannedData: onScanComplete));
    //                             },
    //                             child: const Column(
    //                               children: [
    //                                 Icon(Icons.scanner),
    //                                 SizedBox(
    //                                   height: 2,
    //                                 ),
    //                                 SizedBox(
    //                                   child: Text(
    //                                     'Scanner',
    //                                     textAlign: TextAlign.center,
    //                                     style: TextStyle(
    //                                         fontWeight: FontWeight.bold,
    //                                         fontSize: 25),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           InkWell(
    //                             onTap: () {
    //                               Get.to(DetectionPage());
    //                             },
    //                             child: const Column(
    //                               children: [
    //                                 Icon(Icons.scanner),
    //                                 SizedBox(
    //                                   height: 2,
    //                                 ),
    //                                 SizedBox(
    //                                   child: Text(
    //                                     'Detection',
    //                                     textAlign: TextAlign.center,
    //                                     style: TextStyle(
    //                                         fontWeight: FontWeight.bold,
    //                                         fontSize: 25),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ));
    Scaffold(
      body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  ListTile(
                    
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: Text('Fruit', style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white
                    )),
                    subtitle: Text('Detector', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white54
                    )),
                    trailing: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/fruit_home.jpg'),
                    ),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200)
                  )
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 1,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    SizedBox(height: 5),
                    Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 5),
          color: Theme.of(context).primaryColor.withOpacity(.2),
          spreadRadius: 2,
          blurRadius: 5
        )
      ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
           Get.to(
                                       ScannerPage(scannedData: onScanComplete));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.scanner, color: Colors.white)
          ),
        ),
        const SizedBox(height: 8),
        Text('Scanner'.toUpperCase(), style: Theme.of(context).textTheme.titleMedium),
        
      ],
    ),
  ),
    Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 5),
          color: Theme.of(context).primaryColor.withOpacity(.2),
          spreadRadius: 2,
          blurRadius: 5
        )
      ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Get.to(DetectionPage());
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.scanner, color: Colors.white)
          ),
        ),
        
        Text('Detector'.toUpperCase(), style: Theme.of(context).textTheme.titleMedium),
        
      ],
    ),
  )
                    
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
    );
  }
}

navigateTo(screen) {
  Get.to(screen,
      transition: Transition.zoom,
      fullscreenDialog: true,
      duration: const Duration(milliseconds: 500));
}

void onScanComplete(Barcode? barcode) {}
