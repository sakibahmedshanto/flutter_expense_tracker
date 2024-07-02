import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/main.dart';
import 'package:flutter_expense_tracker/widgets/expenseslist/expenses_list.dart';
import 'package:flutter_expense_tracker/widgets/new_expense.dart';
import '../model/expense.dart';
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

// start of the list
  final List<Expense> _registeredExpenses=[
    Expense(title: "Sakib", amount: 1000, date: DateTime.now(), category: Category.food)
  ];

// end of the list
void add_to_expense(String title,double amount,Category category,DateTime date){
  setState(() {
  _registeredExpenses.add(
    Expense(title: title, amount: amount, date: date, category: category)
  );
  });
}

void removeExpense(Expense expense){
  final expenseIndex=_registeredExpenses.indexOf(expense);
  setState(() {
    _registeredExpenses.remove(expense);
  });

  ScaffoldMessenger.of(context).clearSnackBars();
  
  ScaffoldMessenger.of(context).showSnackBar(
  
    SnackBar(content: const Text("Expense Deleted"),
    duration: Duration(seconds: 3),
    action: SnackBarAction(label: "Undo",
    onPressed: (){
      setState(() {
        _registeredExpenses.insert(expenseIndex, expense);
      });
    },
    ),
    )
  );
}
void _openAddExpenseOverlay(){
  showModalBottomSheet(context: context,
  isScrollControlled: true,
  
   builder: (ctx)=> FractionallySizedBox(
     
     child: NewExpense(addToList: add_to_expense,
     ),
     heightFactor: 0.8,
   ));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Expense Tracker"),
        actions: [
        IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add))
      ],
      
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text("The Chart",style: Theme.of(context).textTheme.titleLarge,),
          Expanded(child: Expenses_list(expenses: _registeredExpenses,remove_expense: removeExpense,),
          )

        ],
      ),
    );
  }
}