import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MultiSelectController extends Equatable {
  List selectedIndexes = [];
  bool isSelecting = false;
  bool disableEditingWhenNoneSelected = true;
  int listLength = 0;

  /// Sets the controller length
  void set(int i) {
    listLength = i;
    isSelecting = false;
    selectedIndexes.clear();
  }

  /// Returns true if the id is selected
  bool isSelected(i) {
    return selectedIndexes.contains(i);
  }

  /// Toggle all select.
  /// If there are some that not selected, it will select all.
  /// If not, it will deselect all.
  void toggleAll() {
    if (selectedIndexes.length == listLength) {
      deselectAll();
    } else {
      selectAll();
    }
  }

  /// Select all
  void selectAll() {
    isSelecting = true;
    selectedIndexes = List.generate(listLength, (index) {
      return index;
    });
  }

  /// Deselect all
  void deselectAll() {
    isSelecting = !disableEditingWhenNoneSelected;
    selectedIndexes.clear();
  }

  /// Toggle at index
  void toggle(index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }

    if (selectedIndexes.isEmpty && disableEditingWhenNoneSelected) {
      isSelecting = false;
    } else {
      isSelecting = true;
    }
  }

  /// Select at index
  void select(int index) {
    if (!selectedIndexes.contains(index)) {
      selectedIndexes.add(index);
    }
    isSelecting = true;
  }

  /// Deselect at index
  void deselect(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    }

    if (selectedIndexes.isEmpty && disableEditingWhenNoneSelected) {
      isSelecting = false;
    } else {
      isSelecting = true;
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => [selectedIndexes,isSelecting,disableEditingWhenNoneSelected, listLength ];
}

class MultiSelectItem extends StatefulWidget {
  final Widget child;
  final bool isSelecting;
  final VoidCallback onSelected;

  const MultiSelectItem({
    Key? key,
    required this.child,
    required this.isSelecting,
    required this.onSelected,
  }) : super(key: key);

  @override
  _MultiSelectItemState createState() => new _MultiSelectItemState();
}

class _MultiSelectItemState extends State<MultiSelectItem> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onLongPress: () {
        widget.onSelected();
      },
      onTap: () {
        if (widget.isSelecting) {
          widget.onSelected();
        }
      },
      child: widget.child,
    );
  }
}