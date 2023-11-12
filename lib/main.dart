import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nationality/cubits/nationality/nationality_cubit.dart';
import 'package:nationality/cubits/number_of_requests/number_of_requests_cubit.dart';
import 'package:nationality/models/nationality.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<NationalityCubit>(
          create: (context) => NationalityCubit(),
        ),
        BlocProvider<NumberOfRequestsCubit>(
          create: (context) => NumberOfRequestsCubit(
              nationalityCubit: context.read<NationalityCubit>()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Find the nationality",
          home: Material(
              child: Container(
                  padding: EdgeInsets.all(100.0),
                  color: Colors.white,
                  child: Container(
                    child: Center(
                        child: Column(children: [
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      TextNumberOfRequests(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Enter your name',
                        style: TextStyle(
                            color: hexToColor("#F2A03D"), fontSize: 25.0),
                      ),
                      Padding(padding: EdgeInsets.only(top: 30.0)),
                      Forma(),
                      Padding(padding: EdgeInsets.only(top: 30.0)),
                      Text(
                        'Results',
                        style: TextStyle(
                            color: hexToColor("#F2A03D"), fontSize: 25.0),
                      ),
                      BlocBuilder<NationalityCubit, NationalityState>(
                        builder: (context, state) {
                          if (state.nationality.country!.isEmpty) {
                            return Text('No results');
                          } else {
                            return ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      FadeInImage.memoryNetwork(
                                        height: 50,
                                        placeholder: kTransparentImage,
                                        image:
                                            'https://flagsapi.com/${state.nationality.country![index].countryId.toString()}/flat/64.png',
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        '${state.nationality.country![index].countryId.toString()}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                          '${(state.nationality.country![index].probability! * 100).round()} %',
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 10,
                                    ),
                                itemCount: state.nationality.country!.length);
                          }
                        },
                      )
                    ])),
                  )))),
    );
  }
}

class TextNumberOfRequests extends StatelessWidget {
  const TextNumberOfRequests({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Number of API requests: ${context.watch<NumberOfRequestsCubit>().state.requestsNumber}',
      style: TextStyle(color: Colors.teal, fontStyle: FontStyle.italic),
    );
  }
}

class Forma extends StatelessWidget {
  const Forma({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        fetchNationality(value).then((value) =>
            context.read<NationalityCubit>().emitNewNationality(value));
      },
      decoration: InputDecoration(
        labelText: "Enter name",
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
        //fillColor: Colors.green
      ),
      validator: (val) {
        if (val!.length == 0) {
          return "Email cannot be empty";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontFamily: "Poppins",
      ),
    );
  }
}

Future<Nationality> fetchNationality(String name) async {
  final response =
      await http.get(Uri.parse('https://api.nationalize.io/?name=${name}'));

  if (response.statusCode == 200) {
    return Nationality.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}
