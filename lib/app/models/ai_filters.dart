
class AiFilters{
  String field;
  var value;
  String operator;
  AiFilters({
    required this.field,
    required this.value,
    required this.operator
  });
  operate(datas){
    var val;
    var res;
    try{
      val = int.parse(value);
    }catch(e){
      val = null;
    }
    datas.forEach((data){
      if(val != null){
        value = int.tryParse(value);
        if(operator == ">="){
          if(data[field] >= value){
            res = data;
          }
        }
        else if(operator == "<="){
          if(data[field] <= value){
            res = data;
          }
        }
        else if(operator == "="){
          if(data[field] == value){
            res = data;
          }
        }
        else if(operator == ">"){
          if(data[field] > value){
            res = data;
          }
        }
        else if(operator == "<"){
          if(data[field] < value){
            res = data;
          }
        }
      }else{
        if(data[field] == value){
          res = data;
        }
      }
    });
    return res;
  }
}