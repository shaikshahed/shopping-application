import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String? url;
  const VideoPlayerScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool videoLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url ?? "")
      ..initialize().then((_) {
        setState(() {
          videoLoading = false;
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  videoLoading
                      ? Center(child: CircularProgressIndicator())
                      : AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                  if (videoLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildControlButtons(),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.replay_10_outlined, size: 30),
            onPressed: () {
              final currentPosition = _controller.value.position;
              _controller.seekTo(
                Duration(
                  seconds: currentPosition.inSeconds < 10
                      ? 0
                      : currentPosition.inSeconds - 10,
                ),
              );
            },
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.forward_10_outlined, size: 30),
            onPressed: () {
              final currentPosition = _controller.value.position;
              _controller.seekTo(
                Duration(seconds: currentPosition.inSeconds + 10),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
