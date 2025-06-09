import 'package:hive_flutter/hive_flutter.dart';
import 'my_location_model.dart';

class MyLocationDatabase {
  List<MyLocationModel> myLocations = [];

  final _myBox = Hive.box('mylist');

  void createInitialData({required MyLocationModel myLocationModel}) {
    myLocations = [myLocationModel];
    updateDatabase(); // Tambahkan ini agar data langsung tersimpan di Hive
  }

  void loadData() {
    var rawData = _myBox.get("MYLOCATIONS") as List<dynamic>?;

    if (rawData != null) {
      myLocations = rawData.map((e) => e as MyLocationModel).toList();
    } else {
      myLocations = [];
    }
  }

  void updateDatabase() {
    _myBox.put("MYLOCATIONS", myLocations);
  }

  Future<Box<MyLocationModel>> _getUserBox(String username) async {
    return await Hive.openBox<MyLocationModel>('locations_$username');
  }

  Future<void> addLocation(String username, MyLocationModel location) async {
    final box = await _getUserBox(username);
    await box.add(location);
  }

  Future<List<MyLocationModel>> getLocations(String username) async {
    final box = await _getUserBox(username);
    return box.values.toList();
  }

  Future<void> deleteLocation(String username, int index) async {
    final box = await _getUserBox(username);
    await box.deleteAt(index);
  }
}
