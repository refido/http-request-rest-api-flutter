import 'package:flutter/material.dart';
import 'package:http_request_rest_api_flutter/pages/movie_popular.dart';
import 'package:http_request_rest_api_flutter/pages/movie_upcoming.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            PopularMovie(),
            UpcomingMovie(),
          ],
        ),
      ),
    );
  }
}
