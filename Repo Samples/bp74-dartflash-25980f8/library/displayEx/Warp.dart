class Warp extends DisplayObjectContainer
{
  Matrix _matrix;

  Warp()
  {
    _matrix = new Matrix.identity();
  }

  //-------------------------------------------------------------------------------------------------

  Matrix get _transformationMatrix() => _matrix;
  Matrix get matrix() => _matrix;

  void set matrix(Matrix value)
  {
    _matrix = value;
  }

}
