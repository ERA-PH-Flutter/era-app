import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class agentYtController extends GetxController {
  late YoutubePlayerController youtubePlayerController;

  @override
  void onInit() {
    super.onInit();
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: 'UcbQCfRCoeA',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }
}
