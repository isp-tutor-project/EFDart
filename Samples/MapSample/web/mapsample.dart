import 'dart:html';

void main() 
{
  var     map  = new Map();
  int     iNum = 2;
  String  screenText;   
  
  map[1]    = "test1";
  map[iNum] = "test2";
  map[2]    = "test3";
  map[3]    = "test4";
  
  iNum = 1;
  
  screenText = map[1];
    
  Point myPoint1 = new Point(2,3);
  Point myPoint2 = new Point(2,3);
  Point myPoint3 = myPoint1;
  
  assert(myPoint1 == myPoint3);
  assert(myPoint1 != myPoint2);
  
  map[myPoint1] = "pointTest1";
  map[myPoint2] = "pointTest2";
    
  query("#sample_text_id").text = map[myPoint3];  
}


class Point 
{
  num x;
  num y;

  Point(this.x, this.y);

  // Named constructor
  Point.fromJson(Map json) 
  {
    x = json['x'];
    y = json['y'];
  }
  
}

/*
screenText = map[1];

Point myPoint1 = const Point(2,3);
Point myPoint2 = const Point(2,3);
Point myPoint3 = myPoint1;

assert(myPoint1 == myPoint3);
assert(myPoint1 == myPoint2);

map[myPoint1] = "pointTest1";
map[myPoint2] = "pointTest2";

query("#sample_text_id").text = map[myPoint1];  
}


class ImmutablePoint 
{
  final num x;
  final num y;

  const ImmutablePoint(this.x, this.y);

  
}
*/