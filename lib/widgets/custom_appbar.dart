// ignore_for_file: unused_element

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix_ui/assets.dart';
import 'package:netflix_ui/widgets/responsive.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;
  const CustomAppBar({Key? key, this.scrollOffset = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
      color:
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: const SafeArea(
        child: Responsive(
            mobile: _CustomeAppBarMobile(), desktop: _CustomeAppBarDesktop()),
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const _AppBarButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _CustomeAppBarMobile extends StatelessWidget {
  const _CustomeAppBarMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(Assets.netflixLogo0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AppBarButton(title: "TV Shows", onTap: () => log("TV Shows")),
              _AppBarButton(title: "Movies", onTap: () => log("Movies")),
              _AppBarButton(title: "My List", onTap: () => log("My List")),
            ],
          ),
        )
      ],
    );
  }
}

class _CustomeAppBarDesktop extends StatelessWidget {
  const _CustomeAppBarDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(Assets.netflixLogo1),
        const SizedBox(width: 12.0),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AppBarButton(title: "Home", onTap: () => log("Home")),
              _AppBarButton(title: "TV Shows", onTap: () => log("TV Shows")),
              _AppBarButton(title: "Movies", onTap: () => log("Movies")),
              _AppBarButton(title: "Latest", onTap: () => log("Latest")),
              _AppBarButton(title: "My List", onTap: () => log("My List")),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => log("Search"),
                  icon: const Icon(Icons.search,
                      color: Colors.white, size: 28.0)),
              _AppBarButton(title: "KIDS", onTap: () => log("KIDS")),
              _AppBarButton(title: "DVD", onTap: () => log("DVD")),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => log("Gift"),
                  icon: const Icon(Icons.card_giftcard,
                      color: Colors.white, size: 28.0)),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => log("Notifications"),
                  icon: const Icon(Icons.notifications,
                      color: Colors.white, size: 28.0)),
            ],
          ),
        )
      ],
    );
  }
}
