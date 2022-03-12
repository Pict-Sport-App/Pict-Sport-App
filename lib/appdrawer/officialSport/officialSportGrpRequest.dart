import 'package:flutter/material.dart';
import 'package:psa/appdrawer/officialSport/bbOfficial.dart';
import 'package:psa/widget/constants.dart';

class OfficialSportGrpReq extends StatelessWidget {
  const OfficialSportGrpReq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Official Sport Group Request'),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kkbackgroundImage),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            OffWidget(name: 'BasketBall',
            onTap: (){
              Navigator.of(context).pushNamed(
                Official.routeName,
                arguments:'Official BasketBall'
              );
            }, icon: '🏀',),
            OffWidget(name: 'VolleyBall',
              onTap: (){
                Navigator.of(context).pushNamed(
                    Official.routeName,
                    arguments:'Official VolleyBall'
                );}, icon: '🏐',),
            OffWidget(name: 'TableTennis',
              onTap: (){
                Navigator.of(context).pushNamed(
                    Official.routeName,
                    arguments:'Official TableTennis'
                );}, icon: '🎾',),
            OffWidget(name: 'Badminton',
              onTap: (){
                Navigator.of(context).pushNamed(
                    Official.routeName,
                    arguments:'Official Badminton'
                );}, icon: '🏸',),
            OffWidget(name: 'Cricket',
              onTap: (){
                Navigator.of(context).pushNamed(
                    Official.routeName,
                    arguments:'Official Cricket'
                );}, icon: '🏏',),
            OffWidget(name: 'FootBall',
              onTap: (){
                Navigator.of(context).pushNamed(
                    Official.routeName,
                    arguments:'Official FootBall'
                );}, icon: '⚽',),
            OffWidget(name: 'Chess',
              onTap: (){
                Navigator.of(context).pushNamed(
                    Official.routeName,
                    arguments:'Official Chess'
                );}, icon: '♟',),
            OffWidget(name: 'Gym',
              onTap: (){
                Navigator.of(context).pushNamed(
                    Official.routeName,
                    arguments:'Official Gym'
                );}, icon: '💪',),
          ],
        ),
      ),
    );
  }
}

class OffWidget extends StatelessWidget {
  final String icon,name;
  final VoidCallback onTap;
  const OffWidget({Key? key,required this.onTap,
  required this.name,
  required this.icon}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children:  [
            Text(icon,style: const TextStyle(
              fontSize: 20
            ),),
            const SizedBox(width: 20,),
            Text(name,style: const TextStyle(
                fontSize: 20
            ))
          ],
        ),
      ),
    );
  }
}
