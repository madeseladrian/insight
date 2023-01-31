import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../register_glasses.dart';

class UploadPhotos extends StatelessWidget {
  const UploadPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<RegisterGlassesPresenter>();
    return StreamBuilder<dynamic>(
      stream: presenter.imageStream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(
                color: Colors.grey,
                width: 5
              ),
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: snapshot.data == null ? Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        size: 50.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                RowButtons()
              ],
            ) : Column(
              children: [
                Image.file(
                  snapshot.data,
                  fit: BoxFit.contain,
                ),
                const RowButtons()
              ],
            ) 
          ),
        );
      }
    );
  }
}