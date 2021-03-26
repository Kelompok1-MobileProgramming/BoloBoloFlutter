import 'package:dio/dio.dart';

import 'barang.dart';

class ContactsApi {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8081'));

  Future<Barang> createBarang(String name) async {
    final response = await _dio.post('', data: {'name': name});
    return Barang.fromJson(response.data);
  }

  Future<Barang> createPrice(String price) async {
    final response = await _dio.post('', data: {'price': price});
    return Barang.fromJson(response.data);
  }
}
