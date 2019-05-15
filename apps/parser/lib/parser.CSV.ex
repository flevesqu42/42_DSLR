defmodule Parser.CSV do
    def parse(file_path) do
        file_path
                    |> File.open
                    |> parse_file
    end

    defp parse_file({:error, _reason}) do
        ErrorHandler.puts :open_file_failed, :critical
    end
    defp parse_file({:ok, pid}) do
        pid
            |> IO.read(:all)
            |> parse_buffer
    end

    defp parse_buffer({:error, reason}) do
        {:error, reason}
    end
    defp parse_buffer(buffer) do
        lines = buffer
                        |> String.trim
                        |> String.split("\n")
        for line <- lines, do: String.split(line, ",")
    end

    def to_map_2d([[_ | g] | t]) do
      (for [h | e] <- t, do: {h, (Enum.zip(g, Enum.map(e, &to_float/1)) |> Enum.into(%{}))}) |> Enum.into(%{})
    end

    def to_map([head | tail]) do
        for e <- tail, do: Enum.zip(head, Enum.map(e, &to_float/1)) |> Enum.into(%{})
    end
    def to_map(_) do
        {:error, :bad_csv_format}
    end

    def to_mapped_list([head | _tail] = list) do
        map = list |> to_map
        (for feature <- head, do: {feature, (for e <- map, do: e[feature])}) |> Enum.into(%{})
    end
    def to_mapped_list(_) do
        {:error, :bad_csv_format}
    end

    defp to_float(string) do
        case Float.parse(string) do
            {num, ""}   -> num
            _           -> string
        end
    end
end
