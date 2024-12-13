import 'dart:convert';

import 'package:falcons_task/constants/apis_endpoints.dart';
import 'package:falcons_task/errors/exceptions.dart';
import 'package:falcons_task/models/item.dart';
import 'package:falcons_task/models/item_quantity.dart';
import 'package:falcons_task/services/local_storage_service.dart';
import 'package:http/http.dart' as http;

import '../models/merged_data.dart';

class RemoteDataSource {
  final LocalStorageService localStorageService;
  RemoteDataSource({
    required this.localStorageService,
  });
  Future<List<MergedData>> fetchData() async {
    try {
      var data = await Future.wait([fetchItems(), fetchQuantities()]);
      var items = data[0] as List<Item>;
      var quantities = data[1] as List<ItemQuantity>;
      await storeItemsInDB(items);
      await storeItemsQuantitiesInDB(quantities);
      await storeMergedDataInDB();
      var storedData = await localStorageService.getStoredData();
      List<MergedData> mergedData = mergedDataFromJSON(storedData);
      print("Remote ${mergedData.length}");
      return mergedData;
    } on FetchException catch (e) {
      throw FetchException(message: e.message);
    }
  }

  Future<List<ItemQuantity>> fetchQuantities() async {
    try {
      final url = Uri.parse(ApisEndpoints.quantitiesAPI);
      final response = await http.get(url);
      final decodedResponseBody = jsonDecode(response.body);
      return itemQuantityFromJson(decodedResponseBody["SalesMan_Items_Balance"]);
    } catch (e) {
      throw ItemsQuantityApiException(message: "Error Getting Quantities From API");
    }
  }

  Future<List<Item>> fetchItems() async {
    try {
      final url = Uri.parse(ApisEndpoints.itemsAPI);
      final response = await http.get(url);

      final decodedResponseBody = jsonDecode(response.body);
      return itemsFromJson(decodedResponseBody["Items_Master"]);
    } catch (e) {
      throw ItemsApiException(message: "Error Getting Items From API");
    }
  }

  Future<void> storeItemsInDB(List<Item> items) async {
    try {
      for (var item in items) {
        await localStorageService.storeItem(item);
      }
    } catch (e) {
      throw LocalStorageException(message: "Error Storing Data SQL");
    }
  }

  Future<void> storeItemsQuantitiesInDB(List<ItemQuantity> quantities) async {
    try {
      for (var quantity in quantities) {
        await localStorageService.storeQuantity(quantity);
      }
    } catch (e) {
      throw LocalStorageException(message: "Error Storing Data SQL");
    }
  }

  Future<void> storeMergedDataInDB() async {
    try {
      await localStorageService.storeMergedDataInDB();
    } catch (e) {
      throw LocalStorageException(message: "Error Storing Data SQL");
    }
  }
}
