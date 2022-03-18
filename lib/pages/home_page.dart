import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retake_exam6/models/model.dart';
import 'package:retake_exam6/pages/detail_page.dart';
import 'package:retake_exam6/services/hive_service.dart';

import '../services/http_service.dart';
class HomePage extends StatefulWidget {
  static const String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BankingAppModel>_bankList  = [];

  ConnectivityResult _connectionStatus = ConnectivityResult.values[0];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override

  void apiGetUserList() async {
    HttpService.GET(HttpService.API_USER_LIST, HttpService.paramEmpty()).then((response) {
      if(response != null || _connectionStatus==ConnectivityResult.wifi|| _connectionStatus == ConnectivityResult.mobile) {
        print(response);
        setState(() {
          _bankList = HttpService.parseUserList(response!);
          HiveDB.storeSavedCards(_bankList);
        });

      }else if (_connectionStatus == ConnectivityResult.none) {
        setState(() {
          _bankList = HiveDB.loadSavedCards();
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity().then((value) => apiGetUserList());
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if ((_connectionStatus == ConnectivityResult.wifi ||
        _connectionStatus == ConnectivityResult.mobile) &&
        HiveDB.loadNoInternetCards().isNotEmpty) {
      for (int i = 0; i < HiveDB.loadNoInternetCards().length; i++) {
        await HttpService.POST(HttpService.API_CREATE_USER,
            HttpService.paramsCreate(HiveDB.loadNoInternetCards()[i]));
      }
      HiveDB.storeNoInternetCards([]);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(
  height: MediaQuery.of(context).size.height,
  width: MediaQuery.of(context).size.width,
  child:   ListView.builder(
    shrinkWrap: true,
    itemCount: _bankList.length,
    itemBuilder: (BuildContext context, int index) {
      return  _createList(_bankList[index]); },
  ),
),

floatingActionButton: FloatingActionButton(
  onPressed: (){
    Navigator.of(context).pushReplacementNamed(DetailPage.id);
  },
  backgroundColor: Colors.blueAccent.shade700,
  child: Icon(Icons.add,color: Colors.white,),

),
    );
  }
  Widget _createList(BankingAppModel bankingAppModel){
    return Dismissible(
        key: const ValueKey(0),
    onDismissed: (_)async{
_bankList.remove(bankingAppModel);
await HttpService.DELETE(HttpService.API_DELETE_USER + bankingAppModel.id, HttpService.paramEmpty());


    },
    child: Container(
      padding: EdgeInsets.all(30),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/boy3.jpeg"),
                fit: BoxFit.cover
              )
            ),
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(bankingAppModel.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
            Text(bankingAppModel.phoneNum),

          ],),
          SizedBox(width: 100,),
          Container(alignment: Alignment.center,
              height: 40,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueAccent.shade700,

            ),
            child: Text("Save",style: TextStyle(color: Colors.white),),
          ),

        ],
    ),
        ),

    );
  }
}
