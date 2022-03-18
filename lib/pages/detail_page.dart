import 'package:flutter/material.dart';
import 'package:retake_exam6/models/model.dart';
import 'package:retake_exam6/pages/home_page.dart';
import 'package:retake_exam6/services/http_service.dart';
class DetailPage extends StatefulWidget {
  static const String id = "detail_page";
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _relationController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
void _apiPost(){
  String name = _nameController.text.trim().toString();
  String relation = _relationController.text.trim().toString();
  String phoneNum = _phoneNumController.text.trim().toString();
  if(name.isNotEmpty|| relation.isNotEmpty||phoneNum.isNotEmpty){
    BankingAppModel bankingAppModel = BankingAppModel(
        relation: relation,
        phoneNum: phoneNum,
        name: name,
        id: "");
    HttpService.POST(HttpService.API_CREATE_USER, HttpService.paramsCreate(bankingAppModel));
    Navigator.pushReplacementNamed(context, HomePage.id);
  }


}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 300,),
              Container(
                padding: EdgeInsets.all(10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade200,
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText: "name"
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(                padding: EdgeInsets.all(10),

                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade200,
                ),
                child: TextField(
                  controller: _relationController,
                  decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: "Relationship"
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),

                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade200,
                ),
                child: TextField(
                  controller: _phoneNumController,
                  decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: "Phone Number"
                  ),
                ),
              ),
              SizedBox(height: 300,),
              MaterialButton(
                height: 50,
                minWidth: 150,
                color: Colors.blueAccent.shade700,
                child: Text("Save",style: TextStyle(color: Colors.white),),
                shape: StadiumBorder(),
                  onPressed: (){
_apiPost();
                  })



            ],
          ),
        ),
      ),
    );
  }
}
