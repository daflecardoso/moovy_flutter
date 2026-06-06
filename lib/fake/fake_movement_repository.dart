import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:moovy/movement_list/view/movement_ui.dart';
import 'package:moovy/navigation_service.dart';
import 'package:moovy/repository/movement_repository.dart';

import '../gen/assets.gen.dart';

class FakeMovementRepository implements MovementRepository {
  @override
  late MovementDao movementDao;

  @override
  Future<void> deleteById(String id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Future<Movement?> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<List<MovementUi>> findByMonthYear(String dateTime) async {
    final now = DateTime.now();

    MovementUi m(AssetGenImage? image, String desc, int amount, MovementType type, {int? dueDay, int? incomeDay}) {
      return MovementUi(
        id: desc,
        firestoreId: null,
        description: desc,
        amount: amount,
        dueDay: dueDay,
        incomeDay: incomeDay,
        startDate: DateTime(now.year, now.month, 1),
        endDate: null,
        startYm: now.yearMonth(),
        endYm: null,
        paid: false,
        image: MovementImageAsset(image),
        type: type,
        createdAt: now,
        updatedAt: now,
      );
    }

    final appLocalization = AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!;
    return [
      m(Assets.icon.house, appLocalization.rent, 180000, MovementType.expense, dueDay: 5),
      m(Assets.icon.salary, appLocalization.salary, 600000, MovementType.income, incomeDay: 5),
      m(Assets.icon.netflix, appLocalization.netflix, 4990, MovementType.expense, dueDay: 15),
      m(Assets.icon.spotfy, appLocalization.spotify, 2190, MovementType.expense, dueDay: 1),
      m(Assets.icon.internet, appLocalization.internet, 9990, MovementType.expense, dueDay: 10),
      m(Assets.icon.supermarket, appLocalization.supermarket, 35000, MovementType.expense, dueDay: 15),
      m(Assets.icon.gym, appLocalization.gym, 8990, MovementType.expense, dueDay: 1),
    ];
  }

  @override
  Future<void> insertMovement(Movement movement) {
    // TODO: implement insertMovement
    throw UnimplementedError();
  }

  @override
  Future<int> updateMovement(MovementUi movement) {
    // TODO: implement updateMovement
    throw UnimplementedError();
  }

  @override
  MovementUi map(Movement movement) {
    // TODO: implement map
    throw UnimplementedError();
  }

  Future<int> updateMovementUi(MovementUi mui) {
    // TODO: implement updateMovementUi
    throw UnimplementedError();
  }
}
