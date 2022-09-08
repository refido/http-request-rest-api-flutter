import 'package:flutter/material.dart';
import 'package:http_request_rest_api_flutter/services/http_service_upcoming.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'movie_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UpcomingMovie extends StatefulWidget {
  const UpcomingMovie({super.key});

  @override
  State<UpcomingMovie> createState() => _UpcomingMovieState();
}

class _UpcomingMovieState extends State<UpcomingMovie> {
  late int moviesCount;
  late List movies;
  late HttpService service;
  final String imgPath = 'https://image.tmdb.org/t/p/original';

  Future initialize() async {
    movies = [];
    movies = (await service.getUpcomingMovies())!;
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
    return Column(
      children: [
        const Text(
          "Upcoming",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 350.0,
            viewportFraction: 0.8,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          itemCount: moviesCount,
          itemBuilder: (BuildContext context, int position, int itemIndex) =>
              Column(
            children: [
              GestureDetector(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(movies[position]));
                  Navigator.push(context, route);
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2.0,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            NetworkImage(imgPath + movies[position].posterPath),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(10.0),
                      child: CircularPercentIndicator(
                        radius: 20.0,
                        lineWidth: 2.0,
                        percent: 1,
                        center: Text(
                          '${movies[position].voteAverage}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        progressColor: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  movies[position].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  movies[position].releaseDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
