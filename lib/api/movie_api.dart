import "../model/result_res.dart";
import 'package:http/http.dart' as http;
import "../model/overall_response.dart";

String baseUrl = "https://api.themoviedb.org/3/movie/";
String apiKey = "6fca727503a934e24b91325556f4ec8b";

class API {
  Future<List<Result>> getMovieList(String category) async {
    var uri =
        Uri.parse("$baseUrl$category?api_key=$apiKey&language=en-US&page=1");
    var res = await http.get(uri);

    if (res.statusCode == 200) {
      var overall_result = OverallResponse.fromRawJson(res.body);
      return overall_result.results;
    } else {
      throw Exception("Failed to get Movies");
    }
  }
}
