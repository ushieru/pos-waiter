List<List<T?>> rotate2dMatrix<T>(List<List<T?>> matrix) {
  final List<List<T?>> newList2d = List.generate(
      matrix[0].length, (_) => List.generate(matrix.length, (_) => null));
  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
      newList2d[j][matrix.length - 1 - i] = matrix[i][j];
    }
  }
  return newList2d;
}
