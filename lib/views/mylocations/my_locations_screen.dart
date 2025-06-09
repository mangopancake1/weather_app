import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/appdata/global_variables.dart';
import 'package:weather_app/appdata/global_widget.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/views/map/map_pick_screen.dart';
import 'package:weather_app/views/mylocations/widget/location_card.dart';
import 'package:weather_app/appdata/global_functions.dart';
import 'package:weather_app/appdata/session_manager.dart';

import '../../appdata/app_colors.dart';
import '../../database/my_location_database.dart';
import '../../database/my_location_model.dart';
import '../../network/weather_repository.dart';
import '../map/widget/custom_button.dart';

class MyLocationsScreen extends StatefulWidget {
  const MyLocationsScreen({super.key, required this.weatherData});

  final WeatherModel weatherData;

  @override
  State<MyLocationsScreen> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocationsScreen> {
  late String username;
  final MyLocationDatabase db = MyLocationDatabase();
  final WeatherRepository repo = WeatherRepository();

  @override
  void initState() {
    super.initState();
    _initUserData();
  }

  Future<void> _initUserData() async {
    username = (await SessionManager.getLoggedInUsername()) ?? '';
    final myBox = Hive.box('mylist');
    if (myBox.get("MYLOCATIONS") == null) {
      db.createInitialData(
          myLocationModel: MyLocationModel(
              title: "Home",
              latitude: globalVariable.latitude.toString(),
              longitude: globalVariable.longitude.toString(),
              weatherModel: widget.weatherData));
      db.updateDatabase();
      db.loadData();
      setState(() {}); // update UI setelah data awal dibuat
    } else {
      db.loadData();
      setState(() {}); // update UI setelah data dimuat
    }
  }

  void _onRefresh() {
    setState(() {
      db.loadData();
    });
  }

  void showConfirmDialog(int index) {
    final formKey = GlobalKey<FormState>();
    if (mounted) {
      showDialog(
          context: context,
          builder: (dialogContext) {
            return StatefulBuilder(builder: (context, setState) {
              return Dialog(
                  backgroundColor: AppColors.primaryColor,
                  child: Form(
                      key: formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 24),
                        child: SingleChildScrollView(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            SizedBox(height: getScreenHeight() * 0.015),
                            const Text('Delete Location?',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.secondaryColor)),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomButton(
                                    width: 102,
                                    height: 46,
                                    buttonColor: AppColors.secondaryColor,
                                    buttonText: 'Cancel',
                                    textColor: AppColors.primaryColor,
                                    onTapped: () async {
                                      Navigator.pop(context);
                                    },
                                    setBorderRadius: true),
                                const SizedBox(width: 4),
                                CustomButton(
                                    width: 102,
                                    height: 46,
                                    buttonColor: AppColors.secondaryColor,
                                    buttonText: 'Delete',
                                    textColor: AppColors.primaryColor,
                                    onTapped: () {
                                      db.loadData();
                                      setState(() {
                                        db.myLocations.removeAt(index);
                                        db.updateDatabase();
                                      });
                                      db.loadData();
                                      Navigator.pop(context);
                                    },
                                    setBorderRadius: true),
                              ],
                            ),
                            SizedBox(height: getScreenHeight() * 0.015),
                          ]),
                        ),
                      )));
            });
          });
    }
  }

  Future<List<MyLocationModel>> _getLocations() {
    return db.getLocations(username);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            'My Saved Locations',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: RefreshIndicator(
            backgroundColor: AppColors.secondaryColor,
            color: AppColors.primaryColor,
            onRefresh: () async => _onRefresh(),
            child: db.myLocations.isNotEmpty
                ? ListView.builder(
                    itemCount: db.myLocations.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: LocationCard(
                            onTapped: () {
                              showConfirmDialog(index);
                            },
                            title: db.myLocations[index].title,
                            locationName:
                                db.myLocations[index].weatherModel.name,
                            temp: db.myLocations[index].weatherModel.main.temp,
                            weatherCondition: db.myLocations[index].weatherModel
                                .weather[0].main,
                            isCurrentLocation:
                                double.parse(db.myLocations[index].latitude) ==
                                    globalVariable.myLocationLat,
                            weatherIcon: db.myLocations[index].weatherModel
                                .weather[0].icon),
                      );
                    },
                  )
                : const SingleScrollViewCustomized(
                    child: Text(
                        "List is Empty.\nYou can add a data into the list\nby pressing the Floating Action Button!",
                        textAlign: TextAlign.center),
                  )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondaryColor,
          foregroundColor: AppColors.primaryColor,
          onPressed: () => pushToNextScreen(
              context, const MapPickScreen(title: "Choose A Location")),
          child: const Icon(Icons.add),
        ));
  }
}
