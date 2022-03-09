import 'package:bloc_network_example/widgets/action_buttons.dart';
import 'package:bloc_network_example/widgets/user_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Users List '),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ActionButtons(),
          Expanded(child: UserList()),
        ],
      ),
    );
  }
}
