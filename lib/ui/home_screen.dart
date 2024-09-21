import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_stories/constant/string_constant.dart';
import 'package:scrolling_stories/provider/stories_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoriesProvider>().storyData = [];
      context.read<StoriesProvider>().fetchStories();
    });
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<StoriesProvider>().loadMoreData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Builder(builder: (context) {
            if (context.watch<StoriesProvider>().isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            if (context.watch<StoriesProvider>().error != null) {
              return Center(
                child: Text("${context.watch<StoriesProvider>().error}"),
              );
            }
            if (context.watch<StoriesProvider>().searchResultsData != null) {
              var stories = context.watch<StoriesProvider>().storyData;
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    if (index < stories.length) {
                      return StoryPreview(
                        thumbnailUrl: stories[index].thumbnail!,
                        title: stories[index].title!,
                        description: stories[index].content!,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    }
                  },
                ),
              );
            }
            return const Center(
              child: Text(StringConstant.kSomethingIsWrong),
            );
          }),
        ),
      ),
    );
  }
}

class StoryPreview extends StatefulWidget {
  final String thumbnailUrl;
  final String title;
  final String description;

  const StoryPreview({
    super.key,
    required this.thumbnailUrl,
    required this.title,
    required this.description,
  });

  @override
  _StoryPreviewState createState() => _StoryPreviewState();
}

class _StoryPreviewState extends State<StoryPreview> {
  bool _showDescription = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Container(
      height: height * 0.40,
      margin: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: width * 0.01),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.05),
        ),
        child: Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(width * 0.05),
                  child: Image.network(
                    widget.thumbnailUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: height * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      setState(() {
                        _showDescription = !_showDescription;
                      });
                    },
                  ),
                ],
              ),
              if (_showDescription)
                Padding(
                  padding: EdgeInsets.only(top: height * 0.005),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: height * 0.018,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
