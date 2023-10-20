import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:recommendation_system/app/models/view_restaurant.dart';

class RestaurantDatabase {
  static const _databaseName = 'restaurant.db';
  static const _databaseVersion = 1;

  static const _tableMenu = 'menu';

  static const _columnId = 'id';

  //COLUMN MENU
  static const _columnTitle = 'title';
  static const _columnSubtitle = 'subtitle';
  static const _columnCategory = 'category';
  static const _columnDescription = 'description';
  static const _columnPrice = 'price';
  static const _columnPic = 'pic';

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
    CREATE TABLE $_tableMenu(
    $_columnId INTEGER PRIMARY KEY,
    $_columnTitle TEXT NOT NULL,
    $_columnSubtitle TEXT NOT NULL,
    $_columnCategory TEXT NOT NULL,
    $_columnDescription TEXT NOT NULL,
    $_columnPrice INTEGER NOT NULL,
    $_columnPic TEXT NOT NULL
    )
    ''');
  }

  //RESTAURANT
  Future<void> insertMenu(List<ViewMenu> menu) async {
    Database? db = await instance.database;

    for (int i = 0; i < menu.length; i++) {
      await db!.rawInsert(
          'INSERT INTO $_tableMenu ('
              '$_columnTitle, $_columnSubtitle, $_columnCategory, $_columnDescription, $_columnPrice, $_columnPic) '
              'VALUES (?, ?, ?, ?, ?, ?)',
          [
            menu[i].title,
            menu[i].subtitle,
            menu[i].category,
            menu[i].description,
            menu[i].price,
            menu[i].pic,
          ]);
    }
  }

  Future<List<Map<String, dynamic>>> selectAllMenu() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = [];
    result = await db!.rawQuery("SELECT * FROM $_tableMenu");

    return result;
  }

  Future<ViewMenu> selectMenuByID({required int id}) async {
    Database? db = await instance.database;
    var menu = ViewMenu();
    var result = await db!
        .rawQuery("Select * from $_tableMenu where $_columnId = '$id'");
    for (var item in result) {
      menu = ViewMenu.fromMap(item);
    }

    return menu;
  }

  Future<void> updateMenuByID(
      {required ViewMenu menu}) async {
    Database? db = await instance.database;
    await db!.rawUpdate(
        '''UPDATE $_tableMenu SET $_columnTitle = ?, $_columnSubtitle = ?, $_columnCategory = ?, $_columnDescription = ?, $_columnPrice = ?, $_columnPic = ? WHERE $_columnId = ?''',
        [menu.title, menu.subtitle, menu.category, menu.description, menu.price, menu.pic, menu.id]);
  }

  Future<int> deleteMenuByID({required int id}) async {
    int result = 0;
    Database? db = await instance.database;
    result = await db!.rawDelete('DELETE FROM $_tableMenu WHERE ID = ?', [id]);

    return result;
  }
}
