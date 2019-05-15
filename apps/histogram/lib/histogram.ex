defmodule Histogram do
  def display(houses_by_classes) do
    agent = Plots.new

    Plots.subplots agent, [nrows: 4, ncols: 4, figsize: {15, 10}]

    set_subplot_for_classes Datas.classes, 0, agent, houses_by_classes

    Plots.function agent, :"fig.legend", [Datas.houses]
    Plots.function agent, :"plt.subplots_adjust", [], [left: 0.05, right: 0.95, hspace: 1.0, wspace: 0.3, top: 0.95, bottom: 0.05]

    Plots.show agent
    Plots.close agent
  end

  def set_subplot_for_classes(list, index, agent, houses_by_classes)
  def set_subplot_for_classes([], _index, agent, _houses_by_classes) do
    Plots.subplots_function agent, 3, 1, :set_visible, [false]
    Plots.subplots_function agent, 3, 2, :set_visible, [false]
    Plots.subplots_function agent, 3, 3, :set_visible, [false]
  end
  def set_subplot_for_classes([class | tail], index, agent, houses_by_classes) do
    points = for house <- Datas.houses, do: houses_by_classes[class][house]

    y = Integer.floor_div(index, 4)
    x = rem(index, 4)

    Plots.subplots_function agent, y, x, :hist, [points], [bins: 25, histtype: "bar"]
    Plots.subplots_function agent, y, x, :set_title, [class]
    Plots.subplots_function agent, y, x, :set_xlabel, ["grades"]
    Plots.subplots_function agent, y, x, :set_ylabel, ["number"]

    set_subplot_for_classes(tail, index + 1, agent, houses_by_classes)
  end

end
