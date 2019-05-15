defmodule Display.Describe do
    @features Datas.classes()

    def puts(describe) do
        width = describe_width(describe)

        to_string describe_display_first_line(width) ++ for feature <- @features, do: describe_feature(describe[feature], width)
    end

    defp describe_width(describe, features \\ @features, acc \\ 0)
    defp describe_width(_describe, [], acc), do: acc
    defp describe_width(describe, [head | tail], acc) do
        case String.length(describe[head].name) do
            len when len > acc  -> describe_width(describe, tail, len)
            _                   -> describe_width(describe, tail, acc)
        end
    end

    defp describe_display_first_line(width) do
        :io_lib.format "~#{width}s~15s~15s~15s~15s~15s~15s~15s~15s~15s\n", ["", "Count", "Mean", "Std", "Min", "25%", "50%", "75%", "Max", "Range"]
    end

    defp describe_feature(feature, width) do
        :io_lib.format "~#{width}s~15.6f~15.6f~15.6f~15.6f~15.6f~15.6f~15.6f~15.6f~15.6f\n", [feature.name, feature.count, feature.mean, feature.std, feature.min, feature."25%", feature."50%", feature."75%", feature.max, feature.range]
    end
end
