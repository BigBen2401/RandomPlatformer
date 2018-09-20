// Processing has a built-in PVector class, but the physics are a
// major objective of my project, so I created my own implementation.
class Vector {

  // This is a 2D game, so I only need x and y dimensions.
  // Note that (0,0) is the top left corner in Processing.
  float x, y;
  Vector(float _x, float _y) {
    x = _x; 
    y = _y;
  }
  // This allows me to easily print the value of a vector.
  String toString() {
    return "("+x+","+y+")";
  }

  // Add to this vector.
  void add(float xAlt, float yAlt) {
    x += xAlt;
    y += yAlt;
  }
  void add(Vector v) {
    add(v.x, v.y);
  }

  // Subtract from this vector.
  void sub(float xAlt, float yAlt) {
    x -= xAlt;
    y -= yAlt;
  }
  void sub(Vector v) {
    sub(v.x, v.y);
  }

  // Multiply this vector.
  void mul(float scalX, float scalY) {
    x *= scalX;
    y *= scalY;
  }
  void mul(float scal) {
    mul(scal, scal);
  }

  // Divide this vector.
  void div(float scalX, float scalY) {
    x /= scalX;
    y /= scalY;
  }
  void div(float scal) {
    div(scal, scal);
  }

  // Constrain to a certain range, and return whether or not it had to be constrained.
  boolean conX(float min, float max) {
    if (x < min || x > max) {
      x = constrain(x, min, max);
      return true;
    } else {
      return false;
    }
  }
  boolean conY(float min, float max) {
    if (y < min || y > max) {
      y = constrain(y, min, max);
      return true;
    } else {
      return false;
    }
  }

  // Modulo the vector. I add val to reduce the risk of errors from negative numbers.
  void modX(float val) {
    x = (x+val)%val;
  }
  void modY(float val) {
    y = (y+val)%val;
  }

  // Create a new vector using the current one.
  Vector copy() {
    return new Vector(x, y);
  }
}