import 'package:covid19_tracker/services/stats_services.dart';
import 'package:covid19_tracker/view/CountriesListScreen.dart';
import 'package:covid19_tracker/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/Worldstats.dart';

class world_stats extends StatefulWidget {
  const world_stats({super.key});

  @override
  State<world_stats> createState() => _world_statsState();
}

class _world_statsState extends State<world_stats>  with TickerProviderStateMixin{

  late final AnimationController _controller =
  AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)
    ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();

  }
  StatServices statServices = StatServices();

  final colorlist= <Color> [
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              const SizedBox(height: 15,),
              FutureBuilder(
                  future: statServices.fetchworldstats() ,
                  builder: (context,AsyncSnapshot<Worldstats> snapshot){
                    if (!snapshot.hasData){
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.black,
                            size: 50,
                            controller: _controller,
                          )
                      );
                    }
                    else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total Cases": double.parse(snapshot.data!.cases.toString()),
                              "Recovered Patients": double.parse(snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(snapshot.data!.deaths.toString()),
                            },
                            animationDuration: const Duration(milliseconds: 1200),
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true
                            ),
                            chartRadius: 150  ,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left
                            ),

                            chartType: ChartType.ring,
                            colorList: colorlist,
                          ),
                          SizedBox(height: 50,),
                          Padding(
                            padding: const EdgeInsets.only(left: 2,right: 2,top: 2,bottom: 2),
                            child: Card(
                                child: Column(
                                  children: [
                                    reuse(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                    reuse(title: 'Total recovered Patients', value: snapshot.data!.recovered.toString()),
                                    reuse(title: 'Total Deaths', value: snapshot.data!.deaths.toString()),
                                    reuse(title: 'Total Active Cases', value: snapshot.data!.active.toString()),
                                    reuse(title: 'Total Affected Countries', value: snapshot.data!.affectedCountries.toString()),


                                  ],
                                )
                            ),
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  CountriesListScreen()));
                    },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: const Center(
                                child: Text('Track Countries'),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
              ),


            ],
          ),
        ),
      ),
    );
  }
}

class reuse extends StatelessWidget {
  String title, value ;
  reuse({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10
      ),
      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          const SizedBox(height: 5,),
          const Divider()

        ],
      ),
    );
  }
}



