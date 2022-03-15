import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.cellBackground,
            borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          Container(
            height: 166,
            width: 166,
            child: Image.network(person.image),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(
                  person.name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: person.status == 'Alive'
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Text(
                      '${person.status} - ${person.species}',
                      style: TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ))
                  ],
                )
              ],
            ),
          )
        ]));
  }
}
