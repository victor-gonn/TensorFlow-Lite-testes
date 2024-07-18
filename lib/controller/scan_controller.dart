


import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initTFlite();
    initCamera();
    
  }

  @override
  void dispose() async {
    cameraController.dispose();
    await Tflite.close();
  
    super.dispose();
    
  }

  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isCameraInitialized = false.obs;
  var cameraCount = 0;
  var x, y, w, h = 0.0;
  var label = '';

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();

      cameraController = CameraController(cameras[0], ResolutionPreset.max);

      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 10 == 0) {
            cameraCount = 0;
            objectDetector(image);
          }
          update();
        });
      });
      isCameraInitialized(true);
      update();
    } else {
      print("aCESSO NEGADO");
    }
  }

  initTFlite() async {
    
    
    await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt",
        isAsset: true,
        numThreads: 1,
        useGpuDelegate: false);
  }

  objectDetector(CameraImage image) async {
    var detector = await Tflite.detectObjectOnFrame(
        bytesList: image.planes.map((e) {
          return e.bytes;
        }).toList(),
        model: "SSDMobileNet",
        asynch: true,
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        
        threshold: 0.1);

        

    detector?.forEach((response) {
      
      if (detector != null) {
        if (detector[0]['confidenceInClass'] * 100 > 45) {
          label = response['detectedClass'].toString();
           x = response['rect']['x'] ;
           y = response['rect']['y'] ;
           h = response['rect']['h'] ;
           w = response['rect']['w'] ;
           print(detector);
          
         
          
          
          
         
        }
        update();
        
      }

      
    },
    
    
    
    );
  }
}
