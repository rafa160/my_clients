import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/app_module.dart';
import 'package:my_clients_by_anduril/bloc/client_bloc.dart';
import 'package:my_clients_by_anduril/bloc/user_bloc.dart';
import 'package:my_clients_by_anduril/components/client_card_component.dart';
import 'package:my_clients_by_anduril/components/custom_alert_dialog.dart';
import 'package:my_clients_by_anduril/components/custom_animated_container.dart';
import 'package:my_clients_by_anduril/components/custom_color_circular_indicator.dart';
import 'package:my_clients_by_anduril/components/custom_empty_container.dart';
import 'package:my_clients_by_anduril/components/custom_linear_progress_indicator.dart';
import 'package:my_clients_by_anduril/components/custom_search_bar.dart';
import 'package:my_clients_by_anduril/components/icon_notification_button.dart';
import 'package:my_clients_by_anduril/components/search_dialog.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/screens/prospect_clients/new_client/new_client_module.dart';
import 'package:my_clients_by_anduril/screens/prospect_clients/prospect_clients_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class ProspectClientsScreen extends StatefulWidget {
  @override
  _ProspectClientsScreenState createState() => _ProspectClientsScreenState();
}

class _ProspectClientsScreenState extends State<ProspectClientsScreen> {
  var clientBloc = ProspectClientsModule.to.getBloc<ClientBloc>();
  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  void initState() {
    // clientBloc.getProspectsListByEmployeeId(employeeId: userBloc.user.id);
    // clientBloc.filteredList;
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
                      child: Text(
                        'Clientes em Prospecção.',
                        style: headerWhiteText,
                      )),
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
                                    SearchDialog(clientBloc.searchProspect),
                              );
                              if (search != null) {
                                setState(() {
                                  clientBloc.searchProspect = search;
                                });
                              }
                            },
                            text: clientBloc.searchProspect.isEmpty
                                ? 'Pesquisar'
                                : clientBloc.searchProspect,
                          )),
                    ),
                    Flexible(
                      flex: 1,
                      child: StreamBuilder(
                        initialData: [],
                        stream: clientBloc.lengthProspect,
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
                              await clientBloc.getProspectsListByEmployeeId(employeeId: userBloc.user.id);
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
            FutureBuilder(
              future: clientBloc.getProspectsListByEmployeeId(employeeId: userBloc.user.id),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CustomColorLinearProgressIndicator(),
                    );
                  default:
                } if(!snapshot.hasData) {
                  return CustomEmptyContainer(
                    onTap: () async {
                      clientBloc.getProspectsListByEmployeeId(employeeId: userBloc.user.id);
                    },
                  );
                } else {
                  return AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: clientBloc.filteredList.length,
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
                              print('deletar');
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomAlertDialog(
                                      title: 'Deseja deletar o prospecto ${model.company}?',
                                      content: 'Se sim, o item sairá da sua lista.',
                                      yes: () async {
                                        await clientBloc.deleteProspect(model.id, context);
                                        Get.back();
                                      },
                                    );
                                  }
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Get.to(() => NewClientsModule());
        },
        child: FaIcon(FontAwesomeIcons.plus, size: 20, color: background),
      ),
    );
  }
}
