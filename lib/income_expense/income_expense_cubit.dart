import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/events/movement_changed.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/extensions/string_extensions.dart';
import 'package:moovy/income_expense/occurrence.dart';
import 'package:moovy/main.dart';
import 'package:moovy/repository/movement_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

part 'income_expense_state.dart';

enum IncomeExpenseTabs { expense, income }

class IncomeExpenseCubit extends Cubit<IncomeExpenseState> {
  final MovementRepository movementRepository;
  final String? id;
  IncomeExpenseTabs tab;
  IncomeExpenseCubit(this.movementRepository, this.id, this.tab) : super(IncomeExpenseInitial()) {
    getById();
  }

  void setTab(IncomeExpenseTabs tab) {
    this.tab = tab;
  }

  Future<void> getById() async {
    if (id case final id?) {
      try {
        final movement = await movementRepository.findById(id);
        if (movement != null) {
          emit(IncomeExpenseForm(movement, movement));
        } else {
          emit(IncomeExpenseForm(null, null));
        }
      } catch (e, s) {
        debugPrintStack(stackTrace: s);
      }
    } else {
      emit(IncomeExpenseForm(null, null));
    }
  }

  Future<void> save({required Map<Object, dynamic> data, required DateTime monthTab}) async {
    try {
      final type = MovementType.fromName(tab.name);
      ShadDateTimeRange period = data['period'];
      final dayOfDate = period.start?.day;
      String description = data['description'];
      String amount = data['amount'];
      int? incomeDay = type == .income ? dayOfDate : null;
      int? dueDay = type == .expense ? dayOfDate : null;
      String imageUrl = data['image_url'] ?? '';

      if (id case final id?) {
        Occurrence occurrence = data['occurrence'];
        final movementDb = await movementRepository.findById(id);
        if (movementDb == null) {
          throw Exception('Movement not found');
        }
        final movement = movementDb.copyWith(
          id: id,
          description: description,
          amount: amount.digits().toInt(),
          incomeDay: incomeDay,
          dueDay: dueDay,
          startDate: period.start!,
          endDate: period.end,
          startYm: period.start!.yearMonth(),
          endYm: period.end?.yearMonth() ?? 999912,
          type: type,
          imageUrl: imageUrl.isEmpty ? null : imageUrl,
          updatedAt: DateTime.now(),
        );
        switch (occurrence) {
          case Occurrence.it:
            try {
              //equal DB previous months
              final previousMonth = monthTab.copyWith(day: movement.startDate.day).addMonths(-1);
              final newMovement = movementDb.copyWith(id: _uuid(), endDate: previousMonth);
              await movementRepository.insertMovement(newMovement);

              final thisMonth = monthTab.copyWith(day: movement.startDate.day);
              final toUpdateMovement = movement.copyWith(id: id, startDate: thisMonth, endDate: thisMonth);
              await movementRepository.updateMovement(toUpdateMovement);

              //equal DB to next months
              final nextMonth = monthTab.copyWith(day: movement.startDate.day).addMonths(1);
              final recurrence = movementDb.copyWith(id: _uuid(), startDate: nextMonth);
              await movementRepository.insertMovement(recurrence);
            } catch (e, s) {
              debugPrintStack(stackTrace: s);
            }
          case Occurrence.all:
            await movementRepository.updateMovement(movement);
        }

        eventBus.fire(MovementChanged(movement));
      } else {

        final movement = Movement(
          id: _uuid(),
          firestoreId: null,
          description: description,
          amount: amount.digits().toInt(),
          incomeDay: incomeDay,
          dueDay: dueDay,
          startDate: period.start!,
          endDate: period.end,
          startYm: period.start!.yearMonth(),
          endYm: period.end?.yearMonth() ?? 999912,
          type: MovementType.fromName(tab.name),
          paid: false,
          imageUrl: imageUrl.isEmpty ? null : imageUrl,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await movementRepository.insertMovement(movement);
        eventBus.fire(MovementChanged(movement));
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> delete() async {
    if (id case final id?) {
      await movementRepository.deleteById(id);
      eventBus.fire(MovementChanged(null));
    }
  }

  String _uuid() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final randomText = List.generate(5, (_) => chars[random.nextInt(chars.length)]).join();
    return DateTime.now().format(DateTimeFormat.yyyymmddHHmmss) + randomText;
  }
}
