// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get movements => '取引';

  @override
  String get emptyMovements => '取引なし';

  @override
  String youDonTHaveMovements(Object month) {
    return '$monthの取引はありません';
  }

  @override
  String get totalIncome => '総収入';

  @override
  String get totalExpense => '総支出';

  @override
  String get total => '合計';

  @override
  String get incomeExpense => '収支';

  @override
  String get expense => '支出';

  @override
  String get income => '収入';

  @override
  String get expenseDescription => '支出の説明';

  @override
  String get expenseDescriptionHint => '例：クレジットカード請求書';

  @override
  String get descriptionCannotBeEmpty => '説明は空にできません。';

  @override
  String get amount => '金額';

  @override
  String get amountHint => '例：¥150';

  @override
  String get amountDescription => '月額';

  @override
  String get amountEmptyValue => '値を入力してください。';

  @override
  String get dueDayExpense => '支出の期日';

  @override
  String get dueDayIsRequired => '期日は必須です';

  @override
  String get dueDayExpenseHint => '例：10';

  @override
  String get periodOfExpense => '支出期間';

  @override
  String get periodOfExpenseDescription => '終了日がない場合は開始日を選択してください。';

  @override
  String get startDateOrRangeIsRequired => '開始日または期間が必要です。';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get incomeDescription => '収入の説明';

  @override
  String get incomeHint => '例：給与';

  @override
  String get incomeDay => '収入日';

  @override
  String get incomeDayIsRequired => '収入日は必須です';

  @override
  String get periodOfIncome => '収入期間';

  @override
  String get settings => '設定';

  @override
  String get currency => '通貨';

  @override
  String get selectCurrency => '通貨を選択';

  @override
  String get americanDollar => '米ドル';

  @override
  String get euro => 'ユーロ';

  @override
  String get brazilianReal => 'ブラジルレアル';

  @override
  String get danishKrone => 'デンマーククローネ';

  @override
  String get chineseYuan => '中国元';

  @override
  String get japaneseYen => '日本円';

  @override
  String get koreanWon => '韓国ウォン';

  @override
  String get language => '言語';

  @override
  String get portuguese => 'ポルトガル語';

  @override
  String get english => '英語';

  @override
  String get spanish => 'スペイン語';

  @override
  String get danish => 'デンマーク語';

  @override
  String get german => 'ドイツ語';

  @override
  String get chinese => '中国語';

  @override
  String get japanese => '日本語';

  @override
  String get korean => '韓国語';

  @override
  String get theme => 'テーマ';

  @override
  String get system => 'システム';

  @override
  String get light => 'ライト';

  @override
  String get dark => 'ダーク';

  @override
  String get success => '成功';

  @override
  String get changesWasUpdated => '更新しました';

  @override
  String get occurrences => '発生を更新';

  @override
  String get updateJustIt => 'これだけ';

  @override
  String get updateAppOccurrences => 'すべての発生';

  @override
  String get youMustPickAnOption => 'オプションを選択してください';

  @override
  String get profile => 'プロフィール';

  @override
  String get imageLink => '画像リンク';

  @override
  String get addLinkImage => '画像リンクを追加';

  @override
  String get appleSignIn => 'Appleでサインイン';

  @override
  String get googleSignIn => 'Googleでサインイン';

  @override
  String get signOut => 'サインアウト';

  @override
  String get refresh => '更新';

  @override
  String get somethingWrong => '問題が発生しました';

  @override
  String get tryAgain => '再試行';
}
