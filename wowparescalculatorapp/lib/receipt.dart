class ReceiptData {
  // Dishes
  int paresRegularAmount;
  int paresMamiAmount;
  int paresBagnetAmount;
  int paresOverloadAmount;
  int lugawAmount;
  int lugawSpecialAmount;

  // Drinks
  int cokeAmount;
  int spriteAmount;
  int mountainDewAmount;
  int royalAmount;
  int waterBottleSmallAmount;
  int waterBottleLargeAmount;

  // Extra
  int rice;
  int egg;
  int tokwa;

  // User Money
  int userMoney;

  ReceiptData({
    this.paresRegularAmount = 0,
    this.paresMamiAmount = 0,
    this.paresBagnetAmount = 0,
    this.paresOverloadAmount = 0,
    this.lugawAmount = 0,
    this.cokeAmount = 0,
    this.spriteAmount = 0,
    this.mountainDewAmount = 0,
    this.royalAmount = 0,
    this.waterBottleSmallAmount = 0,
    this.rice = 0,
    this.lugawSpecialAmount = 0,
    this.waterBottleLargeAmount = 0,  
    this.egg = 0,
    this.tokwa = 0,
    this.userMoney = 0,
  });

  getTotal() {}

  ReceiptData copyWith({
    int? paresRegularAmount,
    int? paresMamiAmount,
    int? paresBagnetAmount,
    int? paresOverloadAmount,
    int? lugawAmount,
    int? cokeAmount,
    int? spriteAmount,
    int? mountainDewAmount,
    int? royalAmount,
    int? waterBottleSmallAmount,
    int? rice,
    int? userMoney,
    int? lugawSpecialAmount,
    int? waterBottleLargeAmount,  
    int? egg,
    int? tokwa,
  }) {
    return ReceiptData(
      paresRegularAmount: paresRegularAmount ?? this.paresRegularAmount,
      paresMamiAmount: paresMamiAmount ?? this.paresMamiAmount,
      paresBagnetAmount: paresBagnetAmount ?? this.paresBagnetAmount,
      paresOverloadAmount: paresOverloadAmount ?? this.paresOverloadAmount,
      lugawAmount: lugawAmount ?? this.lugawAmount,
      cokeAmount: cokeAmount ?? this.cokeAmount,
      spriteAmount: spriteAmount ?? this.spriteAmount,
      mountainDewAmount: mountainDewAmount ?? this.mountainDewAmount,
      royalAmount: royalAmount ?? this.royalAmount,
      waterBottleSmallAmount: waterBottleSmallAmount ?? this.waterBottleSmallAmount,
      rice: rice ?? this.rice,
      lugawSpecialAmount: lugawSpecialAmount ?? this.lugawSpecialAmount,
      waterBottleLargeAmount: waterBottleLargeAmount ?? this.waterBottleLargeAmount,
      egg: egg ?? this.egg,
      tokwa: tokwa ?? this.tokwa,
      userMoney: userMoney ?? this.userMoney,
    );
  }

  // You can add toJson, fromJson, etc. if needed
}