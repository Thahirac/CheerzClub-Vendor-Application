
import 'package:flutter/material.dart';

class OutPutPage extends StatefulWidget {
  final String? usersectret;

  const OutPutPage({Key? key,this.usersectret}) : super(key: key);

  @override
  State<OutPutPage> createState() => _OutPutPageState();
}

class _OutPutPageState extends State<OutPutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Output Page"),centerTitle: true,),

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Out Put:${widget.usersectret}"),
          ],
        ),
      ),
    );
  }
}