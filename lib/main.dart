import 'package:flutter/material.dart';

void main(){
runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Home(),
));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calculate(){
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if(imc < 18.6){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outlined, size: 120, color: Colors.green,),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: pesoController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Insira seu peso!";
                  }
                  return null;
                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: alturaController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Insira sua altura!";
                  }
                  return null;
                },
              ),

              Padding(padding: EdgeInsets.only(top: 20, bottom: 20),
                child:
                ElevatedButton(
                  onPressed: (){
                    final form = _formKey.currentState;

                    if(form != null && form.validate()){
                      _calculate();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:Colors.green,
                      foregroundColor: Colors.white
                  ),
                  child: Text('Calcular', style: TextStyle(fontSize: 22.0),),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 15, bottom: 15),
                child:
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 21.0
                  ),
                )
                ,)
            ],
          ),
        ),
      )
    );
  }
}
