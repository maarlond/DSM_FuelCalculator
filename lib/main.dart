/*
Nome: Marlon Dietrich

Se você tem um carro flex, quando você vai a um posto de combustível deve ter sempre a dúvida: como vou abastecer hoje? Álcool ou gasolina? O mais importante a considerar quando for abastecer o seu automóvel é a diferença de preços, já que o consumo de álcool é um pouco maior que o consumo de gasolina pelo mesmo motor. Em média, os carros leves mais utilizados nas ruas consomem 30% a mais com álcool do que com gasolina percorrendo a mesma distância.
Assim, há uma maneira simples de calcular se vale mais a pena abastecer com álcool ou gasolina em determinado posto de abastecimento:
Multiplique o valor da gasolina no posto de combustível por 0,7.
Se o resultado for maior que o valor do álcool, vale abastecer com álcool.
Se o resultado for menor que valor do álcool, abasteça com gasolina.
Por exemplo: Se a gasolina custa 2,40 num posto e o álcool custa 1,40. Multiplicando 2,40 x 0,7 temos o resultado 1,68, que é maior que 1,40. Neste caso é melhor abastecer com álcool. Se o valor do álcool estivesse acima de 1,68, valeria mais a pena abastecer com gasolina nesse posto.

Tendo em mente esse problema faça um programa em flutter que mostra qual combustível é mais vantajoso.
*/

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController fuelController = TextEditingController();
  // * variavel para controlar o texto inserido no textfield
  TextEditingController alcoholController = TextEditingController();
  // * variavel para controlar o texto inserido no textfield
  GlobalKey<FormState> _formKey = GlobalKey<
      FormState>(); // * chave global, usado para formulário de validação

  String _infoText =
      "Informe seus dados"; // * variavel para editar um texto já inserido

  void _resetFields() {
    // * função para resetar ou editar um texto
    fuelController.text = "";
    alcoholController.text = "";
    setState(() {
      // * retorna se o estado do objeto foi alterado
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>(); // * chave global
    });
  }

  void _calculate() {
    setState(() {
      // * retorna se o estado do objeto foi alterado
      double fuel = double.parse(fuelController.text);
      double alcohol = double.parse(alcoholController.text);
      double resultFuel = fuel * 0.7;
      //print(resultFuel);

      if (resultFuel > alcohol) {
        // * Se o resultado for maior que o valor do álcool, vale abastecer com álcool.

        _infoText =
            "Vale mais abastecer por álcool (${alcohol.toStringAsPrecision(3)} R\$)"; // * toStringAsPrecision -> precisão de digitos no valor inserido, no caso 3 digitos
      } else {
        // * Se o resultado for menor que valor do álcool, abasteça com gasolina.

        _infoText =
            "Vale mais abastecer por gasolina (${fuel.toStringAsPrecision(3)} R\$)"; // * toStringAsPrecision -> precisão de digitos no valor inserido, no caso 3 digitos
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de combustível!"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed:
                  _resetFields, // * retorna uma função quando o usuário clicar no ícone de atualizar a página icons.refresh
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.local_gas_station,
                  size: 130.0,
                  color: Colors.black,
                ),
                // * TextField( -> não consigo validar se o texto realmente foi inserido
                TextFormField(
                  // * textoFormField consigo usar um validador para verificar se o texto foi realmente inserido, ou é um null
                  keyboardType: TextInputType
                      .number, // * insere um teclado para o usuário digitar
                  decoration: InputDecoration(
                      labelText: "Valor da gasolina (R\$):",
                      labelStyle: TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  controller:
                      fuelController, // * declarar a variável criada para o controle do texto inserido
                  validator: (value) {
                    // * validador do formulário
                    if (value.isEmpty) {
                      // * caso o formulário é vazio, ele retorna o aviso abaixo
                      return "Por favor, insira o valor da gasolina!";
                    }
                  },
                ),
                // * TextField( -> não consigo validar se o texto realmente foi inserido
                TextFormField(
                  // * textoFormField consigo usar um validador para verificar se o texto foi realmente inserido, ou é um null
                  keyboardType: TextInputType
                      .number, // * insere um teclado para o usuário digitar
                  decoration: InputDecoration(
                      labelText: "Valor do álcool (R\$):",
                      labelStyle: TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  controller:
                      alcoholController, // * declarar a variável criada para o controle do texto inserido
                  validator: (value) {
                    // * validador do formulário
                    if (value.isEmpty) {
                      // * caso o formulário é vazio, ele retorna o aviso abaixo
                      return "Por favor, insira o valor da gasolina!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    margin: const EdgeInsets.all(3.0),
                    height: 45,
                    child: RaisedButton(
                      onPressed: () {
                        // * quando for apertado o botão de calcular, será verificado se o mesmo é valido, caso sim, é chamado a função de calcular
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      }, // * retorna uma função quando o usuário clicar em "Calcular"
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                )
              ],
            ),
          ),
        ));
  }
}
