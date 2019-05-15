defmodule Describe.CLI do
  def main([data_set_path | _]) do
    data_set_path
                  |> Describe.get_informations
                  |> (&Display.puts(:describe, %{describe: &1})).()
      
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
    IO.puts :stderr, "Usage: ./describe [data_set_path]"
  end
end
