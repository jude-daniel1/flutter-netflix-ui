import 'package:flutter/material.dart';
import 'package:netflix_ui/cubits/cubits.dart';
import 'package:netflix_ui/data/data.dart';
import 'package:netflix_ui/widgets/content_header.dart';
import 'package:netflix_ui/widgets/content_list.dart';
import 'package:netflix_ui/widgets/custom_appbar.dart';
import 'package:netflix_ui/widgets/previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  // double _scrollOffset = 0.0;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          //_scrollOffset = _scrollController.offset;
          context.read<AppBarCubit>().setOffset(_scrollController.offset);
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 70),
          child: BlocBuilder<AppBarCubit, double>(
            builder: (context, scrollOffset) {
              return CustomAppBar(scrollOffset: scrollOffset);
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [
          SliverToBoxAdapter(
              child: ContentHeader(featuredContent: sintelContent)),
          SliverPadding(
            padding: EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              key: PageStorageKey("previews"),
              child: Previews(title: 'Previews', contentList: previews),
            ),
          ),
          SliverToBoxAdapter(
            key: PageStorageKey("myList"),
            child: ContentList(title: 'My List', contentList: myList),
          ),
          SliverToBoxAdapter(
            key: PageStorageKey("originals"),
            child: ContentList(
                title: 'Netflix Originals',
                contentList: originals,
                isOriginals: true),
          ),
          SliverPadding(
            key: PageStorageKey("trending"),
            padding: EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(title: 'Trending', contentList: trending),
            ),
          )
        ],
      ),
    );
  }
}
