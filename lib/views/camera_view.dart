import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teste_tflow/controller/scan_controller.dart';
import 'dart:math' as math;

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) {
          return controller.isCameraInitialized.value ? Stack(
            children: [
              CameraPreview(controller.cameraController),
              
              Positioned(
                top: 200,
                right: 100,
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: const Color.fromARGB(255, 239, 148, 255))
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Text(controller.label))
                    ],
                  ),
                ),
              )
            ],
          ) 
          : Center( child: Text('Camera is loading'),);
        }
      ),
    );
  }
}