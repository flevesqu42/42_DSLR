defmodule LogregTrain.Thetas do

  @learning_rate  1.0

  def compute(dataset, describe, house, thetas) do
    dataset
            |> sum(thetas, house)
            |> post_process(describe)
            |> add(thetas)
  end

  defp add(tmp_thetas, thetas, classes \\ Datas.classes())
  defp add(_tmp_thetas, thetas, []), do: thetas
  defp add(tmp_thetas, thetas, [class | tail]) do
    add tmp_thetas, %{thetas | class => thetas[class] - tmp_thetas[class]}, tail
  end

  defp sum(dataset, thetas, house, new_thetas \\ Datas.features())
  defp sum([], _thetas, _house, new_thetas), do: new_thetas
  defp sum([user | tail], thetas, house, new_thetas) do
    sum tail, thetas, house, evaluate_theta(user, thetas, new_thetas, house)
  end

  defp evaluate_theta(user, thetas, new_thetas, house, classes \\ Datas.classes())
  defp evaluate_theta(_user, _thetas, new_thetas, _house, []), do: new_thetas
  defp evaluate_theta(user, thetas, new_thetas, house, [class | tail]) do
    y = if user[Datas.guessed_feature()] == house do 1 else 0 end
    add = (Logreg.predict(thetas, user) - y) * value(user[class])
    evaluate_theta user, thetas, %{new_thetas | class => new_thetas[class] + add}, house, tail
  end

  defp post_process(thetas, describe, classes \\ Datas.classes())
  defp post_process(thetas, _describe, []), do: thetas
  defp post_process(thetas, describe, [class | tail]) do
    value = (thetas[class] / describe[class].count) * @learning_rate
    post_process %{thetas | class => value}, describe, tail
  end

  defp value(""), do: 0
  defp value(x), do: x

end
