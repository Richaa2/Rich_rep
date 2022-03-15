import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';

import 'person_card_widgets.dart';

class PersonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonListCubit, PersonState>(builder: (context, state) {
      List<PersonEntity> persons = [];
      if (state is Personloading && state.isFirstFetch) {
        return _loadingindicator();
      } else if (state is PersonLoaded) {
        persons = state.personsList;
      }
      return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey,
          );
        },
        itemCount: persons.length,
        itemBuilder: (BuildContext context, int index) {
          return PersonCard(person: persons[index]);
        },
      );
    });
  }

  Widget _loadingindicator() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
