import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'dart:math' as math;

import './barwidget.dart';
import './play_pausewidget.dart';
import '../models.dart';
import '../content.dart';
import '../lauchurl.dart';

class Storywidget extends StatefulWidget {
  const Storywidget({Key? key}) : super(key: key);

  @override
  State<Storywidget> createState() => _StorywidgetState();
}

class _StorywidgetState extends State<Storywidget>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late List<Story> _storieslist;
  int _currentstoryindex = 0;

  @override
  void initState() {
    _storieslist = Content.instance.publicstorylist;
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);

    final Story firstStory = _storieslist.first;
    _loadstory(story: firstStory, animateToPage: false);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();

        if (_currentstoryindex + 1 < _storieslist.length) {
          _currentstoryindex += 1;
          _loadstory(story: _storieslist[_currentstoryindex]);
        } else {
          _currentstoryindex = 0;
          _loadstory(story: _storieslist[_currentstoryindex]);
        }
      }
    });
    super.initState();
  }

  bool _didchangefirsttime = true;
  @override
  void didChangeDependencies() {
    if (_didchangefirsttime) {
      for (var story in _storieslist) {
        precacheImage(AssetImage(story.storyimagepath), context);
      }
      _didchangefirsttime = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _loadstory({required Story story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    _animationController.duration = story.viewduration;
    _animationController.forward();
    if (animateToPage) {
      _pageController.animateToPage(
        _currentstoryindex,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    }
  }

  void _playpause() {
    final isplaying = _animationController.isAnimating;
    isplaying ? _animationController.stop() : _animationController.forward();
  }

  void _openstory({required String storyurl}) {
    setState(() {
      _animationController.stop();
    });
    launchurl(urlpath: storyurl);
  }

  @override
  Widget build(BuildContext context) {
    final currentstory = _storieslist[_currentstoryindex];
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _readmorebutton(currentstory: currentstory),
        body: SimpleGestureDetector(
          onVerticalSwipe: (direction) {
            if (direction == SwipeDirection.up) {
              _openstory(storyurl: currentstory.storyurl);
            }
          },
          child: Stack(children: [
            PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  _currentstoryindex = value;
                  _loadstory(story: currentstory, animateToPage: false);
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  currentstory.storyimagepath,
                  fit: BoxFit.cover,
                );
              },
              controller: _pageController,
              itemCount: _storieslist.length,
            ),
            Positioned(
                top: 10,
                right: 10,
                left: 10,
                child: _stackwidget(currentstory: currentstory)),
          ]),
        ),
      ),
    );
  }

  Widget _readmorebutton({required Story currentstory}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () {
              _openstory(storyurl: currentstory.storyurl);
            },
            icon: const Icon(
              Icons.keyboard_arrow_up_rounded,
              color: Colors.white,
            )),
        ElevatedButton(
          onPressed: () {
            _openstory(storyurl: currentstory.storyurl);
          },
          child: const Text(
            'Read More',
            style: TextStyle(color: Colors.black),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23)))),
        )
      ],
    );
  }

  Widget _stackwidget({required Story currentstory}) {
    return Column(
      children: [
        Barwidget(
          animController: _animationController,
        ),
        Row(
          children: [
            Expanded(
                child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'TD',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              title: const Text(
                'ThisDay',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                launchurl(urlpath: 'https://www.thisday.app/');
              },
            )),
            Playpause(
              animationcontroller: _animationController,
              playpause: _playpause,
            ),
            Transform.rotate(
              angle: -45 * math.pi / 180,
              child: IconButton(
                  onPressed: () async {
                    final box = context.findRenderObject() as RenderBox?;
                    await Share.share(
                        'Read this Amazing Story ${currentstory.storyurl}',
                        sharePositionOrigin:
                            box!.localToGlobal(Offset.zero) & box.size);
                  },
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 30,
                  )),
            )
          ],
        )
      ],
    );
  }
}
