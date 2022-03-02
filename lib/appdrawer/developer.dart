
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';



void main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: Frame1Widget()
    )
  ));
}

class Frame1Widget extends StatefulWidget {
  @override
  _Frame1WidgetState createState() => _Frame1WidgetState();
}

class _Frame1WidgetState extends State<Frame1Widget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              
              child: Row(
                children: [
                  IconButton(onPressed: ()=>{Navigator.pop(context)}, icon:Icon(Icons.arrow_back)),
                  SizedBox(width: width*0.28,),
                  Text('Developers',style: TextStyle(fontSize: 18,color: Colors.white),),
                  
                ],
              ),
              height: height*0.12,
              width:width,
              decoration: BoxDecoration(
                borderRadius : BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(55),
                  bottomRight: Radius.circular(55),
                ),
                color: Colors.indigo[400]
      
              ),
         
            ),
            Expanded(

              child: page(),
            )


          ]
          
          ))
      
    ); }}

    class page extends StatefulWidget {
      const page({ Key? key }) : super(key: key);
    
      @override
      _pageState createState() => _pageState();
    }
    
    class _pageState extends State<page> {

      PageController _pageController=new PageController();
      double view=0.8;
      double offset1=0;
        final _pageNotifier = ValueNotifier(0.0);

  void _Listener(){
    setState(() {
      offset1=_pageController.page!;
    });
  }

     

      @override
      void initState(){
        super.initState();
        _pageController=PageController(initialPage: 0,viewportFraction: view);
        WidgetsBinding.instance!.addPostFrameCallback((_) {
      _pageController.addListener(_Listener);
    });
        
        
      }

       Widget build(BuildContext context) {
            double height = MediaQuery.of(context).size.height;
            double width = MediaQuery.of(context).size.width;
        return PageView.builder(itemCount:dev_list.length ,controller: _pageController,itemBuilder:(context,index){
           double scale=max(view,1-(offset1-index).abs()+view);
           double angle=(offset1-index).abs();
               double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
           if (angle>0.5){
             angle=1-angle;
           }

          
          return Container(
            padding:EdgeInsets.only(
              right: width*0.04,
              left: width*0.04,
              bottom: height*0.18,
              top:(height*0.158)-scale*25
            ),
            
            child: Transform(
              transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(angle),
              alignment: Alignment.center,
              child: Material(
                elevation: 22,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                        
                  
                decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),),
                  color: Colors.deepPurple[200]),
                        
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 35,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          radius: 75,
                          backgroundImage:AssetImage(dev_list[index].img),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(dev_list[index].name,
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(onPressed: () => {launchMailto(dev_list[index].gmailurl)}, icon: Icon(Icons.email)),
                            IconButton(onPressed: () => {_launchURL(dev_list[index].githuburl)}, icon: Icon(FontAwesomeIcons.github)),
                            IconButton(onPressed: () => {_launchURL(dev_list[index].instaurl)}, icon: Icon(FontAwesomeIcons.instagram)),
                            IconButton(onPressed: () => {_launchURL(dev_list[index].linkedinurl)}, icon: Icon(FontAwesomeIcons.linkedin)),
                        
                        
                          ],
                        
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

        });
      }
    }

  _launchURL(String url) async {
    try{
      await launch(url);
       }
       catch(e) {
      print(e);
      print(url);
    }
  }

  launchMailto(String email) async {
    final mailtoLink = Mailto(
      to: [email],
      cc: ['omkar.awaje1012002@gmail.com'],
      subject: 'App Review',
      body: "Just saw the Sports App app.\nMy reviews are\n ",
    );
    await launch('$mailtoLink');
  }


    
    

class devs {
  String name;
  String img;
  String instaurl;
  String githuburl;
  String linkedinurl;
  String gmailurl;
  devs(this.name, this.img, this.instaurl, this.githuburl, this.gmailurl,
      this.linkedinurl);
}

final dev_list = [
  devs(
      'Harshwardhan Atkare',
      'assets/Harshw.jpeg',
      'https://www.instagram.com/atkareharsh/ ',
      'https://github.com/Harshwardhan431 ',
      'mailto:atkareharsh@gmail.com ',
      'https://www.linkedin.com/in/harshwardhan-atkare-49a9961bb/'),
  devs(
      'Dhiraj Darakhe',
      'assets/Dhiraj.jpeg',
      'https://www.instagram.com/dhiraj_darakhe/',
      'https://github.com/dhirajdarakhe',
      'mailto:dhirajdarakhe03@gmail.com',
      'https://www.linkedin.com/in/dhiraj-darakhe-751201215'),
  devs(
      'Atharva Bhadange',
      'assets/Atharv.jpeg',
      'https://www.instagram.com/bhadange_atharv/',
      'https://github.com/atharv-bhadange',
      'mailto:bhadange.atharv@gmail.com',
      'https://www.linkedin.com/in/atharv-bhadange-9817521ba/'),
  devs(
      'Omkar Awaje',
      'assets/omkar.png',
      'https://www.instagram.com/_omkaarrr_/',
      'https://github.com/OmkarAwaje',
      'mailto:omkar.awaje1012002@gmail.com',
      'https://www.linkedin.com/in/omkar-awaje-8239341b3'),
];
