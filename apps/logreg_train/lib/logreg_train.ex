defmodule LogregTrain do

  # @delta  0.15
  @count  2

	def train(dataset_path) do
		dataset_path
						|> Parser.CSV.parse
						|> Parser.CSV.to_map
						|> parse
            |> compute
	end

  defp parse(dataset) do
    describe = Describe.describe_features(dataset)
		{Datas.standardise(dataset, describe), describe}
	end

  defp compute(input, thetas \\ Datas.all_thetas(), houses \\ Datas.houses())
  defp compute({_dataset, describe}, thetas, []), do: {thetas, describe}
  defp compute({dataset, describe}, thetas, [house | tail]) do
    compute {dataset, describe}, %{thetas | house => get_thetas(dataset, describe, house)}, tail
  end

  defp get_thetas(dataset, describe, house, thetas \\ Datas.features(), count \\ @count)
  defp get_thetas(_dataset, _describe, _house, thetas, count) when count <= 0, do: thetas
  defp get_thetas(dataset, describe, house, thetas, count) do
    thetas = LogregTrain.Thetas.compute(dataset, describe, house, thetas)
    get_thetas(dataset, describe, house, thetas, count - 1)
  end

end
