import 'package:flutter/material.dart';

class screen_detail extends StatefulWidget {
  String name;
  String image ;
  int totalCases, totalRecovered, totalDeaths, active, critical, test, todayRecovered;
   screen_detail({super.key,
     required this.name,
     required this.image,
     required this.active,
     required this.critical,
     required this.test,
     required this.todayRecovered,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered

   });

  @override
  State<screen_detail> createState() => _screen_detailState();
}

class _screen_detailState extends State<screen_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .06),
                      reuse(title: 'cases', value: widget.totalCases.toString()),
                      reuse(title: 'recovered', value: widget.totalRecovered.toString()),
                      reuse(title: 'active', value: widget.active.toString()),
                      reuse(title: 'tests', value: widget.test.toString()),
                      reuse(title: 'deaths', value: widget.totalDeaths.toString()),
                      reuse(title: 'critical', value: widget.critical.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
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