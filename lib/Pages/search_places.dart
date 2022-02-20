import 'package:flutter/material.dart';
import 'package:flutter_google_places_web/flutter_google_places_web.dart';

const kGoogleApiKey = "AIzaSyCHlPJMsHXuk5Khs0FbOhGavgKy2BPV5m8";

class SearchPlaces extends StatefulWidget {
  @override
  _SearchPlacesState createState() => _SearchPlacesState();
}

class _SearchPlacesState extends State<SearchPlaces> {
  String test = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 150),
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Address autocomplete',
              ),
              FlutterGooglePlacesWeb(
                apiKey: kGoogleApiKey,
                proxyURL: 'https://cors-anywhere.herokuapp.com/',
                required: true,
              ),
              TextButton(
                onPressed: () {

                  setState(() {
                    test = FlutterGooglePlacesWeb.value['name'] ?? '';
                  });
                },
                child: Text('Press to test'),
              ),
              Text(test),
            ],
          ),
        ),
      ),
    );
  }
}