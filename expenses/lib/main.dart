import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './components/transaction_form.dart';
import 'dart:math';
import './components/transaction_list.dart';
import './components/chart.dart';

main() => runApp(ExprensesApp());


class ExprensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyhomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
           headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
        ),
        appBarTheme: AppBarTheme(
         textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        ), 
      ),
    );
    
  }
}


class MyhomePage extends StatefulWidget {
  
  @override
  _MyhomePageState createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {

final List<Transaction>_transactions = [
     Transaction
     ( 
       id: 't1',
      title: 'conta #01',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
     
    Transaction (
      id: 't0',
      title: 'Novo Tênis de corrida',
      value: 10,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.76,
      date: DateTime.now().subtract(Duration(days: 4)),
    ) 
  ];

List<Transaction> get _recentTransactions {
  return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
      
   }).toList();
}




_addTransaction(String title, double value){
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now()
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    //fecha o modal
    Navigator.of(context).pop();

  }

//modal formulário nova transação
  _openTransactionFormModal(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (_){
        return TransactionForm(_addTransaction);

    }
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () => _openTransactionFormModal(context))
          ],
          title: Text('Despesas Pessoais'),
        ),
        body: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             Chart(_recentTransactions),
              Column(
      children: <Widget>[
        TransactionList(_transactions),
        
      ],
      ),
              
               ],
       ),
        ),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () => _openTransactionFormModal(context)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
  }
}

