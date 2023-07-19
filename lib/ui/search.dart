import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<List<dynamic>> {
  final List<dynamic> allData;

  CustomSearchDelegate(this.allData);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          print(allData);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> searchResults = allData.where((item) {
      final title = item['title'].toString().toLowerCase();
      final description = item['description'].toString().toLowerCase();
      return title.contains(query.toLowerCase()) ||
          description.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index]['title']),
          subtitle: Text(searchResults[index]['description']),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> suggestions = allData.where((item) {
      final title = item['title'].toString().toLowerCase();
      final description = item['description'].toString().toLowerCase();
      return title.contains(query.toLowerCase()) ||
          description.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return query.isNotEmpty
            ? Padding(
                padding: EdgeInsets.all(
                  8,
                ),
                child: Column(
                  children: [
                    CachedNetworkImage(
                        imageUrl: suggestions[index]['thumbnail']),
                    Text(suggestions[index]['title'])
                  ],
                ),
              )
            : SizedBox();
      },
    );
  }
}
// ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(suggestions[index]['title']),
//           subtitle: Text(suggestions[index]!['short_description']),
//           onTap: () {
//             query = suggestions[index]['title'];
//             showResults(context);
//           },
//         );
//       },
//     );