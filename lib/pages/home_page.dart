import 'package:flutter/material.dart';
import 'package:retake_exam6/models/model.dart';
import 'package:retake_exam6/pages/detail_page.dart';

import '../services/http_service.dart';
class HomePage extends StatefulWidget {
  static const String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BankingAppModel>_bankList  = [];

  @override
  void initState() {
    // TODO: implement initState
    apiGetUserList();
  }
  void apiGetUserList() async {
    HttpService.GET(HttpService.API_USER_LIST, HttpService.paramEmpty()).then((response) {
      if(response != null) {
        print(response);
        parseResponse(response);
      }
    });
  }

  void parseResponse(String response){
setState(() {
  _bankList = HttpService.parseUserList(response);
});
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
