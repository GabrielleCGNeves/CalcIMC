import 'dart:async';
import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  String _info = "Informe os seus dados";
  GlobalKey<FormState> _formKey = GlobalKey <FormState>();
  
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  void _resetFields(){
    pesoController.text = '';
    alturaController.text = '';
    setState(() { 
      _info = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular(){
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (kDebugMode) {
        print(imc);
      }

      if (imc < 18.6){
        _info = 'Abixo do peso.(${imc.toStringAsPrecision(3)})';
      }

      else if(imc >= 18.6 && imc < 24.9){
        _info = 'Peso ideal.(${imc.toStringAsPrecision(3)})';
      }

      else if(imc >= 24.9 && imc < 29.9){
        _info = 'Levemente acima do peso ideal.(${imc.toStringAsPrecision(3)})';
      }

      else if(imc >= 29.9 && imc < 34.9){
        _info = 'Obesidade Grau I.(${imc.toStringAsPrecision(3)})';
      }

      else if(imc >= 34.9 && imc < 39.9){
        _info = 'Obesidade Grau II.(${imc.toStringAsPrecision(3)})';
      }

      else{
        _info = 'Obesidade Grau III.(${imc.toStringAsPrecision(3)}';
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Calcula IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget> [
            IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, 
              children: <Widget>[
                const Icon(Icons.person_2_outlined, 
                size: 120,
                color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Peso (KG)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: pesoController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Insira seu peso!';
                    }
                    return null;
                  }
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Altura (CM)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: alturaController,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Insira sua Altura!';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calcular();
                      }
                    },
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )),
                  ),
                  Text(
                    
                    _info,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green, fontSize:  25.0),
                    )             
                ],
                )),
              ),
      ),
    );
  }}