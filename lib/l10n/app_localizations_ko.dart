// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get movements => '거래';

  @override
  String get emptyMovements => '거래 없음';

  @override
  String youDonTHaveMovements(Object month) {
    return '$month에 거래가 없습니다';
  }

  @override
  String get totalIncome => '총 수입';

  @override
  String get totalExpense => '총 지출';

  @override
  String get total => '합계';

  @override
  String get incomeExpense => '수입 및 지출';

  @override
  String get expense => '지출';

  @override
  String get income => '수입';

  @override
  String get expenseDescription => '지출 설명';

  @override
  String get expenseDescriptionHint => '예: 신용카드 청구서';

  @override
  String get descriptionCannotBeEmpty => '설명은 비워둘 수 없습니다.';

  @override
  String get amount => '금액';

  @override
  String get amountHint => '예: ₩150,000';

  @override
  String get amountDescription => '월 금액';

  @override
  String get amountEmptyValue => '값을 입력해 주세요.';

  @override
  String get dueDayExpense => '지출 만기일';

  @override
  String get dueDayIsRequired => '만기일은 필수입니다';

  @override
  String get dueDayExpenseHint => '예: 10';

  @override
  String get periodOfExpense => '지출 기간';

  @override
  String get periodOfExpenseDescription => '종료일이 없으면 시작일을 선택하세요.';

  @override
  String get startDateOrRangeIsRequired => '시작일 또는 기간이 필요합니다.';

  @override
  String get save => '저장';

  @override
  String get delete => '삭제';

  @override
  String get incomeDescription => '수입 설명';

  @override
  String get incomeHint => '예: 급여';

  @override
  String get incomeDay => '수입일';

  @override
  String get incomeDayIsRequired => '수입일은 필수입니다';

  @override
  String get periodOfIncome => '수입 기간';

  @override
  String get settings => '설정';

  @override
  String get currency => '통화';

  @override
  String get selectCurrency => '통화 선택';

  @override
  String get americanDollar => '미국 달러';

  @override
  String get euro => '유로';

  @override
  String get brazilianReal => '브라질 헤알';

  @override
  String get danishKrone => '덴마크 크로네';

  @override
  String get chineseYuan => '중국 위안';

  @override
  String get japaneseYen => '일본 엔';

  @override
  String get koreanWon => '한국 원';

  @override
  String get language => '언어';

  @override
  String get portuguese => '포르투갈어';

  @override
  String get english => '영어';

  @override
  String get spanish => '스페인어';

  @override
  String get danish => '덴마크어';

  @override
  String get german => '독일어';

  @override
  String get chinese => '중국어';

  @override
  String get japanese => '일본어';

  @override
  String get korean => '한국어';

  @override
  String get theme => '테마';

  @override
  String get system => '시스템';

  @override
  String get light => '라이트';

  @override
  String get dark => '다크';

  @override
  String get success => '성공';

  @override
  String get changesWasUpdated => '성공적으로 업데이트되었습니다';

  @override
  String get occurrences => '발생 업데이트';

  @override
  String get updateJustIt => '이것만';

  @override
  String get updateAppOccurrences => '모든 발생';

  @override
  String get youMustPickAnOption => '옵션을 선택해야 합니다';

  @override
  String get profile => '프로필';

  @override
  String get imageLink => '이미지 링크';

  @override
  String get addLinkImage => '이미지 링크 추가';

  @override
  String get appleSignIn => 'Apple로 로그인';

  @override
  String get googleSignIn => 'Google로 로그인';

  @override
  String get signOut => '로그아웃';

  @override
  String get refresh => '새로고침';

  @override
  String get somethingWrong => '문제가 발생했습니다';

  @override
  String get tryAgain => '다시 시도';
}
