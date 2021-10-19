import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:pico_sulteng_flutter/app/data/models/banner.dart' as model;
import 'package:pico_sulteng_flutter/app/data/models/infographic.dart';
import 'package:pico_sulteng_flutter/app/data/models/province_test.dart';
import 'package:pico_sulteng_flutter/app/data/models/province_vaccine.dart';
import 'package:pico_sulteng_flutter/app/data/models/statistic.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = FlutterConfig.get('BASE_URL').toString();
  }

  Future<List<model.Banner>> loadBanners() async {
    final response = await get('/banner');

    if (response.hasError) {
      throw Exception(response.statusText.toString());
    }

    final List<dynamic> data = response.body['data'] as List;
    return data
        .map((e) => model.Banner.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Statistic> loadProvince() async {
    final response = await get('/statistik/terkini');

    if (response.hasError) {
      throw Exception(response.statusText.toString());
    }

    final data = response.body['data'] as Map<String, dynamic>;
    return Statistic.fromJson(data);
  }

  Future<List<ProvinceTest>> loadProvinceTest() async {
    final response = await get('/test/terkini');

    if (response.hasError) {
      throw Exception(response.statusText.toString());
    }

    final List<dynamic> data = response.body['data'] as List<dynamic>;
    return data
        .map((e) => ProvinceTest.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ProvinceVaccine> loadProvinceVaccine() async {
    final response = await get('/vaksin/72/terkini');

    if (response.hasError) {
      throw Exception(response.statusText.toString());
    }

    final data = response.body['data'];
    return ProvinceVaccine.fromJson(data as Map<String, dynamic>);
  }

  Future<List<Infographic>> loadInfographics(int page) async {
    final response = await get('/infografis?page=$page');

    if (response.hasError) {
      throw Exception(response.statusText.toString());
    }

    final data = response.body['data']['data'] as List<dynamic>;

    return data
        .map((json) => Infographic.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
