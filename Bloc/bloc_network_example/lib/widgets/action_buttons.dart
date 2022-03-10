import 'package:bloc_network_example/bloc/user_bloc.dart';
import 'package:bloc_network_example/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RaisedButton(
          onPressed: () {
            userBloc.add(UserLoadEvent());
          },
          child: Text('Load'),
          color: Colors.green,
        ),
        SizedBox(
          width: 8,
        ),
        RaisedButton(
          onPressed: () {
            userBloc.add(UserClearEvent());
          },
          child: Text('Clear'),
          color: Colors.red,
        ),
      ],
    );
  }
}
