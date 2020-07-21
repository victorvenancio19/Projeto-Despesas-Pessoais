import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleControle = TextEditingController();

  final valueControle = TextEditingController();

  _submitForm() {

    
         final title = titleControle.text;
         final value = double.tryParse(valueControle.text) ?? 0.0;
         
         if(title.isEmpty || value <=0) {
           return;
         }
          widget.onSubmit(title,value);
                           
                         
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
              
               elevation: 5,
               child: Padding(
                 padding: const EdgeInsets.all(10),
                 child: Column(
                   children: <Widget>[

                     TextField(
                       onSubmitted: (_) => _submitForm(),
                       controller: titleControle,
                       decoration: InputDecoration(
                         labelText: 'Título'
                       ),
                     ),
                      TextField(
                        onSubmitted: (_) => _submitForm(),
                        controller: valueControle,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                       decoration: InputDecoration(
                         labelText: 'Valor R\$'
                       ),
                     ),
                     
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         FlatButton(onPressed: _submitForm, child: Text('Nova Transição'), textColor: Colors.purple),
                       ],
                     ),
                   ],
                   
                 ),
                 
               ),
               
             );
  }
}