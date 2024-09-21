import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingController extends GetxController {
  var training = <Map<String, String>>[].obs;
  RxList images = [].obs;
  var previewTraining = <Map<String, String>>[].obs;

  var title = ''.obs;
  var description = ''.obs;
  var videoUrl = ''.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();

  void addTrainings() {
    for (var trainingData in previewTraining) {
      training.add(trainingData);
    }
  }

  void addToPreview(String title, String desc, String videoUrl) {
    previewTraining.add({
      'title': title,
      'desc': desc,
      'videoUrl': videoUrl,
    });
  }

  void clearPreview() {
    previewTraining.clear();
  }

  void trainingRemove(int index) {
    training.removeAt(index);
  }

  void previewremoveAt(int index) {
    previewTraining.removeAt(index);
  }

  // @override
  // void onClose() {
  //   youtubePlayerController.value?.dispose();
  //   super.onClose();
  // }
}
  // void setTitle(String value) {
  //   title.value = value;
  // }

  // void setDescription(String value) {
  //   description.value = value;
  // }

  // void setVideoUrl(String value) {
  //   videoUrl.value = value;

  //   final videoId = YoutubePlayer.convertUrlToId(value);
  //   if (videoId != null) {
  //     youtubePlayerController.value?.dispose();
  //     youtubePlayerController.value = YoutubePlayerController(
  //       initialVideoId: videoId,
  //       flags: const YoutubePlayerFlags(
  //         autoPlay: false,
  //         mute: false,
  //       ),
  //     );
  //   }
  // }