import 'dart:convert';
import 'package:scrolling_stories/api/base/base_repository.dart';
import 'package:scrolling_stories/constant/api_constant.dart';
import 'package:scrolling_stories/model/stories_model.dart';

class StoriesRepository extends BaseRepository {
  Future<StoriesModel> fetchStoriesData({required int currentPage}) async {
    final response = await requesthttps(
      RequestType.GET,
      "${ApiConstant.mockApiEndPoint}mock?page=$currentPage&pageSize=5",
      null,
    );
    return StoriesModel.fromJson(jsonDecode(response.body));
  }
}
