// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get movements => 'Movimentações';

  @override
  String get emptyMovements => 'Sem Movimentações';

  @override
  String youDonTHaveMovements(Object month) {
    return 'Você não tem nenhuma movimentação em $month';
  }

  @override
  String get totalIncome => 'Total Entradas';

  @override
  String get totalExpense => 'Total Saída';

  @override
  String get total => 'Total';

  @override
  String get incomeExpense => 'Entradas e Despesas';

  @override
  String get expense => 'Despesa';

  @override
  String get income => 'Entrada';

  @override
  String get expenseDescription => 'Descrição da despesa';

  @override
  String get expenseDescriptionHint => 'Ex: Fatura do cartão de crédito';

  @override
  String get descriptionCannotBeEmpty => 'A descrição não pode ser vazia';

  @override
  String get amount => 'Valor';

  @override
  String get amountHint => 'Ex: R\$150.00';

  @override
  String get amountDescription => 'Valor por mês';

  @override
  String get amountEmptyValue => 'Por favor digite algum valor';

  @override
  String get dueDayExpense => 'Dia do vencimento';

  @override
  String get dueDayIsRequired => 'Dia de vencimento é obrigatório';

  @override
  String get dueDayExpenseHint => 'Ex: 10';

  @override
  String get periodOfExpense => 'Período da despesa';

  @override
  String get periodOfExpenseDescription =>
      'Se não tem um fim, selecione apenas data inicio.';

  @override
  String get startDateOrRangeIsRequired =>
      'Data inicio ou período é obrigatório';

  @override
  String get save => 'Salvar';

  @override
  String get delete => 'Excluir';

  @override
  String get incomeDescription => 'Descrição da entrada';

  @override
  String get incomeHint => 'Ex: Salário';

  @override
  String get incomeDay => 'Dia do pagamento';

  @override
  String get incomeDayIsRequired => 'Dia do pagamento é obrigatório';

  @override
  String get periodOfIncome => 'Período do pagamento';

  @override
  String get settings => 'Configurações';

  @override
  String get currency => 'Moeda';

  @override
  String get selectCurrency => 'Selecione uma moeda';

  @override
  String get americanDollar => 'Dólar Americano';

  @override
  String get euro => 'Euro';

  @override
  String get brazilianReal => 'Real';

  @override
  String get language => 'Idioma';

  @override
  String get portuguese => 'Português';

  @override
  String get english => 'Inglês';

  @override
  String get theme => 'Tema';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get success => 'Sucesso';

  @override
  String get changesWasUpdated => 'Alterado com sucesso';

  @override
  String get occurrences => 'Atualizar Ocorrências';

  @override
  String get updateJustIt => 'Somente essa';

  @override
  String get updateAppOccurrences => 'Todas as ocorrências';

  @override
  String get youMustPickAnOption => 'Você precisa escolher uma opção';

  @override
  String get profile => 'Perfil';
}
