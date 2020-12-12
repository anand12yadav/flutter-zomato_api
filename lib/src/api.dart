import 'package:dio/dio.dart';
import 'category.dart';
import 'search_options.dart';

const zlocations=["city","subzone","landmark","metro","group"];
const zsort=["cost","rating"];
const zorder=["asc","desc"];
const double zMaxCount=20;

class ZomatoAPi{
  final List<String> locations=zlocations;
  final List<String> sort=zsort;
  final List<String> order=zorder;
  final double count=zMaxCount;

  final Dio _dio;
  final List<Category> categories=[];

  ZomatoAPi(String key):_dio= Dio(BaseOptions(
      baseUrl: 'https://developers.zomato.com/api/v2.1/',
      headers: {
        'user-key': key,
        'Accept':'applicaton/json'
      }
      ));

  Future loadCategories()async{
    final response=await _dio.get('categories');
    final data=response.data['categories'];
  categories.addAll(
    data.map<Category>((json)=>Category(
      json['categories']['id'],
      json['categories']['name']
  
  )));
}

  Future<List> searchRestaurants(String query,SearchOptions options) async {
    final response = await _dio.get('search', queryParameters: {
      'q': query,
      ...(options != null ? options.toJson():{})
    });
    return response.data['restaurants'];
  }
}