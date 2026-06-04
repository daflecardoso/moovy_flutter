// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get movements => '交易记录';

  @override
  String get emptyMovements => '无交易记录';

  @override
  String youDonTHaveMovements(Object month) {
    return '您在$month没有任何交易记录';
  }

  @override
  String get totalIncome => '总收入';

  @override
  String get totalExpense => '总支出';

  @override
  String get total => '总计';

  @override
  String get incomeExpense => '收支';

  @override
  String get expense => '支出';

  @override
  String get income => '收入';

  @override
  String get expenseDescription => '支出描述';

  @override
  String get expenseDescriptionHint => '例：信用卡账单';

  @override
  String get descriptionCannotBeEmpty => '描述不能为空。';

  @override
  String get amount => '金额';

  @override
  String get amountHint => '例：¥150.00';

  @override
  String get amountDescription => '每月金额';

  @override
  String get amountEmptyValue => '请输入一个值。';

  @override
  String get dueDayExpense => '支出到期日';

  @override
  String get dueDayIsRequired => '到期日为必填项';

  @override
  String get dueDayExpenseHint => '例：10';

  @override
  String get periodOfExpense => '支出周期';

  @override
  String get periodOfExpenseDescription => '如果没有结束日期，请选择开始日期。';

  @override
  String get startDateOrRangeIsRequired => '开始日期或日期范围为必填项。';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get incomeDescription => '收入描述';

  @override
  String get incomeHint => '例：工资';

  @override
  String get incomeDay => '收入日';

  @override
  String get incomeDayIsRequired => '收入日为必填项';

  @override
  String get periodOfIncome => '收入周期';

  @override
  String get settings => '设置';

  @override
  String get currency => '货币';

  @override
  String get selectCurrency => '选择货币';

  @override
  String get americanDollar => '美元';

  @override
  String get euro => '欧元';

  @override
  String get brazilianReal => '巴西雷亚尔';

  @override
  String get danishKrone => '丹麦克朗';

  @override
  String get chineseYuan => '人民币';

  @override
  String get japaneseYen => '日元';

  @override
  String get koreanWon => '韩元';

  @override
  String get language => '语言';

  @override
  String get portuguese => '葡萄牙语';

  @override
  String get english => '英语';

  @override
  String get spanish => '西班牙语';

  @override
  String get danish => '丹麦语';

  @override
  String get german => '德语';

  @override
  String get chinese => '中文';

  @override
  String get japanese => '日语';

  @override
  String get korean => '韩语';

  @override
  String get theme => '主题';

  @override
  String get system => '系统';

  @override
  String get light => '浅色';

  @override
  String get dark => '深色';

  @override
  String get success => '成功';

  @override
  String get changesWasUpdated => '更新成功';

  @override
  String get occurrences => '更新发生次数';

  @override
  String get updateJustIt => '仅此一次';

  @override
  String get updateAppOccurrences => '所有发生次数';

  @override
  String get youMustPickAnOption => '您必须选择一个选项';

  @override
  String get profile => '个人资料';

  @override
  String get imageLink => '图片链接';

  @override
  String get addLinkImage => '添加图片链接';

  @override
  String get appleSignIn => '使用Apple登录';

  @override
  String get googleSignIn => '使用Google登录';

  @override
  String get signOut => '退出登录';

  @override
  String get refresh => '刷新';

  @override
  String get somethingWrong => '出了点问题';

  @override
  String get tryAgain => '重试';
}
