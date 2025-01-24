import 'package:flutter/material.dart';
import 'package:universtyapp/features/search/presentation/pages/search_results_page.dart';

class UniversitySearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Üniversite veya bölüm ara';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultsPage(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = [
      'Mühendislik',
      'İstanbul',
      'Tıp',
      'Devlet Üniversiteleri',
      'Vakıf Üniversiteleri',
      'İngilizce Eğitim',
    ];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          leading: Icon(
            Icons.search,
            color: Colors.grey.shade600,
          ),
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
} 