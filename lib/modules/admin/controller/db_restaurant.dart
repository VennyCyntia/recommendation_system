import 'package:path/path.dart';
import 'package:recommendation_system/app/models/view_admin.dart';
import 'package:sqflite/sqflite.dart';

class RestaurantDatabase {
  static const _databaseName = 'restaurant.db';
  static const _databaseVersion = 1;

  static const _tableRestaurant = 'restaurant';
  static const _tableEmployee = 'employee';
  static const _tableMenu = 'menu';

  static const _columnId = 'id';

  //COLUMN RESTAURANT
  static const _columnRestaurantName = 'restaurantname';
  static const _columnRestaurantDescription = 'description';

  //COLUMN EMPLOYEE
  static const _columnEmployeeName = 'username';
  static const _columnEmail = 'email';
  static const _columnNoTelepon = 'notelepon';
  static const _columnPassword = 'password';
  static const _columnRole = 'role';

  RestaurantDatabase._privateConstructor();

  static final instance = RestaurantDatabase._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    _database = await initializeDB();
    if (_database != null) {
      return _database;
    } else {
      _database = await initializeDB();
      return _database;
    }
  }

  initializeDB() async {
    String pathDB = await getDatabasesPath();
    String path = join(pathDB, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableRestaurant(
    $_columnId INTEGER PRIMARY KEY,
    $_columnRestaurantName TEXT NOT NULL,
    $_columnRestaurantDescription TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE $_tableEmployee(
    $_columnId INTEGER PRIMARY KEY,
    $_columnEmployeeName TEXT NOT NULL,
    $_columnEmail TEXT,
    $_columnNoTelepon TEXT NOT NULL,
    $_columnPassword TEXT NOT NULL,
    $_columnRole TEXT NOT NULL
    )
    ''');
  }

  //RESTAURANT
  Future<void> insertRestaurant(List<ViewRestaurant> restaurant) async {
    Database? db = await instance.database;

    for (int i = 0; i < restaurant.length; i++) {
      await db!.rawInsert(
          'INSERT INTO $_tableRestaurant ('
              '$_columnRestaurantName, $_columnRestaurantDescription) '
              'VALUES (?, ?)',
          [
            restaurant[i].restaurant_name,
            restaurant[i].restaurant_description,
          ]);
    }
  }

  Future<List<Map<String, dynamic>>> selectAllRestaurant() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = [];
    result = await db!.rawQuery("SELECT * FROM $_tableRestaurant");

    return result;
  }

  Future<ViewRestaurant> selectRestaurantByID({required int id}) async {
    Database? db = await instance.database;
    var restaurant = ViewRestaurant();
    var result = await db!
        .rawQuery("Select * from $_tableRestaurant where $_columnId = '$id'");
    for (var item in result) {
      restaurant = ViewRestaurant.fromMap(item);
    }

    return restaurant;
  }

  Future<void> updateRestaurantByID(
      {required int id,
        required String restaurantname,
        required String restaurantdescription}) async {
    Database? db = await instance.database;
    await db!.rawUpdate(
        '''UPDATE $_tableRestaurant SET $_columnRestaurantName = ?, $_columnRestaurantDescription = ? WHERE $_columnId = ?''',
        [restaurantname, restaurantdescription, id]);
  }

  Future<int> deleteRestaurantByID({required int id}) async {
    int result = 0;
    Database? db = await instance.database;
    result =
    await db!.rawDelete('DELETE FROM $_tableRestaurant WHERE ID = ?', [id]);

    return result;
  }

  //EMPLOYEE
  Future<void> insertEmployee(List<ViewEmployee> employee) async {
    Database? db = await instance.database;

    for (int i = 0; i < employee.length; i++) {
      await db!.rawInsert(
          'INSERT INTO $_tableEmployee ('
              '$_columnEmployeeName, $_columnEmail, $_columnNoTelepon, $_columnPassword, $_columnRole) '
              'VALUES (?, ?, ?, ?, ?)',
          [
            employee[i].username,
            employee[i].email,
            employee[i].no_telp,
            employee[i].password,
            employee[i].role,
          ]);
    }
  }

  Future<List<Map<String, dynamic>>> selectAllEmployee() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = [];
    result = await db!.rawQuery("SELECT * FROM $_tableEmployee");

    return result;
  }

  Future<ViewEmployee> selectEmployeeByID({required int id}) async {
    Database? db = await instance.database;
    var employee = ViewEmployee();
    var result = await db!
        .rawQuery("Select * from $_tableEmployee where $_columnId = '$id'");
    for (var item in result) {
      employee = ViewEmployee.fromMap(item);
    }

    return employee;
  }

  Future<int> updateEmployeeByID(
      {required int id,
        required String username,
        required String email,
        required String notelepon,
        required String password,
        required String role}) async {
    int result = 0;
    Database? db = await instance.database;
    result = await db!.rawUpdate(
        '''UPDATE $_tableEmployee SET $_columnEmployeeName = ?, $_columnEmail = ?, $_columnNoTelepon = ?, $_columnPassword = ?, $_columnRole = ? WHERE $_columnId = ?''',
        [username, email, notelepon, password, role, id]);
    return result;
  }

  Future<int> deleteEmployeeByID({required int id}) async {
    int result = 0;
    Database? db = await instance.database;
    result =
    await db!.rawDelete('DELETE FROM $_tableEmployee WHERE ID = ?', [id]);

    return result;
  }
}
