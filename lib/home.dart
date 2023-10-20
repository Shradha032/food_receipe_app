import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_receipe_app/model.dart';
import 'package:food_receipe_app/search.dart';
import 'package:http/http.dart';
//import 'package:food_recipe_app/search.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  List reciptCatList = [{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"}];
  getRecipes(String query) async {



  // if we are using await keyword then we have to use async
  // we are using a variable name response
  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=c576da1e&app_key=dc4de9cccab9f8e31c134a478969acee";
    //Async function is used as we are getting the data from the server
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {


    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoading = false;
      });
      log(recipeList.toString());
    });
  });

    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    });

    // to fetch all the data quickly we use log(data.toString())
    //so to use log we have to import package that is dart.developer jo ki inbuilt ata hei
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("Chicken");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            //mediaquery automatically detects your phone height and width
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff213A50),
                  Color(0xff071938),
                ])),
          ),
          /*
        * InWell - Tap,DoubleTap,etc.
        * Gesture Detector
        * Hover - Color
        * Tap - Splash
        *
        * Gesture - swipe
        *
        * InWell dikhawa jyada karta hei and kaam kam karta hei but Gesture Detector kaam jyada karta hei dikhawa kaam karta hei
        *
        * Card - elevation background color, radius child
        *
        * ClipRRect - R- round, Rect - rectangle, Koi v round rectangle mein wo clip kar deta hei
        * ClipRRect - Frame - photo
        *
        *ClipPath - Custom Clips
        *
        * positioned - Stack - topleft, top,down,left - 0.0
        **/
          //SingleChildScrollView is used for scrolling the widget
          SingleChildScrollView(
            child: Column(
              children: [
                //search bar
                SafeArea(
                  child: Container(
                    //SEARCH WALA CONTAINER
                    // gradient is the transition between one color to another
                    //there are various types of gradient in flutter like radial gradient, linear gradient, app bar gradient
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank search");
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
                            }
                          },
                          child: Container(
                            child: Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                        ),
                        Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Find your dish"),
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WHAT YOU WANT TO EAT TODAY?",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Let's cook something new!",
                        style:
                        TextStyle(fontSize: 20, color: Colors.limeAccent),
                      )
                    ],
                  ),
                ),
                Container(
                  child: isLoading ? CircularProgressIndicator() : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      //NeverScrollableScrollPhysics here will activate the SingleChildScrollView and limit the ListView.builder which will help to scroll the column widget
                      shrinkWrap: true,
                      itemCount: recipeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            margin: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      recipeList[index].appimgUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    )),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.black26),
                                        child: Text(
                                          recipeList[index].applabel,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ))),
                                Positioned(
                                  right: 0,
                                  width: 80,
                                  height: 40,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)
                                          )
                                      ),

                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Icon(Icons.local_fire_department,
                                              size: 15,),
                                            Text(recipeList[index].appcalories
                                                .toString().substring(0, 6)),
                                          ],
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      })),
                Container(
                    height: 100,
                    child: ListView.builder(
                        itemCount: reciptCatList.length, shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                              child: InkWell(
                                onTap: () {},
                                child: Card(
                                    margin: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    elevation: 0.0,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                18.0),
                                            child: Image.network(
                                              reciptCatList[index]["imgUrl"],
                                              fit: BoxFit.cover,
                                              width: 200,
                                              height: 250,)
                                        ),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            top: 0,
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.black26),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text(
                                                      reciptCatList[index]["heading"],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 28),
                                                    ),
                                                  ],
                                                ))),
                                      ],
                                    )
                                ),
                              )
                          );
                        })),

                Container(
                  height: 100,
                  child: ListView.builder(
                      itemCount: reciptCatList.length, shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                  margin: EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  elevation: 0.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              18.0),
                                          child: Image.network(
                                            reciptCatList[index]["imgUrl"],
                                            fit: BoxFit.cover,
                                            width: 200,
                                            height: 250,)
                                      ),
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          top: 0,
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.black26),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(
                                                    reciptCatList[index]["heading"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 28),
                                                  ),
                                                ],
                                              ))),
                                    ],
                                  )
                              ),

                            )
                        );
                      }),
                )
              ],
            ),
          ),


        ],

      ),


    );
  }
}



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}