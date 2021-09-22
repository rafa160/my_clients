import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/bloc/date_bloc.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/components/client_card_component.dart';
import 'package:my_clients_by_anduril/components/client_card_info.dart';
import 'package:my_clients_by_anduril/components/custom_alert_dialog.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_button.dart';
import 'package:my_clients_by_anduril/components/custom_date_form.dart';
import 'package:my_clients_by_anduril/components/custom_linear_progress_indicator.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/screens/client/client_details/client_details_module.dart';
import 'package:my_clients_by_anduril/screens/home/home_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var userBloc = AppModule.to.getBloc<UserBloc>();
  var dateBloc = HomeModule.to.getBloc<DateBloc>();
  var clientBloc = HomeModule.to.getBloc<ClientBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAnimatedContainer(
              position: 1,
              milliseconds: 1000,
              horizontalOffset: 50,
              widget: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                color: background,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                      child: Text('Olá, ${userBloc.user.name}.',style: headerWhiteText,)),
                ),
              ),
            ),
            CustomAnimatedContainer(
                position: 2,
                milliseconds: 1200,
                horizontalOffset: 50,
                widget:Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: dateBloc.streamActualDay,
                      builder: (context, snapshot){
                        return Text('Visitas para ${snapshot.data}.',style: titleForms,);
                      },
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: clientBloc.getTodaysClientList(id: userBloc.user.id),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CustomColorLinearProgressIndicator(),
                    );
                  default:
                }
                return AnimationLimiter(
                  child: Container(
                    height: 140,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: clientBloc.todaysClientsList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        ClientModel model = snapshot.data[index];
                        return CustomAnimatedContainer(
                          position: index,
                          milliseconds: 1200,
                          verticalOffset: 50,
                          widget: ClientCardInfo(
                            client: model,
                            onTap: () async {
                              Get.to(() => ClientDetailsModule(model));
                            },
                            onLongPress: () {
                              showDialog(context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Deseja atualizar a data de sua visita?',style: titleForms,),
                                      content: FormBuilder(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Escolha a próxima Data', style: cardBottomText,),
                                            CustomAnimatedContainer(
                                              milliseconds: 200,
                                              horizontalOffset: -50,
                                              position: 10,
                                              widget: CustomDateForm(
                                                text: 'next_visit',
                                                initialValue: model.nextVisit,
                                                enabled: true,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CustomAnimatedContainer(
                                              milliseconds: 200,
                                              horizontalOffset: -50,
                                              position: 10,
                                              widget: CustomButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState.validate()) {
                                                    _formKey.currentState.save();
                                                    await clientBloc.updateDate(
                                                        context: context,
                                                        dateTime: _formKey.currentState.value['next_visit'],
                                                        id: model.id
                                                    );
                                                  }
                                                },
                                                widget: Text('Atualizar', style: buttonColors,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                            },
                          )
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            CustomAnimatedContainer(
              position: 3,
              milliseconds: 1200,
              horizontalOffset: -50,
              widget:Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder(
                      stream: dateBloc.streamActualMonth,
                      builder: (context, snapshot){
                        return Text('Visitas para o mês de ${snapshot.data}.',style: titleForms,);
                      },
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: clientBloc.getMonthVisitsClientList(id: userBloc.user.id),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CustomColorLinearProgressIndicator(),
                    );
                  default:
                }
                return AnimationLimiter(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: clientBloc.monthVisitsClientsList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        ClientModel model = snapshot.data[index];
                        return CustomAnimatedContainer(
                          position: index,
                          milliseconds: 1200,
                          verticalOffset: 50,
                          widget: ClientCardComponent(
                            clientModel: model,
                            onLongPress: () async {
                            },
                          ),
                        );
                      },
                    ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
