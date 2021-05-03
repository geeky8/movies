import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/bloc/get_person_bloc.dart';
import 'package:movies/elements/error.dart';
import 'package:movies/elements/loading.dart';
import 'package:movies/model/person.dart';
import 'package:movies/model/person_response.dart';
import 'package:movies/style/theme.dart' as Style;

class PersonList extends StatefulWidget {
  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  
  @override
  void initState() {
    personBloc..getPersons();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10,top: 20,),
          child: Text(
            "TRENDING PERSONS THIS WEEK",
            style: TextStyle(
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 5,),
        StreamBuilder<PersonResponse>(
            stream: personBloc.subject.stream,
            builder:(context,AsyncSnapshot<PersonResponse> snapshot){
              if(snapshot.hasData){
                if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                  return buildError(snapshot.data.error);
                }
                return _buildPersons(snapshot.data);
              }
              else if(snapshot.hasError){
                return buildError(snapshot.error);
              }
              else{
                return buildLoading();
              }
            }
        ),
      ],
    );
  }
  Widget _buildPersons(PersonResponse data){
    List<Person> persons = data.person;
    if(persons.length==0){
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NO PERSONS"),
          ],
        ),
      );
    }
    else{
      return Container(
        height: 130,
        padding: EdgeInsets.only(left: 10),
        child: ListView.builder(
            itemCount: persons.length,
            scrollDirection: Axis.horizontal,
            itemBuilder:(context,index){
              return Container(
                width: 100,
                padding: EdgeInsets.only(top: 10,right: 10,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    persons[index].profileImg==null
                    ? Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Style.Colors.secondColor,
                        ),
                        child: Icon(
                          FontAwesomeIcons.userAlt,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w300/"+persons[index].profileImg),fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      persons[index].name,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        fontSize:10,
                      ),
                    ),
                    SizedBox(height: 3,),
                    Text(
                      "Trending for ${persons[index].known}",
                      style: TextStyle(
                        color: Style.Colors.titleColor,
                        fontSize: 7,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              );
            }
        ),
      );
    }
  }
}
