import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_card_widgets.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for character...');

  final _suggestions = ['Rick', 'Morty', 'Summer', 'Beth', 'Jerry'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        tooltip: 'Back',
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    final scrollSearchController = ScrollController();
    int page = -1;
    void setupScrollSearchController(BuildContext context) {
      scrollSearchController.addListener(() {
        if (scrollSearchController.position.atEdge) {
          if (scrollSearchController.position.pixels != 0) {
            // BlocProvider.of<PersonListCubit>(context).loadPerson();
            context.read<PersonSearchBloc>();
          }
        }
      });
    }

    print('Inside custom search delegate and search query is $query');
    BlocProvider.of<PersonSearchBloc>(context, listen: false)
        .add(SearchPersons(query));
    setupScrollSearchController;
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
        builder: (context, state) {
      Widget _loadingindicator() {
        return Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      List<PersonEntity>? persons = [];
      bool isLoading = false;
      if (state is PersonSearchLoading && state.isFirstFetch!) {
        return _loadingindicator();
      } else if (state is PersonSearchLoading) {
        isLoading = true;
        persons = state.oldPersonsList;
      } else if (state is PersonSearchLoaded) {
        final person = state.persons;
        if (person.isEmpty) {
          return _showErrorText('No Characters with that name found');
        }
        return Container(
            child: ListView.separated(
          controller: scrollSearchController,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.grey,
            );
          },
          itemCount: persons.length,
          itemBuilder: (context, index) {
            if (index < persons!.length) {
              return PersonCard(person: persons[index]);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollSearchController
                    .jumpTo(scrollSearchController.position.maxScrollExtent);
              });
              return _loadingindicator();
            }
          },
        ));
      } else if (state is PersonSearchError) {
        return _showErrorText(state.message);
      } else {
        return const Center(
          child: Icon(Icons.now_wallpaper),
        );
      }
      throw (CircularProgressIndicator);
    });
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 0) {
      return Container();
    }
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Text(
            _suggestions[index],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: _suggestions.length);
  }
}
