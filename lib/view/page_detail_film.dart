import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class FilmDetail extends StatefulWidget {
  final String imdbID;

  FilmDetail({required this.imdbID});

  @override
  _FilmDetailState createState() => _FilmDetailState();
}

class _FilmDetailState extends State<FilmDetail> {
  Map<String, dynamic>? filmData;

  @override
  void initState() {
    super.initState();
    fetchFilmDetails();
  }

  Future<void> fetchFilmDetails() async {
    final apiKey = 'd473c7d2';
    final url = 'http://www.omdbapi.com/?i=${widget.imdbID}&apikey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        filmData = data;
      });
    } else {
      print('error fetch detail film');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (filmData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detail Film'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      final title = filmData!['Title'];
      final director = filmData!['Director'];
      final description = filmData!['Plot'];
      final genre = filmData!['Genre'];
      final release = filmData!['Released'];
      final actors = filmData!['Actors'];
      final year = filmData!['Year'];
      final runtime = filmData!['Runtime'];

      return Scaffold(
        appBar: AppBar(
          title: Text('Film Detail'),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                filmData!['Poster'],
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
              SizedBox(height: 20.0),
              Text(
                title,
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Director: $director',
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Genre: $genre',
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Release: $release',
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Actors: $actors',
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Year: $year',
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Runtime: $runtime',
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                description,
                style: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
