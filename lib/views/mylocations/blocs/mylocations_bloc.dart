// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:weather_app/appdata/my_shared_preferences.dart';
// import 'package:weather_app/network/models/weather/weather_model.dart';
//
// import '../../../blocs/bloc_status.dart';
//
// part 'mylocations_event.dart';
// part 'mylocations_state.dart';
//
// class MyLocationBloc extends Bloc<MylocationsEvent, MyLocationState> {
//   MyLocationBloc() : super( const MyLocationState()) {
//     on<MylocationsEvent>((event, emit) async {
//       await mapEventToState(event, emit);
//     });
//   }
//
//   Future mapEventToState(MylocationsEvent event, Emitter<MyLocationState> emit) async {
//     if (event is MyLocationsInitialEvent || event is MyLocationsRefreshedEvent) {
//       if (event is MyLocationsInitialEvent && ) {
//
//       }
//     }
//   }
// }
