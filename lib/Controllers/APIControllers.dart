import 'package:dio/dio.dart';
import 'package:search/Models/FirstCategory.dart';
import 'package:search/Models/SecondCat.dart';
import 'package:search/Models/ThirdCat.dart';

class APIControllers {
  APIControllers._();
  static APIControllers apiControllers=APIControllers._();

  Dio _getDio(){
    return Dio(BaseOptions(baseUrl: 'http://api.alboraq-pal.com/api',
        connectTimeout: Duration(minutes: 5),
        receiveTimeout: Duration(minutes: 5),
        headers: {'token': '9ATNe8CUxLf5KHJF:APA91bE_dlzZGKAvNUo'
            'EfAgH7yfTpWsIDgYKzsK0myuC0pTFTqhEEvgZyDKh9mtEWmit3Y1du_',}));
  }

  Future<FirstCat> getAllEpisodes(String content, int cat) async{
    var resposne=await _getDio().get('/search',
        queryParameters: {
          "search":content,
          "constant_search":cat
        });
    return FirstCat.fromJson(resposne.data);

  }
  Future<SecondCat> getProgrammes(String content, int cat) async{
    var respone=await _getDio().get('/search',
        queryParameters: {
          "search":content,
          "constant_search":cat
        });
    return SecondCat.fromJson(respone.data);

  }
  Future<ThirdCat> getReports(String content, int cat) async{
    var respone=await _getDio().get('/search',
        queryParameters: {
          "search":content,
          "constant_search":cat
        });
    return ThirdCat.fromJson(respone.data);

  }

}