// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(month) => "You don\'t have any movements for ${month}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "americanDollar": MessageLookupByLibrary.simpleMessage("American Dollar"),
    "amount": MessageLookupByLibrary.simpleMessage("Amount"),
    "amountDescription": MessageLookupByLibrary.simpleMessage(
      "Amount per month",
    ),
    "amountEmptyValue": MessageLookupByLibrary.simpleMessage(
      "Please type some value.",
    ),
    "amountHint": MessageLookupByLibrary.simpleMessage("Ex: \$150.00"),
    "brazilianReal": MessageLookupByLibrary.simpleMessage("Brazilian Real"),
    "currency": MessageLookupByLibrary.simpleMessage("Currency"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "descriptionCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Description cannot be empty.",
    ),
    "dueDayExpense": MessageLookupByLibrary.simpleMessage("Due day of expense"),
    "dueDayExpenseHint": MessageLookupByLibrary.simpleMessage("Ex: 10"),
    "dueDayIsRequired": MessageLookupByLibrary.simpleMessage(
      "Due day is required",
    ),
    "emptyMovements": MessageLookupByLibrary.simpleMessage("Empty Movements"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "euro": MessageLookupByLibrary.simpleMessage("Euro"),
    "expense": MessageLookupByLibrary.simpleMessage("Expense"),
    "expenseDescription": MessageLookupByLibrary.simpleMessage(
      "Expense Description",
    ),
    "expenseDescriptionHint": MessageLookupByLibrary.simpleMessage(
      "Ex: Invoice Credit Card",
    ),
    "income": MessageLookupByLibrary.simpleMessage("Income"),
    "incomeDay": MessageLookupByLibrary.simpleMessage("Income Day"),
    "incomeDayIsRequired": MessageLookupByLibrary.simpleMessage(
      "Income Day is required",
    ),
    "incomeDescription": MessageLookupByLibrary.simpleMessage(
      "Income Description",
    ),
    "incomeExpense": MessageLookupByLibrary.simpleMessage("Income Expense"),
    "incomeHint": MessageLookupByLibrary.simpleMessage("Ex: Salary"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "movements": MessageLookupByLibrary.simpleMessage("Movements"),
    "periodOfExpense": MessageLookupByLibrary.simpleMessage(
      "Period of expense",
    ),
    "periodOfExpenseDescription": MessageLookupByLibrary.simpleMessage(
      "If has not end date, pick the start date.",
    ),
    "periodOfIncome": MessageLookupByLibrary.simpleMessage("Period of income"),
    "portuguese": MessageLookupByLibrary.simpleMessage("Portuguese"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "selectCurrency": MessageLookupByLibrary.simpleMessage("Select a currency"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "startDateOrRangeIsRequired": MessageLookupByLibrary.simpleMessage(
      "Start or range of dates is required.",
    ),
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "totalExpense": MessageLookupByLibrary.simpleMessage("Total Expense"),
    "totalIncome": MessageLookupByLibrary.simpleMessage("Total Income"),
    "youDonTHaveMovements": m0,
  };
}
