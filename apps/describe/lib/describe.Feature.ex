defmodule Describe.Feature do

    alias Describe.Feature.Informations

    def informations_from(data_map, feature) do
        data_map
                    |> to_float_list(feature)
                    |> Informations.new_from(feature)
    end

    defp to_float_list(data_map, feature) do
        for data <- data_map, do: get_float(data[feature])
    end

    defp get_float(data) when is_number data do data end
    defp get_float(nil), do: ErrorHandler.puts :bad_csv_format, :critical
    defp get_float(_data), do: :missing
    # defp get_float(data) do
    #   IO.puts inspect data
    #   :missing
    # end

end
