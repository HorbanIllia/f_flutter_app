import 'package:t_flutter_app/models/post.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<Post>> fetchPostsList() {
    return _provider.fetchFakePostsList();
  }
}

class NetworkError extends Error {}