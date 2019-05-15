defmodule LogregPredict.CLI do

    def main([thetas_path | [dataset_path | _tail]]) do
      LogregPredict.predict(dataset_path, thetas_path)
                                                        |> out
    end

    def main(_) do
        ErrorHandler.puts :not_enough_arguments
        usage()
    end

    defp usage do
        IO.puts :stderr, "Usage: ./logreg_predict [thetas_path] [data_set_path]"
    end

    defp out(predictions) do
      File.open("./houses.csv", [:write])
                                            |> output(predictions)
    end

    defp output({:error, _reason}, _predictions) do
      ErrorHandler.puts :open_file_failed, :critical
    end
    defp output({:ok, pid}, predictions) do
      IO.puts pid, "#{Datas.index()},#{Datas.guessed_feature()}"
      for {id, house} <- predictions, do: IO.puts pid, "#{round id},#{house}"
      IO.puts "`houses.csv` file generated."

    end

end
