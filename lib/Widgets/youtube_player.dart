import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class YoutubeAppDemo extends StatefulWidget {
  final String id;
  YoutubeAppDemo({required this.id});
  @override
  _YoutubeAppDemoState createState() => _YoutubeAppDemoState();
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '${widget.id}',
      params: const YoutubePlayerParams(
        //playlist: [
        //   'nPt8bK2gbaU',
        //   'K18cpp_-gP8',
        //   'iLnmTe5Q2Qw',
        //   '_WoCV4c6XOE',
        //   'KmzdUe0RSJo',
        //   '6jZDSSZZxjQ',
        //   'p2lYr3vM_1w',
        //   '7QUtEmBT_-w',
        //   '34_PXCzGw1M',
        // ],
        //startAt: const Duration(minutes: 1, seconds: 36),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: true,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: Scaffold(    
        backgroundColor: Colors.transparent,   
        body: LayoutBuilder(
          builder: (context, constraints) {
            // if (kIsWeb && constraints.maxWidth > 800) {
            //   return Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Expanded(child: player),              
            //     ],
            //   );
            // }
            // return ListView(
            //   children: [
            //     player,
            //   ],
            // );
               return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: player),              
                ],
              );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

///
