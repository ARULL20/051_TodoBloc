import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_with_bloc/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoaded(todos: [],selectDate: null)) {
    on<TodoEventAdd>((event, emit) {
      final currentState = state;
      if (currentState is TodoLoaded){
        final List<Todo> updatedTodos = List.from(currentState.todos);
        updatedTodos.add(
          Todo(
            title: event.title,
            isCompleted: false,
            date: event.date),
          );
          emit(
            TodoLoaded(
              todos: updatedTodos,
               selectDate: currentState.selectDate,
              ),
        );
      }
    });

    on<TodoSelectDate>((event,emit){
      final currentState = state;
      if (currentState is TodoLoaded) {
        emit(TodoLoaded(
          todos: currentState.todos,
          selectDate:event.date
        ));
      }
    });
    on<TodoEventComplete>((event, emit){
      final currentState = state;
      if (currentState is TodoLoaded) {
        final List<Todo> updatedTodos = List.from(currentState.todos);
        if (event.index >= 0 && event.index < updatedTodos.length) {
          updatedTodos[event.index] = Todo(
            title: updatedTodos[event.index].title,
            isCompleted: updatedTodos[event.index].isCompleted == true,

            date : updatedTodos[event.index].date
          );
          emit(
            TodoLoaded(
              todos: updatedTodos,
              selectDate: currentState.selectDate,
            ),
          );
        }
      }
    });
  }
}
