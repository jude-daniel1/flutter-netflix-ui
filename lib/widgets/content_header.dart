// ignore_for_file: unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix_ui/models/content_model.dart';
import 'package:netflix_ui/widgets/responsive.dart';
import 'package:netflix_ui/widgets/vertifical_icon_button.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;
  const ContentHeader({Key? key, required this.featuredContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _ContentHeaderMobile(featuredContent: featuredContent),
        desktop: _ContentHeaderDesktop(featuredContent: featuredContent));
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;
  const _ContentHeaderMobile({Key? key, required this.featuredContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(featuredContent.imageUrl),
                  fit: BoxFit.cover)),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(featuredContent.titleImageUrl!),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                  icon: Icons.info_outline,
                  title: "List",
                  onTap: () => log("My List")),
              TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(100, 40),
                    //fixedSize: Size.zero,
                  ),
                  onPressed: () => log("play"),
                  icon: const Icon(Icons.play_arrow,
                      size: 30, color: Colors.black),
                  label: const Text(
                    "Play",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )),
              VerticalIconButton(
                  icon: Icons.add, title: "Info", onTap: () => log("My List"))
            ],
          ),
        )
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;
  const _ContentHeaderDesktop({Key? key, required this.featuredContent})
      : super(key: key);

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  late VideoPlayerController _videoPlayerController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.featuredContent.videoUrl!)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        _videoPlayerController.value.isPlaying
            ? _videoPlayerController.pause()
            : _videoPlayerController.play();
      }),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoPlayerController.value.isInitialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.asset(widget.featuredContent.imageUrl,
                    fit: BoxFit.cover),
          ),
          Positioned(
            bottom: -1.0,
            left: 0,
            right: 0,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.isInitialized
                  ? _videoPlayerController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(widget.featuredContent.titleImageUrl!),
                ),
                const SizedBox(height: 15.0),
                Text(
                  widget.featuredContent.description!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(2.0, 4.0),
                            blurRadius: 6.0)
                      ]),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    _PlayButton(videoPlayerController: _videoPlayerController),
                    const SizedBox(width: 16.0),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: const Size(120, 40)),
                      onPressed: () => log("More Info"),
                      icon: const Icon(
                        Icons.info_outline,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "More Info",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    if (_videoPlayerController.value.isInitialized)
                      IconButton(
                        onPressed: () {
                          _isMuted
                              ? _videoPlayerController.setVolume(100)
                              : _videoPlayerController.setVolume(0);
                          _isMuted = _videoPlayerController.value.volume == 0;
                          setState(() {});
                        },
                        icon:
                            Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                        color: Colors.white,
                        iconSize: 30.0,
                      )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  const _PlayButton({Key? key, required this.videoPlayerController})
      : super(key: key);

  @override
  State<_PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<_PlayButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white, fixedSize: const Size(100, 40),
          //fixedSize: Size.zero,
        ),
        onPressed: () => setState(() {
              widget.videoPlayerController.play();
            }),
        icon: const Icon(Icons.play_arrow, size: 30, color: Colors.black),
        label: const Text(
          "Play",
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
        ));
  }
}
