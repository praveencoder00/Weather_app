import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'add_widget_classes.dart';

class WIHomePage extends StatefulWidget {
  const WIHomePage({super.key});

  @override
  State<WIHomePage> createState() => _WIHomePageState();
}

class _WIHomePageState extends State<WIHomePage> {
  double weatherTemp = 0.0;
  double weatherTempcle = 0;
  dynamic weatherhum = 0;
  dynamic weatherwindspeed = 0;
  dynamic weatherpressure = 0;
  String weathersky = '0';
  IconData weatherIcon = Icons.sunny;
  IconData foreIcon = Icons.sunny;

  // @override
  // void initState() {
  //   super.initState();
  //   getAndShowWether();
  // }

  Future<dynamic> getAndShowWether() async {
    try {
      final weatherResult = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=Madurai&APPID=549ece64a7c98dd0e521f64e643f1936'));
      final decodedResult = jsonDecode(weatherResult.body);

      return (decodedResult);
    } catch (e) {
      throw ('an error occured $e');
    }
  }

  Future<dynamic> getAndShowWether1() async {
    try {
      final weatherResult = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=Madurai&APPID=549ece64a7c98dd0e521f64e643f1936'));
      final decodedResult = jsonDecode(weatherResult.body);

      return (decodedResult);
    } catch (e) {
      throw ('an error occured $e');
    }
  }

  double kelToCel(double input) {
    double finalval = input - 273.15;

    return finalval;
  }

  IconData iconname(String weatsky) {
    IconData finalIcon = Icons.sunny;
    if (weatsky == 'Haze') {
      finalIcon = Icons.waves;
    } else if (weatsky == 'Mist') {
      finalIcon = Icons.waves;
    } else if (weatsky == 'Rain') {
      finalIcon = Icons.cloudy_snowing;
    } else if (weatsky == 'Thunderstorm') {
      finalIcon = Icons.cloudy_snowing;
    } else if (weatsky == 'Drizzle') {
      finalIcon = Icons.cloudy_snowing;
    } else if (weatsky == 'Clouds') {
      finalIcon = Icons.cloud;
    }

    return finalIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getAndShowWether();
                  getAndShowWether1();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
          future: Future.wait([getAndShowWether(), getAndShowWether1()]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            final data = snapshot.data![0];
            final data2 = snapshot.data![1];

            weatherTemp = data['main']['temp'];
            weatherTempcle = kelToCel(weatherTemp);
            weatherhum = data['main']['humidity'];
            weatherpressure = data['main']['pressure'];
            weatherwindspeed = data['wind']['speed'];
            weathersky = data['weather'][0]['main'];
            weatherIcon = iconname(weathersky);

            //to change the icon and condition //forecast
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        elevation: 12,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${weatherTempcle.toStringAsFixed(2)}°C',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Icon(
                                    weatherIcon,
                                    size: 75,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    weathersky,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Weather Forecast',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // const SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       Forecast(
                    //         icon: Icons.cloud,
                    //         condition: 'Rain',
                    //         degree: '303 F',
                    //       ),
                    //       Forecast(
                    //         icon: Icons.wb_sunny_rounded,
                    //         condition: 'Sunny',
                    //         degree: '303 F',
                    //       ),
                    //       Forecast(
                    //         icon: Icons.cloud,
                    //         condition: 'Rain',
                    //         degree: '303 F',
                    //       ),
                    //       Forecast(
                    //         icon: Icons.wb_sunny_rounded,
                    //         condition: 'Sunny',
                    //         degree: '303 F',
                    //       ),
                    //       Forecast(
                    //         icon: Icons.cloud,
                    //         condition: 'Rain',
                    //         degree: '303 F',
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            final DateTime foretime = DateTime.parse(
                                data2['list'][index + 1]['dt_txt']);

                            final String foretimefor =
                                DateFormat.j().format(foretime);
                            final String foretemp = kelToCel(
                                    data2['list'][index + 1]['main']['temp'])
                                .toStringAsFixed(1);
                            final String forecon =
                                data2['list'][index + 1]['weather'][0]['main'];
                            foreIcon = iconname(forecon);
                            return Forecast(
                              icon: foreIcon,
                              condition: forecon,
                              degree: '$foretemp°C', // refresh icon
                              time: foretimefor,
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Additional Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AddInfo(
                          icon: Icons.water_drop,
                          lable: 'Humidity',
                          value: weatherhum.toString(),
                        ),
                        AddInfo(
                          icon: Icons.air,
                          lable: 'Wind Speed',
                          value: weatherwindspeed.toString(),
                        ),
                        AddInfo(
                          icon: Icons.beach_access,
                          lable: 'Air Pressure',
                          value: weatherpressure.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
