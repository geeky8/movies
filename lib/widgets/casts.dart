import 'package:flutter/material.dart';
import 'package:movies/bloc/get_casts_bloc.dart';
import 'package:movies/elements/error.dart';
import 'package:movies/elements/loading.dart';
import 'package:movies/model/cast.dart';
import 'package:movies/model/cast_response.dart';
import 'package:movies/style/theme.dart' as Style;

class Casts extends StatefulWidget {
  final int id;

  Casts({Key key,@required this.id}): super(key: key);
  @override
  _CastsState createState() => _CastsState(id);
}

class _CastsState extends State<Casts> {
  final int id;

  _CastsState(this.id);

  @override
  void initState() {
    castBloc.getcast(id);
    super.initState();
  }
  @override
  void dispose() {
    castBloc.drainStream();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 10,top: 20,),
            child: Text(
              "CASTS",
              style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
        ),
        SizedBox(height: 5,),
        StreamBuilder<CastResponse>(
          stream: castBloc.subject.stream,
          builder: (context,AsyncSnapshot<CastResponse> snapshot){
            if(snapshot.hasData){
              if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                return buildError(snapshot.data.error);
              }
              return _buildCast(snapshot.data);
            }
            else if(snapshot.hasError){
              return buildError(snapshot.error);
            }
            else{
              return buildLoading();
            }
          },
        ),
      ],
    );
  }
  Widget _buildCast(CastResponse data){
    List<Cast> cast = data.cast;
    return Container(
      height: 140,
      padding: EdgeInsets.only(left: 10,),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cast.length,
          itemBuilder: (context,index){
            return Container(
              padding: EdgeInsets.only(top: 10,right: 8,),
              width: 100,
              child: GestureDetector(
                onTap: (){},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w300/"+cast[index].img),fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      cast[index].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      cast[index].character,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Style.Colors.titleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 7,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}
