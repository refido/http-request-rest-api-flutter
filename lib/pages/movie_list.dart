import 'package:flutter/material.dart';
import 'package:http_request_rest_api_flutter/services/http_service.dart';
import 'movie_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieList> {
  late int moviesCount;
  late List movies;
  late HttpService service;
  final String imgPath = 'https://image.tmdb.org/t/p/w185';

  Future initialize() async {
    movies = [];
    movies = (await service.getPopularMovies())!;
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
      ),
      body: CarouselSlider.builder(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.width,
          viewportFraction: 0.8,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        itemCount: moviesCount,
        itemBuilder: (BuildContext context, int position, int itemIndex) =>
            Expanded(
          child: Card(
            color: Colors.purple[200],
            elevation: 2.0,
            child: ListTile(
              leading: Container(
                width: 100.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(imgPath + movies[position].posterPath),
                  ),
                ),
              ),
              title: Text(movies[position].title),
              subtitle: Text(
                'Rating = ${movies[position].voteAverage}',
              ),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) => MovieDetail(movies[position]));
                Navigator.push(context, route);
              },
            ),
          ),
        ),
      ),
    );
  }
}
