import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_bloc/bloc/todo_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    final _controller = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Todo List'),
                            Row(
                children: [
                  Column(
                    children: [
                      Text('Selected Date'),
                      BlocBuilder<TodoBloc, TodoState>(
                        builder: (context, state) {
                          if (state is TodoLoaded) {
                            if (state.selectDate != null) {
                              return Text(
                                '${state.selectDate!.day}/${state.selectDate!.month}/${state.selectDate!.year}',
                              );
                            }
                          }
                          return Text('No date selected');
                        },
                      ),
                       SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null) {
                            context.read<TodoBloc>().add(
                                  TodoSelectedDate(date: selectedDate),
                                );
                          }
                        },
                        child: Text('Select Date'),
                      ),
                    ],
                  ),
                ],
              ),


