defmodule Accuracy.CLI do

  def main([theta_path | [dataset_path | _]]) do
    dataset_path
                  |> Accuracy.compute(theta_path)
                  |> out
  end

  def main(_) do
      ErrorHandler.puts :not_enough_arguments
      usage()
  end

  defp usage do
      IO.puts :stderr, "Usage: ./accuracy [thetas_path] [data_set_path]"
  end

  defp out(accuracy) do
    IO.puts "from #{accuracy.count} users in dataset, #{accuracy.trues} predictions (#{accuracy.trues/accuracy.count*100}%) were relevants."
  end

end
