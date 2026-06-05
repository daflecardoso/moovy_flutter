import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/repository/movement_repository.dart';

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
  Future<List<Movement>> findByMonthYear(String dateTime) async {
    final _now = DateTime.now();

    Movement _m(String? imageUrl, String desc, int amount, MovementType type, {int? dueDay, int? incomeDay}) {
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

    return <Movement>[
      _m(
        'https://img.magnific.com/vetores-gratis/bela-casa_24877-50819.jpg',
        'Aluguel',
        180000,
        MovementType.expense,
        dueDay: 5,
      ),
      _m(
        'https://fisenge.org.br/wp-content/uploads/2021/01/maos_dinheiro-1024x1024.jpg',
        'Salário',
        600000,
        MovementType.income,
        incomeDay: 5,
      ),
      _m(
        'https://upload.wikimedia.org/wikipedia/commons/f/ff/Netflix-new-icon.png',
        'Netflix',
        4990,
        MovementType.expense,
        dueDay: 15,
      ),
      _m('https://m.media-amazon.com/images/I/31B2Nyzd8XL.png', 'Spotify', 2190, MovementType.expense, dueDay: 1),
      _m(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2959EOX3dVuJFmVCMWh71jy7XY1v4KQFlqQ&s',
        'Freelance',
        150000,
        MovementType.income,
        incomeDay: 20,
      ),
      _m(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6A6Wu7MCCEpYLascNBj5PbQuxlWLXHhDUfQ&s',
        'Internet',
        9990,
        MovementType.expense,
        dueDay: 10,
      ),
      _m(
        'https://media.istockphoto.com/id/2223757149/pt/vetorial/grocery-store-supermarket-people-choosing-goods-on-the-shelves-of-the-store-vector.jpg?s=612x612&w=0&k=20&c=ts0BvsL7zZfAJudGlaB1tISfBsMAxQMuUwgdfJeVvmA=',
        'Supermercado',
        35000,
        MovementType.expense,
        dueDay: 15,
      ),
      _m(
        'https://acadbrasil.com.br/wp-content/uploads/2022/04/3-dicas-para-aproveitar-melhor-o-espaco-da-academia-1024x681.jpg',
        'Academia',
        8990,
        MovementType.expense,
        dueDay: 1,
      ),
    ];
  }

  @override
  Future<void> insertMovement(Movement movement) {
    // TODO: implement insertMovement
    throw UnimplementedError();
  }

  @override
  Future<int> updateMovement(Movement movement) {
    // TODO: implement updateMovement
    throw UnimplementedError();
  }
}
