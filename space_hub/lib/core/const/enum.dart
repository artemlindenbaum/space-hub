enum AuthMode { registration, login }

enum CategoryItemFieldType {
  text,
  group,
  attach,
  dropdown,
  dropdownList,
  phone,
  location,
  radio,
  checkBox,
  date,
  dateTime,
}

enum TripMenuAction {
  viewOnMap('Посмотреть на карте'),
  share('Поделиться отслеживанием'),
  edit('Редактировать');

  const TripMenuAction(this.description);
  final String description;
}

enum DbCategory {
  cargoTransport('Заказы грузового транспорта'),
  container('Заказы контейнеровоза'),
  transport('Транспорт'),
  drivers('Водители'),
  cargo('Грузы'),
  counterparties('Контрагенты'),
  clients('Клиенты');

  const DbCategory(this.description);
  final String description;

  static DbCategory fromString(String value) =>
      DbCategory.values.firstWhere((e) => e.name == value);
}

enum TripStatus$Driver {
  start('Начать рейс'),
  onTheWayForFilling('В пути на погрузку'),
  arrivedForFilling('Прибыл на погрузку'),
  filling('Погрузка'),
  fillingDone('Погрузка завершена'),
  onTheWayForDelivery('В пути на доставку'),
  arrivedForUnfilling('Прибыл на выгрузку'),
  unfilling('Выгрузку'),
  unfillingDone('Выгрузка завершена'),
  done('Доставлен'),
  problems('Проблема / Отклонение');

  const TripStatus$Driver(this.description);
  final String description;
}

enum TripStatus$Manager {
  draft('Черновик'),
  underApproval('На согласовании'),
  confirmed('Подтверждён'),
  appointed('Назначен'),
  canceled('Отменён'),
  onHold('На удержании'),
  done('Доставлен'),
  problems('Проблема / Отклонение');

  const TripStatus$Manager(this.description);
  final String description;
}
