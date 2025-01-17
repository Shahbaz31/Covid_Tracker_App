import 'package:covid19_tracker/services/stats_services.dart';
import 'package:covid19_tracker/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatServices statServices = StatServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 30,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body:  SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchcontroller,
                decoration: InputDecoration(
                    hintText: 'Search any Country name',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),

                  )
                ),
              ),
            ),
            Expanded(
                child:
                FutureBuilder(
                  future: statServices.CountrieslistApi() ,
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                    if (!snapshot.hasData){
                      return  ListView.builder(
                          itemCount: 15,
                          itemBuilder: (context,index){
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor:  Colors.grey.shade700,
                              child: Column(
                                children: [
                                  ListTile(
                                    title:Container(height: 10,width: 70,color: Colors.white,),
                                    subtitle:Container(height: 10,width: 70,color: Colors.white,),
                                    leading: Container(height: 30,width: 30,color: Colors.white,),
                                  )
                                ],
                              ),
                            );

                          });

                    }
                    else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){

                            String name=snapshot.data![index]['country'];

                            if(searchcontroller.text.isEmpty){
                              return Column(
                                children: [

                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> screen_detail(

                                            name: snapshot.data![index]['countryInfo']['flag'],
                                            image: snapshot.data![index]['country'],
                                            totalCases: snapshot.data![index]['cases'],
                                            todayRecovered: snapshot.data![index]['todayRecovered'],
                                            active: snapshot.data![index]['active'],
                                            test: snapshot.data![index]['tests'],
                                            totalDeaths: snapshot.data![index]['deaths'],
                                            totalRecovered: snapshot.data![index]['recovered'],
                                            critical: snapshot.data![index]['critical'],


                                      )));
                              },
                                    child: ListTile(
                                      title:Text(snapshot.data![index]['country']),
                                      subtitle:Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                          height:50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            }
                            else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> screen_detail(

                                        name: snapshot.data![index]['countryInfo']['flag'],
                                        image: snapshot.data![index]['country'],
                                        totalCases: snapshot.data![index]['cases'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        active: snapshot.data![index]['active'],
                                        test: snapshot.data![index]['tests'],
                                        totalDeaths: snapshot.data![index]['deaths'],
                                        totalRecovered: snapshot.data![index]['recovered'],
                                        critical: snapshot.data![index]['critical'],


                                      )));
                                    },
                                    child: ListTile(
                                      title:Text(snapshot.data![index]['country']),
                                      subtitle:Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                          height:50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            }
                            else{
                              return Container();
                            }

                      });
                    }
                  },
                ))
          ],
        ),
      ),

    );
  }
}
