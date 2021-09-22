import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_clients_by_anduril/helpers/utils.dart';
import 'package:my_clients_by_anduril/models/client_model.dart';
import 'package:my_clients_by_anduril/screens/client/client_details/client_details_module.dart';
import 'package:my_clients_by_anduril/screens/prospect_clients/prospect_client_details/prospect_client_details_module.dart';
import 'package:my_clients_by_anduril/styles/style.dart';

class ClientCardComponent extends StatelessWidget {

  final ClientModel clientModel;
  final VoidCallback onLongPress;

  const ClientCardComponent({Key key, this.clientModel, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = formattedDate(clientModel.createdTime);
    String visit = formattedDate(clientModel.nextVisit != null ? clientModel.nextVisit : clientModel.createdTime);
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(20)
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex:3,
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child:CircleAvatar(
                            backgroundColor: background,
                            child:  FaIcon(
                              FontAwesomeIcons.userCircle,
                              size: 30,
                              color: Colors.white,
                            ),
                            radius: 30,
                          )
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              clientModel.company,
                            style: tittleCardText,
                          ),
                          Text(
                              clientModel.name,
                            style: tittleCardText,
                          ),
                          Text(
                              clientModel.phone,
                            style: tittleCardText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              clientModel.status.index == 0 ? Text(date, style: dateText,) : Text(visit, style: dateText,),
                              Spacer(),
                              Text(clientModel.statusText, style: cardBottomText,),
                              Spacer(),
                              GestureDetector(
                                onTap: clientModel.status.index == 0 ? () {
                                  Get.to(() => ProspectClientDetailsModule(clientModel));
                                } : () {
                                  Get.to(() => ClientDetailsModule(clientModel));
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color:  Color(0xff4F46E5),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20)),
                                  ),
                                  child: Center(child: Text('detalhes', style: actionButton,)),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
