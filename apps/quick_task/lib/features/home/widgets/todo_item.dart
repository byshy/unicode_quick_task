import 'dart:math' as math;
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

class _TodoItemState extends State<TodoItem> with TickerProviderStateMixin {
  static const int animationDurationMS = 600;

  late AnimationController _cardController;
  late Animation<double> _cardAnimation;

  late AnimationController _checkBoxController;
  late Animation<double> _checkBoxAnimation;

  @override
  void initState() {
    super.initState();

    _cardController = AnimationController(
      duration: const Duration(milliseconds: animationDurationMS),
      vsync: this,
    );

    _cardAnimation = Tween<double>(
      begin: math.pi / 2,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeInOut,
    ));

    _checkBoxController = AnimationController(
      duration: const Duration(milliseconds: animationDurationMS ~/ 2),
      vsync: this,
    );

    _checkBoxAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _checkBoxController,
      curve: Curves.easeInOut,
    ));

    bool shouldWait = !sl<HomeBloc>().state.firstRenderDone;
    int totalTodosCount = sl<HomeBloc>().state.todosList.length;

    int waitingTime = (animationDurationMS / 2 * math.pow(0.8, (totalTodosCount - widget.index - 1))).toInt();

    Future.delayed(
      Duration(milliseconds: shouldWait ? waitingTime : 0),
      () {
        _cardController.forward();
      },
    );

    Future.delayed(
      const Duration(milliseconds: animationDurationMS),
      () {
        _checkBoxController.forward();
      },
    );
  }

  @override
  void dispose() {
    _cardController.dispose();
    _checkBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cardAnimation,
      builder: (_, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_cardAnimation.value),
          child: Opacity(
            opacity: clampDouble(1 - _cardAnimation.value, 0, 1),
            child: child,
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: animationDurationMS ~/ 3),
        color: widget.todo.completion.isDone ? sl<Config>().theme!.green : sl<Config>().theme!.grey,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedBuilder(
                animation: _checkBoxAnimation,
                builder: (_, child) {
                  return AnimatedContainer(
                    color: sl<Config>().theme!.white,
                    width: _checkBoxAnimation.value == 0 ? 10 : 48,
                    duration: const Duration(milliseconds: animationDurationMS ~/ 2),
                    child: Opacity(
                      opacity: _checkBoxAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Checkbox(
                  value: widget.todo.completion.isDone,
                  shape: const CircleBorder(),
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
                      child: IgnorePointer(
                        child: CurvedCorners(
                          radius: 15,
                          color: Colors.white,
                        ),
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
