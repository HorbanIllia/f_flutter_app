import 'package:dio/dio.dart';
import 'package:t_flutter_app/models/post.dart';

import 'mock_interceptor.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<List<Post>> fetchFakePostsList() async {
    try {
      _dio.interceptors.add(MockInterceptor());

      Response response = await _dio.get("posts/posts");
      return List<Post>.from(response.data.isNotEmpty ? response.data.map((c) => Post.fromJson(c)).toList() : []);
    } catch (error, stacktrace) {
      print("PostsList. Exception: $error stackTrace: $stacktrace");
      return null;
    }
  }

}