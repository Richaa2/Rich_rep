import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/usecases/search_person.dart';

import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpry()) {
    on<SearchPersons>(_onEvent);
  }
  FutureOr<void> _onEvent(event, emit) async {
    emit(PersonSearchLoading());

    final failureOrPerson =
        await searchPerson(SearchPersonParams(query: event.personQuery));
    emit(failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }

    //   on<PersonSearchLoading>(event, emit) async {
    //     try {
    //       final _loadedSearchPersonList = await searchPerson();
    //       emit(PersonSearchLoaded(persons: _loadedSearchPersonList));
    //     } catch (_) {
    //       PersonSearchError(message: 'Error PersonSearchLoading');
    //     }
    //   }
    // }
  }
}
