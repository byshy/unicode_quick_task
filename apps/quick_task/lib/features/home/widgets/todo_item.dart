import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picasso/models/config.dart';
import 'package:quick_task/core/enums/completion.dart';
import 'package:quick_task/features/home/bloc/home_bloc.dart';
import 'package:quick_task/features/home/bottom_sheets/todo_bottom_sheet.dart';
import 'package:quick_task/models/todo.dart';
import 'package:quick_task/use_cases/home_use_case.dart';

import '../../../di/injection_container.dart';
import 'corners_painter.dart';

class TodoItem extends StatefulWidget {
  final int index;
  final Todo todo;

  const TodoItem({
    super.key,
    this.index = 0,
    required this.todo,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> with SingleTickerProviderStateMixin {
  static const int animationDurationMS = 600;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: animationDurationMS),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: pi / 2,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    bool shouldWait = !sl<HomeBloc>().state.firstRenderDone;
    int totalTodosCount = sl<HomeBloc>().state.todosList.length;

    Future.delayed(
      Duration(milliseconds: shouldWait ? (animationDurationMS / 2 * pow(0.8, (totalTodosCount - widget.index - 1))).toInt() : 0),
      () {
        _controller.forward();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_animation.value),
          child: Opacity(
            opacity: clampDouble(1 - _animation.value, 0, 1),
            child: child,
          ),
        );
      },
      child: Container(
        color: sl<Config>().theme!.grey,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: sl<Config>().theme!.white,
                child: Checkbox(
                  value: widget.todo.completion.isDone,
                  onChanged: (value) {
                    Todo newTODO = widget.todo.copyWith(completion: value! ? Completion.done : Completion.initial);

                    sl<HomeBloc>().add(
                      TODOUpdated(
                        todo: newTODO,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListTile(
                      key: Key('todo_item_${widget.todo.id}'),
                      title: Text(widget.todo.title),
                      subtitle: widget.todo.hasDescription
                          ? Text(
                              widget.todo.description!,
                              maxLines: 2,
                            )
                          : null,
                      onTap: () async {
                        await showTodoBottomSheet(todo: widget.todo);

                        sl<HomeUseCase>().resetTODOFields();
                      },
                    ),
                    const Positioned.fill(
                      child: CurvedCorners(
                        radius: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 10,
                color: sl<Config>().theme!.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
