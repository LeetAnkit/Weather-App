import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/api_key.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;
  
  @override
  void initState() {
    
    super.initState();
    _wf.currentWeatherByCityName("Tamil Nadu").then((w){
      setState(() {
        _weather=w;

      });

    });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Colors.purple.shade200,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Weather' ,style: TextStyle(color: Colors.black ),),
        ),

        body: _buildUI(),
      backgroundColor: Colors.purple.shade100,




    );



    // This trailing comma makes auto-formatting nicer for build methods.

  }
  Widget _buildUI(){
    if (_weather ==null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(

      width: MediaQuery.sizeOf(context).width,
      height:  MediaQuery.sizeOf(context).height,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          _locationHeader(),

          SizedBox(
            height: MediaQuery.sizeOf(context).height *0.08,
          ),
          _dateTimeInfo(),

          SizedBox(
            height: MediaQuery.sizeOf(context).height *0.05,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height *0.02,
          ),

          _currTemp(),

          SizedBox(
            height: MediaQuery.sizeOf(context).height *0.02,
          ),
          _extraInfo(),



        ],
      ),

    );

  }
  Widget _locationHeader(){
      return Text(_weather?.areaName ?? "",
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),

      );
  }
  Widget _dateTimeInfo(){
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(DateFormat("h:mm a").format(now),
        style: const TextStyle(
          fontSize: 35,
        ),
        ),

        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
             " ${DateFormat("yMMMd").format(now)} ",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),

      ],
    );

  }
  Widget _weatherIcon(){
     return Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisSize: MainAxisSize.min,

       children: [
         Container(
           height: MediaQuery.sizeOf(context).height *0.20,
           decoration: BoxDecoration(
             image: DecorationImage(image: NetworkImage(
                 "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),)

           ),
         ),
         Text(_weather?.weatherDescription ?? "",
         style: const TextStyle(
           color: Colors.black,
           fontSize: 25,
           fontWeight: FontWeight.w700,
         ),),
       ],



     );

  }

  Widget _currTemp(){
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)} °C" ,
      style:  const TextStyle(
        color: Colors.black,
        fontSize: 70,
        fontWeight: FontWeight.w500,
      ),);
  }
Widget _extraInfo(){

    return Container(

      height: MediaQuery.sizeOf(context).height *0.15,
      width:  MediaQuery.sizeOf(context).width* 0.80,

      
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(21,),
      ),
      padding: const EdgeInsets.all(8.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,
             children: [
               Text("Max : ${_weather?.tempMax?.celsius?.toStringAsFixed(0)} ℃",
               style: const TextStyle(
                 color: Colors.white,
                 fontSize: 18,
                 fontWeight: FontWeight.bold,
               ),),

               Text("Min : ${_weather?.tempMin?.celsius?.toStringAsFixed(0)} ℃",
                 style: const TextStyle(
                   color: Colors.white,
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                 ),)

             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,
             children: [
               Text("WindSpeed: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                 style: const TextStyle(
                   color: Colors.white,
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                 ),),

               Text("Humidity : ${_weather?.humidity?.toStringAsFixed(0)} %",
                 style: const TextStyle(
                   color: Colors.white,
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                 ),)

             ],
           )
         ],
      ),
      

    );

}
}


