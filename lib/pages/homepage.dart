import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/Models/const.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final WeatherFactory _wf = WeatherFactory(Weather_Api);
  Weather? _weather;
  String cityName = "";
  final TextEditingController _controller = TextEditingController();

  String imageAsset = 'assets/images/Sunshine.png';

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() async {
    final weather = await _wf.currentWeatherByCityName(cityName);
    setState(() {
      _weather = weather;
      updateImage();
    });
  }

  void _onSearch() {
    setState(() {
      cityName = _controller.text;
    });
    _fetchWeather();
  }

  void updateImage() {
    if (_weather != null) {
      switch (_weather!.weatherDescription?.toLowerCase()) {
        case 'clear sky':
          imageAsset = 'assets/images/clear_sky.png';
          break;
        case 'few clouds':
        case 'scattered clouds':
          imageAsset = 'assets/images/Cloudy_sky.png';
          break;
        case 'broken clouds':
        case 'overcast clouds':
          imageAsset = 'assets/images/Cloudy_sky.png';
          break;
        case 'shower rain':
          imageAsset = 'assets/images/Untitled design.png';
          break;
        case 'rain':
        case 'moderate rain':
        case 'Rain':
          imageAsset = 'assets/images/Untitled design.png';
          break;
        case 'clear':
          imageAsset = 'assets/images/clear_sky.png';
        case 'smoke':
          imageAsset = 'assets/images/Smoky.png';
        case 'mist':
          imageAsset = 'assets/images/Mist.png';
        case 'haze':
          imageAsset = 'assets/images/Haze.png';
        default:
          imageAsset = 'assets/images/Sunshine.png';
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    String dateFormat = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    return Scaffold(
      body: Stack(
          children: [
      Container(
      decoration: BoxDecoration( image: DecorationImage(
          image: AssetImage(imageAsset),
           fit: BoxFit.cover,),
           ),
           ),
            SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100,),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Enter city name',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),  // Focused border
                            borderRadius: BorderRadius.circular(5),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search, color: Colors.black),
                            onPressed: _onSearch,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  location(),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                dateFormat,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontStyle:FontStyle.italic,

                ),
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_weather?.temperature?.celsius?.toStringAsFixed(1) ?? "--"}°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20,),
                  SizedBox(width: 20,
                  child: Container(
                    height: 70,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.white, // Set the color of the border
                            width: 1.0,          // Set the width of the border
                          ),
                        ),
                      ),
                  ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 20,),
                          Text(
                            _weather?.weatherMain ?? "Loading...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            'Humidity: ${_weather?.humidity?.toString() ?? "--"}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Pressure: ${_weather?.pressure?.toStringAsFixed(1) ?? "--"} mm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              SizedBox(height: 50,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: Colors.black38,
                    width: 2.0,
                  ),
                ),
                height: 100,
                width: 350,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Max Temperature', style: TextStyle(color: Colors.white, fontSize: 20),),
                            Icon(Icons.wb_incandescent_outlined, color: Colors.white,size: 25,),
                            Text(
                              ' ${_weather?.tempMax?.celsius?.toStringAsFixed(1) ?? "--"}°C',
                              style:TextStyle(color: Colors.white, fontSize: 20) ,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Min Temperature', style: TextStyle(color: Colors.white, fontSize: 20),),
                            Icon(Icons.wb_incandescent_outlined, color: Colors.white,size: 25,),
                            Text(
                              ' ${_weather?.tempMin?.celsius?.toStringAsFixed(1) ?? "--"}°C',
                              style:TextStyle(color: Colors.white, fontSize: 20) ,
                            ),
                          ],
                        ),
                      ),
                      ],
                      ),
                      ),
                      ),
              SizedBox(height: 30,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: Colors.black38,
                    width: 2.0,
                  ),
                ),
                height: 100,
                width: 350,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Feels Like', style: TextStyle(color: Colors.white, fontSize: 20),),
                            Icon(Icons.wb_incandescent_outlined, color: Colors.white,size: 25,),
                            Text(
                              '${_weather?.tempFeelsLike?.celsius?.toStringAsFixed(1)?? "--"}°C',
                              style:TextStyle(color: Colors.white, fontSize: 20) ,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Wind Velocity', style: TextStyle(color: Colors.white, fontSize: 20),),
                            Icon(Icons.wind_power_outlined, color: Colors.white,size: 25,),
                            Text(
                              ' ${_weather?.tempMax?.celsius?.toStringAsFixed(1) ?? "--"} km/h',
                              style:TextStyle(color: Colors.white, fontSize: 20) ,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }

  Widget location() {
    return Text(
      _weather?.areaName ?? "Loading...",
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }
}
