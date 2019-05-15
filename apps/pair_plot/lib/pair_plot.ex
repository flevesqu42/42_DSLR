defmodule PairPlot do
    def display(dataset) do
        agent = Plots.new

        Plots.send(agent, "plt.rcParams.update({'font.size': 7})")
        Plots.function agent, :"plt.figure", [], [figsize: {16, 13}], :fig
        Plots.function agent, :"plt.subplots_adjust", [], [left: 0.05, right: 0.98, top: 0.95, bottom: 0.05]
        Plots.new_gridspec agent, 13, 13, [wspace: 0, hspace: 0]

        set_subplots_y agent, dataset

        Plots.function agent, :"fig.legend", [Datas.houses]
        Plots.show agent
        Plots.close agent
    end

    defp set_subplots_y(agent, dataset, classes \\ Datas.classes(), y \\ 0)
    defp set_subplots_y(_agent, _dataset, [], _y), do: :ok
    defp set_subplots_y(agent, dataset, [y_class | tail], y) do
        set_subplots_x(agent, dataset, y_class, y)
        set_subplots_y(agent, dataset, tail, y + 1)
    end

    defp set_subplots_x(agent, dataset, y_class, y, x \\ 0, classes \\ Datas.classes())
    defp set_subplots_x(_agent, _dataset, _y_class, _y, _x, []), do: :ok
    defp set_subplots_x(agent, dataset, y_class, y, x, [x_class | tail]) when y_class == x_class do
        points = for house <- Datas.houses, do: to_float_list(dataset[y_class][house])
        index = set_subplot(agent, y, x, x_class, y_class)
        Plots.subplot_function(agent, index, :hist, [points], [histtype: "barstacked"])
        set_subplots_x(agent, dataset, y_class, y, x + 1, tail)
    end
    defp set_subplots_x(agent, dataset, y_class, y, x, [x_class | tail]) do
        index = set_subplot(agent, y, x, x_class, y_class)
        display_subplot_by_houses(agent, dataset, y_class, x_class, y, x, index)
        set_subplots_x(agent, dataset, y_class, y, x + 1, tail)
    end

    defp set_subplot(agent, y, x, x_class, y_class) do
        index = (y * 13) + x + 1
        Plots.subplot(agent, index, x, y)
        Plots.subplot_function(agent, index, :"xaxis.set_tick_params", [], [which: "both", labelbottom: false, labeltop: false, labelleft: false, labelright: false])
        Plots.subplot_function(agent, index, :"xaxis.offsetText.set_visible", [false])
        Plots.subplot_function(agent, index, :"yaxis.set_tick_params", [], [which: "both", labelleft: false, labelright: false, labelbottom: false, labeltop: false])
        Plots.subplot_function(agent, index, :"yaxis.offsetText.set_visible", [false])
        if x == 0   do
            Plots.subplot_function(agent, index, :set_ylabel, y_class)
        end
        if y == 12  do
            Plots.subplot_function(agent, index, :set_xlabel, x_class)
            Plots.subplot_function(agent, index, :"xaxis.set_tick_params", [], [which: "both", labelbottom: true, labeltop: false, labelleft: false, labelright: false])
            Plots.subplot_function(agent, index, :"xaxis.offsetText.set_visible", [true])
        end
        index
    end

    defp display_subplot_by_houses(agent, dataset, y_class, x_class, y, x, index, houses \\ Datas.houses)
    defp display_subplot_by_houses(_agent, _dataset, _y_class, _x_class, _y, _x, _index, []), do: :ok
    defp display_subplot_by_houses(agent, dataset, y_class, x_class, y, x, index, [house | tail]) do
        {a, b} = get_matched_points_only(dataset[x_class][house], dataset[y_class][house])
        Plots.subplot_function(agent, index, :scatter, [a, b], [s: 1])
        display_subplot_by_houses(agent, dataset, y_class, x_class, y, x, index, tail)
    end

    defp get_matched_points_only(lst1, lst2, acc1 \\ [], acc2 \\ [])
    defp get_matched_points_only([], [], acc1, acc2), do: {acc1, acc2}
    defp get_matched_points_only([h1 | t1], [h2 | t2], acc1, acc2) do
        case {is_float(h1), is_float(h2)} do
            {true, true}    -> get_matched_points_only(t1, t2, [h1] ++ acc1, [h2] ++ acc2)
            _               -> get_matched_points_only(t1, t2, acc1, acc2)
        end
    end

    defp to_float_list(lst, acc \\ [])
    defp to_float_list([], acc), do: acc
    defp to_float_list([head | tail], acc) when is_float head do to_float_list(tail, [head] ++ acc) end
    defp to_float_list([_head | tail], acc), do: to_float_list(tail, acc)
end
