import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/model/expense.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key,required this.expense});
 
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text( "\$ ${expense.amount.toStringAsFixed(2)}"),
                const Spacer(),
                Row(
                  children: [
                     Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8,),
                    Text(expense.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}