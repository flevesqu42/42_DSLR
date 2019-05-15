defmodule LogregPredict.Parse do

  def parse(dataset_path, thetas_path) do
    dataset = parse_dataset dataset_path
    thetas = parse_thetas(thetas_path)

    {standardize(dataset, thetas), thetas}
  end

  defp parse_dataset(dataset_path) do
    dataset_path
                |> Parser.CSV.parse
                |> Parser.CSV.to_map
  end

  defp parse_thetas(thetas_path) do
    thetas_path
                |> Parser.CSV.parse
                |> Parser.CSV.to_map_2d
  end

  defp standardize(dataset, thetas, acc \\ [])
  defp standardize([], _thetas, acc), do: acc
  defp standardize([user | tail], thetas, acc) do
    standardize tail, thetas, [standardized_user(user, thetas) | acc]
  end

  defp standardized_user(user, thetas, features \\ Datas.classes())
  defp standardized_user(user, _thetas, []), do: user
  defp standardized_user(user, thetas, [feature | tail]) do
    case {user[feature], thetas["mean"][feature], thetas["range"][feature]} do
      {nil, _, _}         -> ErrorHandler.puts :bad_csv_format, :critical
      {_, nil, _}         -> ErrorHandler.puts :bad_csv_format, :critical
      {_, _, nil}         -> ErrorHandler.puts :bad_csv_format, :critical
      {"", _, _}          -> standardized_user user, thetas, tail
      {num, mean, range}  -> standardized_user %{user | feature => (num - mean) / range * 2.0}, thetas, tail
    end
  end


end
