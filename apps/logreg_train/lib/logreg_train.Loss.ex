defmodule LogregTrain.Loss do

  def compute(dataset, thetas, house) do
    dataset
            |> sum(thetas, house)
  end

  defp sum(dataset, thetas, house, acc \\ 0, count \\ 0)
  defp sum([], _thetas, _house, acc, count), do: acc / count
  defp sum([user | tail], thetas, house, acc, count) do
    y = if user[Datas.guessed_feature()] == house do 1 else 0 end
    sum(tail, thetas, house, acc + add(thetas, user, y), count + 1)
  end

  defp add(thetas, user, 1) do
    :math.log(Logreg.predict(thetas, user))
  end

  defp add(thetas, user, 0) do
    :math.log(1 - Logreg.predict(thetas, user))
  end

end
