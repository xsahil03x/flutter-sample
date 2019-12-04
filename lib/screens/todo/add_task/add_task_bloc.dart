import 'package:com_cingulo_sample/common/bloc.dart';
import 'package:com_cingulo_sample/models/todo/task_model.dart';
import 'package:rxdart/rxdart.dart';

class AddTaskBloc extends ABloc<AddTaskBlocState> {
  AddTaskBloc() : super(states$$: PublishSubject<AddTaskBlocState>());

  void add(TaskModel task) {
    catchError(() async {
      await di.todoRepository.createTask(task);
      states$$.add(AddTaskBlocSuccess());
    });
  }
}

abstract class AddTaskBlocState extends ABlocState {}

class AddTaskBlocSuccess extends AddTaskBlocState {}
