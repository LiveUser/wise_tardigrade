// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wise_tardigrade/test.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wise Tardigrade',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    MobileScannerController mobileScannerController = MobileScannerController();
    
    return Scaffold(
      body: MobileScanner(
        controller: mobileScannerController,
        onDetect: (barcode)async{
          InternetAddress? internetAddress = InternetAddress.tryParse(barcode.barcodes.first.rawValue ?? "");
          if(internetAddress != null && internetAddress.type == InternetAddressType.IPv4){
            await mobileScannerController.stop();
            await Navigator.push(context, MaterialPageRoute(
                builder: (context) => Test(
                  serverIPV4: internetAddress.address,
                )
              ),
            );
            await mobileScannerController.start();
          }
        },
      ),
    );
  }
}