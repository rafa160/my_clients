import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/components/client_card_component.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_button.dart';
import 'package:my_clients_by_anduril/components/custom_date_form.dart';
import 'package:my_clients_by_anduril/components/custom_linear_progress_indicator.dart';
import 'package:my_clients_by_anduril/components/custom_search_bar.dart';
import 'package:my_clients_by_anduril/components/icon_notification_button.dart';
import 'package:my_clients_by_anduril/components/search_dialog.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/screens/client/client_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class ClientScreen extends StatefulWidget {
  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var clientBloc = ClientModule.to.getBloc<ClientBloc>();
  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      child: Text('Clientes Cadastrados.',style: headerWhiteText,)),
                ),
              ),
            ),
            CustomAnimatedContainer(
              position: 2,
              milliseconds: 1000,
              horizontalOffset: -50,
              widget: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: background,
                child: Row(
                  children: [
                    Flexible(
                      flex: 8,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomSearchBar(
                            onTap: () async {
                              final search = await showDialog(
                                context: context,
                                builder: (_) =>
                                    SearchDialog(clientBloc.searchClientKey),
                              );
                              if (search != null) {
                                setState(() {
                                  clientBloc.searchClientKey = search;
                                });
                              }
                            },
                            text: clientBloc.searchClientKey.isEmpty
                                ? 'Pesquisar'
                                : clientBloc.searchClientKey,
                          )),
                    ),
                    Flexible(
                      flex: 1,
                      child: StreamBuilder(
                        initialData: [],
                        stream: clientBloc.lengthClient,
                        builder: (context, snapshot) {
                          switch(snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return CustomColorLinearProgressIndicator();
                            default:
                          }
                          return IconNotification(
                            icon: FaIcon(
                              FontAwesomeIcons.bell,
                              color: whiteColor,
                              size: 30,
                            ),
                            onTap: () async {
                              await clientBloc.getClientsWithKeyListByEmployeeId(employeeId: userBloc.user.id);
                            },
                            notification: '${snapshot.data}',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                FutureBuilder(
                  future: clientBloc.getClientsWithKeyListByEmployeeId(employeeId: userBloc.user.id),
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
                        itemCount: clientBloc.filteredClientWithKeyList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          ClientModel model = snapshot.data[index];
                          return CustomAnimatedContainer(
                            position: index,
                            milliseconds: 1200,
                            verticalOffset: 50,
                            widget: ClientCardComponent(
                              clientModel: model,
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
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
