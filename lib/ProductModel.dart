class ProductModel {
  int? code;
  String? msg;
  Details? details;

  ProductModel({this.code, this.msg, this.details});

  ProductModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  List<Data>? data;
  Lang? lang;

  Details({this.data, this.lang});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    lang = json['lang'] != null ? new Lang.fromJson(json['lang']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.lang != null) {
      data['lang'] = this.lang!.toJson();
    }
    return data;
  }
}

class Data {
  String? itemName;
  String? itemDescription;
  String? size;
  String? photo;
  String? itemId;
  String? price;
  String? status;
  String? multibuy;
  String? maxlimit;
  String? categoryId;
  String? discountedPrice;
  String? promotion;
  String? discount;

  Data(
      {this.itemName,
      this.itemDescription,
      this.size,
      this.photo,
      this.itemId,
      this.price,
      this.status,
      this.multibuy,
      this.maxlimit,
      this.categoryId,
      this.discountedPrice,
      this.promotion,
      this.discount});

  Data.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemDescription = json['item_description'];
    size = json['size'];
    photo = json['photo'];
    itemId = json['item_id'];
    price = json['price'];
    status = json['status'];
    multibuy = json['multibuy'];
    maxlimit = json['maxlimit'];
    categoryId = json['category_id'];
    discountedPrice = json['discounted_price'];
    promotion = json['promotion'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['item_description'] = this.itemDescription;
    data['size'] = this.size;
    data['photo'] = this.photo;
    data['item_id'] = this.itemId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['multibuy'] = this.multibuy;
    data['maxlimit'] = this.maxlimit;
    data['category_id'] = this.categoryId;
    data['discounted_price'] = this.discountedPrice;
    data['promotion'] = this.promotion;
    data['discount'] = this.discount;
    return data;
  }
}

class Lang {
  String? product;

  Lang({this.product});

  Lang.fromJson(Map<String, dynamic> json) {
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    return data;
  }
}
