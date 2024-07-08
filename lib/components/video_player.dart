// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_nike_slider/utils/sizing.dart';
// import 'package:video_player/video_player.dart';
// // import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class AppVideoPlayer extends StatefulWidget {
//   final String url;
//   final String thumbnail;
//   const AppVideoPlayer({super.key, required this.url, required this.thumbnail});

//   @override
//   State<AppVideoPlayer> createState() => _AppVideoPlayerState();
// }

// class _AppVideoPlayerState extends State<AppVideoPlayer> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     _controller = VideoPlayerController.networkUrl(
//       Uri.parse(widget.url),
//     )..initialize().then((_) {
//         setState(() {});
//         _controller.setLooping(true);
//         _controller.play();
//         print("Loaded");
//       });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).primaryColorDark,
//       child: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 400),
//         child: _controller.value.isInitialized
//             ? Container(
//                 width: Sizing.width(context),
//                 height: Sizing.height(context),
//                 child: AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 ),
//               )
//             : Container(
//                 width: Sizing.width(context),
//                 height: Sizing.height(context),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(widget.thumbnail),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
