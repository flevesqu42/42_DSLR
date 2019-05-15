defmodule Display do
  def puts(what, opts \\ %{}) do
    case what do
      :describe   -> Display.Describe.puts(opts.describe)
      :train      -> inspect opts.thetas
    end |> IO.puts
  end
end
