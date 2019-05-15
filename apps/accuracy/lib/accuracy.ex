defmodule Accuracy do

  def compute(dataset_path, theta_path) do
    dataset_path
                  |> Parser.CSV.parse
                  |> Parser.CSV.to_map
                  |> compare(LogregPredict.predict(dataset_path, theta_path))
  end

  defp compare(dataset, predictions, count \\ 0, trues \\ 0)
  defp compare([], [], count, trues), do: %{count: count, trues: trues}
  defp compare([user | dataset], [{_id, house} | predictions], count, trues) do
      compare dataset, predictions, count + 1, trues + (if user[Datas.guessed_feature()] == house do 1 else 0 end)
  end

end
