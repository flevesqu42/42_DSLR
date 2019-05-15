defmodule Describe do

  @classes Datas.classes

  def get_informations(data_set_path) do
    data_set_path
                  |> Parser.CSV.parse
                  |> Parser.CSV.to_map
                  |> describe_features
  end

  def describe_features({:error, reason}) do
    ErrorHandler.puts reason, :critical
  end
  def describe_features(data_map) do
    @classes |> Enum.map(fn e -> {e, Describe.Feature.informations_from(data_map, e)} end) |> Map.new
  end

end
