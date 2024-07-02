import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widgets/expenseslist/expenses_item.dart';

import '../../model/expense.dart';

class Expenses_list extends StatelessWidget {
  const Expenses_list(
      {super.key, required this.expenses, required this.remove_expense});
  final List<Expense> expenses;
  final Function(Expense) remove_expense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, indx) => Dismissible(
            onDismissed: (direction) {
              remove_expense(expenses[indx]);
            },
            background: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(.5),
              borderRadius: BorderRadius.circular(10)
            ),
            
            ),
            key: ValueKey(expenses[indx]),
            child: ExpensesItem(expense: expenses[indx])));
  }
}
