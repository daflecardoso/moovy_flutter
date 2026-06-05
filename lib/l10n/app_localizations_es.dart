// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get movements => 'Movimientos';

  @override
  String get emptyMovements => 'Sin Movimientos';

  @override
  String youDonTHaveMovements(Object month) {
    return 'No tienes movimientos en $month';
  }

  @override
  String get totalIncome => 'Total Ingresos';

  @override
  String get totalExpense => 'Total Gastos';

  @override
  String get total => 'Total';

  @override
  String get incomeExpense => 'Ingresos y Gastos';

  @override
  String get expense => 'Gasto';

  @override
  String get income => 'Ingreso';

  @override
  String get expenseDescription => 'Descripción del gasto';

  @override
  String get expenseDescriptionHint => 'Ej: Factura de tarjeta de crédito';

  @override
  String get descriptionCannotBeEmpty => 'La descripción no puede estar vacía.';

  @override
  String get amount => 'Monto';

  @override
  String get amountHint => 'Ej: \$150.00';

  @override
  String get amountDescription => 'Monto por mes';

  @override
  String get amountEmptyValue => 'Por favor ingrese algún valor.';

  @override
  String get dueDayExpense => 'Día de vencimiento';

  @override
  String get dueDayIsRequired => 'El día de vencimiento es obligatorio';

  @override
  String get dueDayExpenseHint => 'Ej: 10';

  @override
  String get periodOfExpense => 'Período del gasto';

  @override
  String get periodOfExpenseDescription =>
      'Si no tiene fecha de fin, elige la fecha de inicio.';

  @override
  String get startDateOrRangeIsRequired =>
      'La fecha de inicio o el período es obligatorio.';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get incomeDescription => 'Descripción del ingreso';

  @override
  String get incomeHint => 'Ej: Salario';

  @override
  String get incomeDay => 'Día de ingreso';

  @override
  String get incomeDayIsRequired => 'El día de ingreso es obligatorio';

  @override
  String get periodOfIncome => 'Período del ingreso';

  @override
  String get settings => 'Configuración';

  @override
  String get currency => 'Moneda';

  @override
  String get selectCurrency => 'Selecciona una moneda';

  @override
  String get americanDollar => 'Dólar Americano';

  @override
  String get euro => 'Euro';

  @override
  String get brazilianReal => 'Real Brasileño';

  @override
  String get danishKrone => 'Corona Danesa';

  @override
  String get chineseYuan => 'Yuan Chino';

  @override
  String get japaneseYen => 'Yen Japonés';

  @override
  String get koreanWon => 'Won Coreano';

  @override
  String get language => 'Idioma';

  @override
  String get portuguese => 'Portugués';

  @override
  String get english => 'Inglés';

  @override
  String get spanish => 'Español';

  @override
  String get danish => 'Danés';

  @override
  String get german => 'Alemán';

  @override
  String get chinese => 'Chino';

  @override
  String get japanese => 'Japonés';

  @override
  String get korean => 'Coreano';

  @override
  String get theme => 'Tema';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get success => 'Éxito';

  @override
  String get changesWasUpdated => 'Actualizado con éxito';

  @override
  String get occurrences => 'Actualizar Ocurrencias';

  @override
  String get updateJustIt => 'Solo esta';

  @override
  String get updateAppOccurrences => 'Todas las ocurrencias';

  @override
  String get youMustPickAnOption => 'Debes elegir una opción';

  @override
  String get profile => 'Perfil';

  @override
  String get imageLink => 'Enlace de imagen';

  @override
  String get addLinkImage => 'Agrega un enlace de imagen';

  @override
  String get appleSignIn => 'Iniciar sesión con Apple';

  @override
  String get googleSignIn => 'Iniciar sesión con Google';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get refresh => 'Actualizar';

  @override
  String get somethingWrong => 'Algo salió mal';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get screenshotMovementsTitle => 'Controla cada\ncéntimo del día';

  @override
  String get screenshotExpenseTitle => 'Añade gastos\nen segundos';

  @override
  String get screenshotProfileTitle => 'Control total\nde tu presupuesto';
}
