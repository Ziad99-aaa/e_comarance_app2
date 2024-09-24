class Items {
  String imglink;
  String location;
  double price;

  Items({
    required this.imglink,
    required this.price,
    this.location="main shop",
  });
}

 List item = [
    Items(imglink: "assets/img/iphone_14_pro_-_silver_1_1_1.jpg", price: 12.99 , location : "zozz store"),
    Items(imglink: "assets/img/14.jpeg", price: 124.99 , location : "3bdo store"),
    Items(imglink: "assets/img/th (1).jpeg", price: 142.99 , location : "7m00 store"),
    Items(imglink: "assets/img/11.jpeg", price: 142.99 , location : "7m00 store"),
    Items(imglink: "assets/img/image.jpeg", price: 142.99 , location : "7m00 store"),
    Items(imglink: "assets/img/14.jpeg", price: 142.99 , location : "7m00 store"),
    Items(imglink: "assets/img/pink.jpeg", price: 162.99),
    Items(imglink: "assets/img/w.jpeg", price: 162.99),
    Items(imglink: "assets/img/th.jpeg", price: 162.99),
    Items(imglink: "assets/img/33.jpeg", price: 162.99),
    Items(imglink: "assets/img/122.jpeg", price: 121.99)
  ];