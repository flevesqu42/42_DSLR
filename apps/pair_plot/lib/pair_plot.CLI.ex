defmodule PairPlot.CLI do
  def main([dataset_path | _args]) do
      dataset_path
                    |> Parser.CSV.parse
                    |> Parser.CSV.to_map
                    |> Datas.split_map_by_classes
                    |> PairPlot.display
  end

  def main([]) do
      ErrorHandler.puts :not_enough_arguments
      usage()
  end

  def main(_) do
      ErrorHandler.puts :too_much_arguments
      usage()
  end

  defp usage do
      IO.puts :stderr, "Usage: ./histogram [data_set_path]"
  end

end
