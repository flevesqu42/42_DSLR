defmodule Plots do

  alias Wrapper.Python, as: Python

  @imports """
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
"""

  def new() do
    agent = Python.Agent.new
    Python.Agent.send agent, @imports

    agent
  end

  def close(agent) do
    Python.Agent.close agent
  end

  def new_gridspec(agent, row, col, opts \\ []) do
      function agent, :"gridspec.GridSpec", [row, col], opts, :gs
  end

  def hist(agent, x, opts) do
      function agent, :"plt.hist", [x], opts
  end

  def scatter(agent, x, y, opts \\ []) do
      function agent, :"plt.scatter", [x, y], opts
  end

  def plot(agent, x, opts \\ []) do
      function agent, :"plt.plot", [x], opts
  end

  def show(agent) do
      function agent, :"plt.show"
  end

  def xlabel(agent, name) do
      function agent, :"plt.xlabel", name
  end

  def ylabel(agent, name) do
      function agent, :"plt.ylabel", name
  end

  def title(agent, name) do
      function agent, :"plt.title", name
  end

  def tight_layout(agent, opts \\ []) do
      function agent, :"plt.tight_layout", [], opts
  end

  def subplots(agent, options \\ [], return \\ {:fig, :axs}) do
      function agent, :"plt.subplots", [], options, return
  end

  def subplots_function(agent, y, x, function_name, arguments \\ [], options \\ [], return \\ nil, plot_name \\ :axs) do
      function agent, :"#{plot_name}[#{y}][#{x}].#{function_name}", arguments, options, return
  end

  def subplot(agent, index, x, y, opts \\ [], return \\ nil, gridspec \\ :gs)
  def subplot(agent, index, x, y, opts, nil, gridspec), do: subplot(agent, index, x, y, opts, :"ax#{index}", gridspec)
  def subplot(agent, _index, x, y, opts, return, gridspec) do
      function agent, :"plt.subplot", [Python.access(gridspec, [y, x])], opts, return
  end

  # def subplot(agent, index, opts \\ [], nrows \\ 1, ncols \\ 1, return \\ nil)
  # def subplot(agent, index, opts, nrows, ncols, nil), do: subplot(agent, index, opts, nrows, ncols, :"ax#{index}")
  # def subplot(agent, index, opts, nrows, ncols, return) do
  #     function agent, :"plt.subplot", [nrows, ncols, index], opts, return
  # end

  def subplot_function(agent, index, function_name, arguments \\ [], options \\ [], return \\ nil, plot_subname \\ nil)
  def subplot_function(agent, index, function_name, arguments, options, return, nil), do: subplot_function(agent, index, function_name, arguments, options, return, :"ax#{index}")
  def subplot_function(agent, _index, function_name, arguments, options, return, plot_subname) do
      function agent, :"#{plot_subname}.#{function_name}", arguments, options, return
  end

  def function(agent, name, arguments \\ [], options \\ [], return \\ nil)
  def function(agent, name, arguments, options, return) do
    command = Python.fun(name, arguments, options, return) |> Python.convert
    Plots.send(agent, command)
  end

  def send(agent, command) do
    Python.Agent.send(agent, command)
  end

end
