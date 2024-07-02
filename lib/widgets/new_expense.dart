import 'package:flutter/material.dart';
import '/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.addToList});
  final Function(String title,double amount,Category category,DateTime date) addToList ;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  Category _initialCategory= Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData(){
    final enterdAmount=double.tryParse(_amountController.text);
    final amountIsInvalid= (enterdAmount==null || enterdAmount<0);
    if(_titleController.text.trim().isEmpty || amountIsInvalid|| _selectedDate==null){
      showDialog(context: context, builder: (ctx)=>AlertDialog(
        title:const Text("Invalid Context"),
        content: const Text("Please make sure a valid tittle,amount,date and category was entered"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(ctx);
          }, child: Text("Okay"))
        ],
      ));
    
      return;
    }
    widget.addToList(_titleController.text.toString(),enterdAmount,_initialCategory,_selectedDate!);
    showDialog(context: context, builder: (ctx)=>AlertDialog(
    title: Text("Succes"),
    content: Text("You have succesfully added the expense"),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(ctx);
      }, child: Text("Okay"))
    ],
        ));
   
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16,16,16,16),
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 50,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    prefixText: "\$ ",
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? "No Date Selected"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                  value: _initialCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if(value==null) return null;
                    setState(() {
                    _initialCategory=value;  
                    });

                  }),
                const Spacer(),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: Text("Save Expense")
                  ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"))
            ],
          )
        ],
      ),
    );
  }
}
