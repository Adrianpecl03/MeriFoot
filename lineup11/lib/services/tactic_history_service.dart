import '../models/tactic.dart';
import '../models/tactic_object.dart';
import '../models/tactic_arrow.dart';

enum HistoryActionType {
  create,
  delete,
  move,
}

class HistoryAction {
  final HistoryActionType type;

  // Puede ser un objeto normal...
  final TacticObject? object;

  // ...o una flecha.
  final TacticArrow? arrow;

  final double? oldX;
  final double? oldY;

  final double? newX;
  final double? newY;

  HistoryAction({
    required this.type,
    this.object,
    this.arrow,
    this.oldX,
    this.oldY,
    this.newX,
    this.newY,
  });

  HistoryAction copy() {
    return HistoryAction(
      type: type,
      object: object?.copy(),
      arrow: arrow?.copy(),
      oldX: oldX,
      oldY: oldY,
      newX: newX,
      newY: newY,
    );
  }
}

class TacticHistoryService {
  final List<HistoryAction> _undoStack = [];
  final List<HistoryAction> _redoStack = [];

  void addAction(HistoryAction action) {
    _undoStack.add(action.copy());
    _redoStack.clear();
  }

  bool get canUndo => _undoStack.isNotEmpty;

  bool get canRedo => _redoStack.isNotEmpty;

  void undo(Tactic tactic) {
    if (_undoStack.isEmpty) return;

    final action = _undoStack.removeLast();

    switch (action.type) {
      case HistoryActionType.create:
        if (action.object != null) {
          tactic.objects.removeWhere(
            (e) => e.id == action.object!.id,
          );
        }

        if (action.arrow != null) {
          tactic.arrows.removeWhere(
            (e) => e.id == action.arrow!.id,
          );
        }
        break;

      case HistoryActionType.delete:
        if (action.object != null) {
          tactic.objects.add(action.object!.copy());
        }

        if (action.arrow != null) {
          tactic.arrows.add(action.arrow!.copy());
        }
        break;

      case HistoryActionType.move:
        if (action.object != null) {
          final object = tactic.objects.firstWhere(
            (e) => e.id == action.object!.id,
          );

          object.x = action.oldX!;
          object.y = action.oldY!;
        }
        break;
    }

    _redoStack.add(action.copy());
  }

  void redo(Tactic tactic) {
    if (_redoStack.isEmpty) return;

    final action = _redoStack.removeLast();

    switch (action.type) {
      case HistoryActionType.create:
        if (action.object != null) {
          tactic.objects.add(action.object!.copy());
        }

        if (action.arrow != null) {
          tactic.arrows.add(action.arrow!.copy());
        }
        break;

      case HistoryActionType.delete:
        if (action.object != null) {
          tactic.objects.removeWhere(
            (e) => e.id == action.object!.id,
          );
        }

        if (action.arrow != null) {
          tactic.arrows.removeWhere(
            (e) => e.id == action.arrow!.id,
          );
        }
        break;

      case HistoryActionType.move:
        if (action.object != null) {
          final object = tactic.objects.firstWhere(
            (e) => e.id == action.object!.id,
          );

          object.x = action.newX!;
          object.y = action.newY!;
        }
        break;
    }

    _undoStack.add(action.copy());
  }
}