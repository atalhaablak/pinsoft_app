// Menüye güzel görüntü için eklenen kategorilerin model yapısı.

class MenuModel {
  String title;

  MenuModel({this.title});

  static List<MenuModel> menu = [
    MenuModel(
      title: "Tümü",
    ),
    MenuModel(
      title: "Aksiyon",
    ),
    MenuModel(
      title: "Komedi",
    ),
    MenuModel(
      title: "Romantik",
    ),
    MenuModel(
      title: "Fantastik",
    ),
  ];
}
