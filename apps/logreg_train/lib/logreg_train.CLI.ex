defmodule LogregTrain.CLI do
    def main([data_set_path | _args]) do
      data_set_path
                      |> LogregTrain.train
                      |> out
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
      IO.puts :stderr, "Usage: ./logreg_train [data_set_path]"
    end

    defp out({thetas, describe}) do
      File.open("./thetas.csv", [:write])
                                          |> output(thetas, describe)
    end

    defp output({:error, _reason}, _thetas, _describe) do
      ErrorHandler.puts :open_file_failed, :critical
    end
    defp output({:ok, pid}, thetas, describe) do
      IO.puts(pid, "Meta,#{Enum.join(Datas.classes(), ",")}")
      IO.puts(pid, "mean,#{Enum.join((for class <- Datas.classes(), do: describe[class].mean), ",")}")
      IO.puts(pid, "range,#{Enum.join((for class <- Datas.classes(), do: describe[class].range), ",")}")
      for house <- Datas.houses(), do: IO.puts(pid, "#{house},#{Enum.join((for class <- Datas.classes(), do: thetas[house][class]), ",")}")
      IO.puts "`thetas.csv` file generated."
    end
  end
