class SearchProductModel {
  int? code;
  String? msg;
  Details? details;
  String? paypal;
  Get? get;
  List<Null>? post;

  SearchProductModel(
      {this.code, this.msg, this.details, this.paypal, this.get, this.post});

  SearchProductModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
    paypal = json['paypal'];
    get = json['get'] != null ? new Get.fromJson(json['get']) : null;
    if (json['post'] != null) {
      post = <Null>[];
      json['post'].forEach((v) {
        post!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['paypal'] = this.paypal;
    if (this.get != null) {
      data['get'] = this.get!.toJson();
    }
    if (this.post != null) {
      data['post'] = this.post!.map((v) => v).toList();
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

class Get {
  String? userToken;
  String? merchantId;

  Get({this.userToken, this.merchantId});

  Get.fromJson(Map<String, dynamic> json) {
    userToken = json['user_token'];
    merchantId = json['merchant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_token'] = this.userToken;
    data['merchant_id'] = this.merchantId;
    return data;
  }
}
