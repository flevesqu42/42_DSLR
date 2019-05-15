defmodule Logreg do
  @e  2.718281828459045

  def predict(thetas, x) do
    thetas
          |> dot_product(x)
          |> sigmoid
  end

  defp dot_product(thetas, x, classes \\ Datas.classes(), acc \\ 0)
  defp dot_product(_thetas, _x, [], acc), do: acc
  defp dot_product(thetas, x, [class | tail], acc) do
      dot_product thetas, x, tail, acc + dot(thetas[class], x[class])
  end

  defp dot(_t, ""), do: 0
  defp dot(t, x) do
    t * x
  end

  defp sigmoid(z) do
    1 / (1 + :math.pow(@e, -z))
  end

end
