void main(){
  String A = "12.14";
  try{
    double D = double.parse(A);
    print(D);
  }catch(e){
    print(e);
  }
}