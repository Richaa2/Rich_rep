import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_find_freezed_example/data/models/character.dart';

class CustomListTile extends StatelessWidget {
  final Results result;
  const CustomListTile({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        color: const Color.fromRGBO(86, 86, 86, 0.8),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: result.image,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          ],
        ),
      ),
    );
  }
}
