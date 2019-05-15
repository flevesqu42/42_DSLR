defmodule LogregPredict do

  def predict(dataset_path, thetas_path) do
    {dataset, thetas} = LogregPredict.Parse.parse(dataset_path, thetas_path)
    guess_houses dataset, thetas
  end

  defp guess_houses(dataset, thetas, guessed_houses \\ [])
  defp guess_houses([], _thetas, guessed_houses), do: guessed_houses
  defp guess_houses([user | tail], thetas, guessed_houses) do
      guess_houses tail, thetas, [{user[Datas.index()], guess(user, thetas)} | guessed_houses]
  end

  defp guess(user, thetas, houses \\ Datas.houses(), guessed \\ nil)
  defp guess(_user, _thetas, [], {_value, guessed}), do: guessed
  defp guess(user, thetas, [house | tail], nil) do
    guess user, thetas, tail, {Logreg.predict(thetas[house], user), house}
  end
  defp guess(user, thetas, [house | tail], guessed) do
    guess user, thetas, tail, compare_houses(guessed, {Logreg.predict(thetas[house], user), house})
  end

  defp compare_houses({old_value, _old_house}, {new_value, new_house}) when new_value > old_value, do: {new_value, new_house}
  defp compare_houses({old_value, old_house}, {_new_value, _new_house}), do: {old_value, old_house}

end
