import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teste_tflow/controller/scan_controller.dart';


class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    

    
    
    return Scaffold(
      body: GetBuilder<ScanController>(
        
        init: ScanController(),
        builder: (controller) {
          
          
          return controller.isCameraInitialized.value ? Stack(
            children: [
              CameraPreview(controller.cameraController),
              
              Positioned(
                top:  controller.y != null ? (controller.y )* 700 : 200  ,
                right: controller.y != null ? (controller.x) * 500 : 100  ,
                width:  controller.w != null ? controller.w * 100 * context.width / 100 : 100,
                  height: controller.w != null ? controller.h * 100 * context.height / 100 : 100,
                
                child: Container(
                  
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