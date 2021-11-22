abstract class PriceEvent{}

class PriceFetch extends PriceEvent{}
class ProductPriceFetch extends PriceEvent{}
class AddPrice  extends PriceEvent{
  String item;
  String price;
  AddPrice(this.item,this.price);
}

class UpdatePrice extends PriceEvent{
  String product;
  String price;
  
  UpdatePrice(this.product,this.price);
}

class DeletePrice extends PriceEvent{
  String product;
  int price;
  
  DeletePrice(this.product,this.price);
}