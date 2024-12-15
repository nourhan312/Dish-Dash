import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../data/model/meals_model_response.dart';

class ShowYoutubeVideo extends StatefulWidget {
  const ShowYoutubeVideo({super.key, required this.mealsDetails});

  final MealsDetails? mealsDetails;
  @override
  State<ShowYoutubeVideo> createState() => _ShowYoutubeVideoState();
}

class _ShowYoutubeVideoState extends State<ShowYoutubeVideo> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    String videoId = _extractVideoId(widget.mealsDetails!.youtubeLink ?? '');
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  String _extractVideoId(String url) {
    final uri = Uri.parse(url);
    return uri.queryParameters['v'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12.r),
        topLeft: Radius.circular(12.r),
      ),
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          width: double.infinity,
          controller: _controller,
          liveUIColor: AppColor.mainBrown,
          showVideoProgressIndicator: true,
        ),
        builder: (context, player) {
          return player;
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
