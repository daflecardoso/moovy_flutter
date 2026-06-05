import 'package:app_deploy_screenshots/app_deploy_screenshots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moovy/bottom_navigation/bottom_navigation.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/gen/assets.gen.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:moovy/movement_list/view/widget/summary_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ---------------------------------------------------------------------------
// Fake data
// ---------------------------------------------------------------------------

final _now = DateTime.now();

final _fakeMovements = <Movement>[
  _m('Aluguel', 180000, MovementType.expense, dueDay: 5),
  _m('Salário', 600000, MovementType.income, incomeDay: 5),
  _m('Netflix', 4990, MovementType.expense, dueDay: 15),
  _m('Spotify', 2190, MovementType.expense, dueDay: 1),
  _m('Freelance', 150000, MovementType.income, incomeDay: 20),
  _m('Internet', 9990, MovementType.expense, dueDay: 10),
  _m('Supermercado', 35000, MovementType.expense, dueDay: 15),
  _m('Academia', 8990, MovementType.expense, dueDay: 1),
];

Movement _m(
  String desc,
  int amount,
  MovementType type, {
  int? dueDay,
  int? incomeDay,
}) {
  return Movement(
    id: desc,
    firestoreId: null,
    description: desc,
    amount: amount,
    dueDay: dueDay,
    incomeDay: incomeDay,
    startDate: DateTime(_now.year, _now.month, 1),
    endDate: null,
    startYm: _now.yearMonth(),
    endYm: null,
    paid: false,
    imageUrl: null,
    type: type,
    createdAt: _now,
    updatedAt: _now,
  );
}

// ---------------------------------------------------------------------------
// App wrapper
// ---------------------------------------------------------------------------

Widget _app({Locale locale = const Locale('en'), required Widget home}) {
  return ShadApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: ShadThemeData(
      brightness: Brightness.light,
      colorScheme: const ShadSlateColorScheme.light(),
    ),
    darkTheme: ShadThemeData(
      brightness: Brightness.dark,
      colorScheme: const ShadSlateColorScheme.dark(),
    ),
    debugShowCheckedModeBanner: false,
    home: home,
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  testWidgets('01_movements', (tester) async {
    await tester.pumpWidget(_app(home: const _MovementsPreview()));
    await tester.pumpAndSettle();
    await AppDeployScreenshots.byPlatform(tester, '01_movements');
  });

  testWidgets('02_add_expense', (tester) async {
    await tester.pumpWidget(_app(home: const _ExpensePreview()));
    await tester.pumpAndSettle();
    await AppDeployScreenshots.byPlatform(tester, '02_add_expense');
  });

  testWidgets('03_profile', (tester) async {
    await tester.pumpWidget(_app(home: const _ProfilePreview()));
    await tester.pumpAndSettle();
    await AppDeployScreenshots.byPlatform(tester, '03_profile');
  });
}

// ---------------------------------------------------------------------------
// Preview: Movements list
// ---------------------------------------------------------------------------

class _MovementsPreview extends StatelessWidget {
  const _MovementsPreview();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final totalIncome = _fakeMovements
        .where((m) => m.type == MovementType.income)
        .fold(0, (s, m) => s + m.amount);
    final totalExpense = _fakeMovements
        .where((m) => m.type == MovementType.expense)
        .fold(0, (s, m) => s + m.amount);
    final total = totalIncome - totalExpense;

    return DefaultTabController(
      length: 12,
      initialIndex: _now.month - 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.movements, style: ShadTheme.of(context).textTheme.large),
          actions: [
            ShadIconButton.ghost(
              icon: const Icon(LucideIcons.plus),
              onPressed: null,
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Theme.of(context).colorScheme.onSurfaceVariant,
            unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
            dividerColor: Colors.transparent,
            tabs: List.generate(12, (i) {
              return Tab(text: DateTime(_now.year, i + 1, 1).format(DateTimeFormat.mmmmYyyy));
            }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BottomNavigation(selectedIndex: 0),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SummaryWidget(
                      title: l.totalIncome,
                      value: totalIncome.currency(),
                      textColor: MovementType.income.color,
                    ),
                    SummaryWidget(
                      title: l.totalExpense,
                      value: totalExpense.currency(),
                      textColor: MovementType.expense.color,
                    ),
                    SummaryWidget(
                      title: l.total,
                      value: total.currency(),
                      textColor: total.isNegative ? MovementType.expense.color : MovementType.income.color,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _fakeMovements.length,
                  separatorBuilder: (_, __) => const Divider(height: 0, thickness: 0.5),
                  itemBuilder: (_, i) => _MovementRow(movement: _fakeMovements[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MovementRow extends StatelessWidget {
  final Movement movement;
  const _MovementRow({required this.movement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: Row(
        children: [
          const SizedBox(width: 30, height: 30),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    movement.startDate.format(DateTimeFormat.ddMM),
                    style: ShadTheme.of(context).textTheme.small.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    movement.description,
                    style: ShadTheme.of(context).textTheme.p.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                movement.uiAmount,
                style: ShadTheme.of(context).textTheme.list.apply(
                      color: movement.type.color,
                    ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          ShadCheckbox(
            size: 24,
            value: movement.paid,
            onChanged: (_) {},
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Preview: Expense form
// ---------------------------------------------------------------------------

class _ExpensePreview extends StatelessWidget {
  const _ExpensePreview();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.incomeExpense, style: ShadTheme.of(context).textTheme.large),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  ShadButton(onPressed: null, child: Text(l.expense)),
                  const SizedBox(width: 8),
                  ShadButton.outline(onPressed: null, child: Text(l.income)),
                ],
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                label: Text(l.expenseDescription),
                placeholder: Text(l.expenseDescriptionHint),
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                label: Text(l.amount),
                placeholder: Text(l.amountHint),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                label: Text(l.dueDayExpense),
                placeholder: Text(l.dueDayExpenseHint),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ShadButton(
                onPressed: null,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Preview: Profile (sign-in state)
// ---------------------------------------------------------------------------

class _ProfilePreview extends StatelessWidget {
  const _ProfilePreview();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.profile, style: ShadTheme.of(context).textTheme.large),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShadButton.outline(
              leading: Assets.icon.google.image(width: 16),
              onPressed: null,
              child: Text(l.googleSignIn),
            ),
            ShadButton(
              leading: const Icon(Icons.apple),
              onPressed: null,
              child: Text(l.appleSignIn),
            ),
          ],
        ),
      ),
    );
  }
}
