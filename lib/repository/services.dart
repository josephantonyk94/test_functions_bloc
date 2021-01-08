import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:test_functions/model/albums_list.dart';

abstract class AlbumRepo{
  Future<List<Album>> getAlbumList();
  }
  class AlbumServices implements AlbumRepo{
static const _baseUrl="jsonplaceholder.typicode.com";
    @override
  Future<List<Album>> getAlbumList() async{
Uri url=Uri.https(_baseUrl,"/albums");
Response response=await http.get(url);
List<Album> albums=albumFromJson(response.body);
return albums;
  }
}