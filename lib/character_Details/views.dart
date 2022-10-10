import 'dart:math';

import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Full_Character.dart';

class CharacterDetailsView extends StatefulWidget {
  const CharacterDetailsView({Key? key, required this.charID}) : super(key: key);

  final int charID;

  @override
  State<CharacterDetailsView> createState() => _CharacterDetailsViewState();
}

class _CharacterDetailsViewState extends State<CharacterDetailsView> {
  bool isLoading=true;
  FullCharacter? fullCharacter;
  @override
  void initState() {
    getData();
    super.initState();


  }
  void getData() async{

    final response= await Dio().get("https://www.breakingbadapi.com/api/characters/${widget.charID}");
    print(response.data);


    fullCharacter=FullCharacter(
      birthday:response.data[0]["birthday"],
      status: response.data[0]["status"],
      nickname: response.data[0]["nickname"],
      name: response.data[0]["name"],
      image: response.data[0]["img"],
      id:response.data[0]["char_id"],
    );


    isLoading=false;
    setState(() {});

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(" DETAILS",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: isLoading ? Center (child: CircularProgressIndicator(color: Colors.black,)) : ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [


              SizedBox(height: 5,),
              Container(

                  child: Image.network(fullCharacter!.image,height: 250,width: 400,)),

              SizedBox(height: 25,),

              Row(
mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [ Text("Name:",style: TextStyle(fontSize: 20),),
                    SizedBox(width: 5,),
                    Text( fullCharacter!.name ,style: TextStyle(fontSize: 20),)]),
              SizedBox(height: 5,),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("Nickname:",style: TextStyle(fontSize: 20),),
                    SizedBox(width: 5,),
                    Text(fullCharacter!.nickname,style: TextStyle(fontSize: 20))]),
              SizedBox(height: 5,),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("Birthday:",style: TextStyle(fontSize: 20),),
                    SizedBox(width: 5,),
                    Text(fullCharacter!.birthday,style: TextStyle(fontSize: 20))]),
              SizedBox(height: 5,),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("Status:",style: TextStyle(fontSize: 20),),
                    SizedBox(width: 5,),
                    Text(fullCharacter!.status,style: TextStyle(fontSize: 20))]),
              SizedBox(height: 5,),


            ],
          ),
        ],


      ),


    );
  }
}
