import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ColorEvent { event_red, event_green }

// class ColorBloc extends Bloc<ColorEvent, Color> {
//   static const Color _color = Colors.red;
//   ColorBloc() : super(_color) {
//     on<ColorEvent>((event, emit) async {
//      await event(ColorEvent: (_color) async {
//         emit(_color = Colors.red);
//       });
// //     yield _color;
//     });
//   }
// }

// class ColorBloc extends Bloc<ColorEvent, Color> {
//   Color _color = Colors.red;

//   ColorBloc() : super(Colors.red);

//   Color get initialState => Colors.red;

//   Stream<Color> mapEventToState(ColorEvent event) async* {
//     _color = (event == ColorEvent.event_red) ? Colors.red : Colors.green;
//     yield _color;
//   }
// }
