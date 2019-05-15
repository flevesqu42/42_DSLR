defmodule ScatterPlot.CLI do

  def main([dataset_path | []]) do
    dataset_path
                  |> Parser.CSV.parse
                  |> Parser.CSV.to_map
                  |> Datas.split_map_by_classes
                  |> ScatterPlot.display
  end

  def main([]) do
    ErrorHandler.puts :not_enough_arguments
  end

  def main(_) do
    ErrorHandler.puts :too_much_arguments
  end

  def usage do
    IO.puts :stderr, "Usage: ./scatter_plot [dataset_path]"
  end

end
