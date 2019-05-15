defmodule ErrorHandler do

  def puts(reason, critical \\ :non_critical)
  def puts(reason, :non_critical) do
    display reason
  end
  def puts(reason, :critical) do
    display reason
    System.halt 1
  end

  defp display(reason) do
    case reason do
      :not_enough_arguments -> "Error: not enough arguments."
      :too_much_arguments   -> "Error: too much arguments."
      :bad_csv_format       -> "Error: bad CSV format."
      :non_existant_feature -> "Error: non existant feature."
      :open_file_failed     -> "Error: cannot open file."
      _                     -> "Error: unknown error."
    end |> (&IO.puts(:stderr, &1)).()
  end

end
