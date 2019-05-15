defmodule ScatterPlot do

  @features Datas.classes

  def display(dataset) do
    combs = comb_list (@features)
    agent = Plots.new
    Plots.subplots agent, [nrows: 8, ncols: 10, figsize: {20, 13}]
    Plots.function agent, :"plt.subplots_adjust", [], [left: 0.05, right: 0.98, hspace: 1.0, wspace: 1.0, top: 0.95, bottom: 0.05]
    Plots.function agent, :"fig.legend", [Datas.houses]
    set_subplots agent, dataset, combs
    Plots.show agent
    Plots.close agent
  end

  defp set_subplots(agent, dataset, lst, index \\ 0)
  defp set_subplots(agent, _dataset, [], index), do: fill_with_non_visible_plots(agent, index)
  defp set_subplots(agent, dataset, [{f1, f2} | tail], index) do
    col = Integer.floor_div(index, 10)
    row = rem(index, 10)

    set_plot agent, dataset, f1, f2, row, col
    set_subplots(agent, dataset, tail, index + 1)
  end

  defp set_plot(agent, dataset, f1, f2, row, col) do
    display_by_houses agent, col, row, dataset, f1, f2
    Plots.subplots_function agent, col, row, :set_xlabel, [f1], [fontsize: 8]
    Plots.subplots_function agent, col, row, :set_ylabel, [f2], [fontsize: 8]
  end

  def display_by_houses(agent, col, row, dataset, f1, f2, houses \\ Datas.houses())
  def display_by_houses(_agent, _col, _row, _dataset, _f1, _f2, []), do: :ok
  def display_by_houses(agent, col, row, dataset, f1, f2, [house | tail]) do
     {x, y} = convert_to_float(dataset[f1][house], dataset[f2][house])
     Plots.subplots_function agent, col, row, :scatter, [x, y], [s: 1]
     display_by_houses(agent, col, row, dataset, f1, f2, tail)
  end

  def convert_to_float(lst1, lst2, acc1 \\ [], acc2 \\ [])
  def convert_to_float([], [], acc1, acc2), do: {acc1, acc2}
  def convert_to_float([h1 | t1], [h2 | t2], acc1, acc2) do
    case {is_float(h1), is_float(h2)} do
      {true, true}  -> convert_to_float(t1, t2, [h1 | acc1], [h2 | acc2])
      {_, _}        -> convert_to_float(t1, t2, acc1, acc2)
    end
  end

  defp fill_with_non_visible_plots(_agent, 80), do: :ok
  defp fill_with_non_visible_plots(agent, index) do
    col = Integer.floor_div(index, 10)
    row = rem(index, 10)

    Plots.subplots_function agent, col, row, :set_visible, [false]
    set_subplots(agent, nil, [], index + 1)
  end

  def comb_list(lst, acc \\ [])
  def comb_list([], acc), do: acc
  def comb_list([head | tail], acc) do
    comb_list(tail, comb_list_tail(head, tail) ++ acc)
  end

  def comb_list_tail(elem, lst, acc \\ [])
  def comb_list_tail(_elem, [], acc), do: acc
  def comb_list_tail(elem, [head | tail], acc) do
    comb_list_tail(elem, tail, [{elem, head} | acc])
  end

end
