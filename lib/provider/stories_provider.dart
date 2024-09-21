import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:scrolling_stories/constant/string_constant.dart';
import 'package:scrolling_stories/model/stories_model.dart';
import 'package:scrolling_stories/repository/stories_repository.dart';

class StoriesProvider with ChangeNotifier {
  final StoriesRepository repository;
  StoriesProvider(this.repository);

  StoriesModel? storiesResponse;

  StoriesModel? get storiesData => storiesResponse;

  StoriesModel? searchResults;
  List<StoryData>? get searchResultsData => searchResults?.stories;

  List<StoryData> storyData = [];

  bool isLoading = false;
  String? error;
  bool hasMoreData = true;

  Future<void> fetchStories({int currentPage = 1}) async {
    isLoading = true;
    error = null;
    try {
      searchResults =
          await repository.fetchStoriesData(currentPage: currentPage);
      if (searchResultsData != null) {
        storyData.addAll(searchResultsData!);
        storiesResponse = searchResults;
        hasMoreData = storiesResponse?.currentPage != null &&
            storiesResponse?.totalPages != null &&
            storiesResponse!.currentPage! < storiesResponse!.totalPages!;
      } else {
        hasMoreData = false;
      }
      notifyListeners();
    } catch (e) {
      error = StringConstant.kFailedToLoadData;
      log("${StringConstant.kError}: $e");
      hasMoreData = false;
    }
    isLoading = false;
    notifyListeners();
  }

  void loadMoreData() async {
    if (hasMoreData && !isLoading && storiesData != null) {
      int currentPage = storiesData!.currentPage ?? 1;
      fetchStories(currentPage: currentPage + 1);
    }
  }
}
