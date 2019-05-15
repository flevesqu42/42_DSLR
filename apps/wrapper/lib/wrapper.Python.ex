defmodule Wrapper.Python do

  def convert(%{function: {name, arguments}}) when is_atom name do
    arguments = for argument <- arguments, do: convert argument
    arguments = Enum.join(arguments, ", ")
    "#{name}(#{arguments})"
  end
  def convert(%{accessor: {name, accessors}}) when is_atom name do
      accessors = for accessor <- accessors, do: convert accessor
      accessors = Enum.join(accessors, ", ")
      "#{name}[#{accessors}]"
  end
  def convert(%{assignment: {variable, value}}) when is_atom variable do
    "#{variable} = #{convert value}"
  end
  def convert(%{assignment: {tuple, value}}) when is_tuple tuple do
    "#{convert tuple} = #{convert value}"
  end
  def convert(tuple) when is_tuple tuple do
    tuple = for e <- 0..tuple_size(tuple), e > 0, e = e - 1, do: tuple |> elem(e) |> convert
    tuple = Enum.join(tuple, ", ")
    "(#{tuple})"
  end
  def convert(list) when is_list list do
    list = for elem <- list, do: convert elem
    list = Enum.join(list, ", ")
    "[#{list}]"
  end
  def convert(string) when is_binary string do
    "'#{string}'"
  end
  def convert(true) do
    "True"
  end
  def convert(false) do
    "False"
  end
  def convert(nil) do
    "None"
  end
  def convert(elem) do
    "#{elem}"
  end

  def fun(name, arguments \\ [], options \\ [], return \\ nil)
  def fun(name, arguments, options, return) when not is_nil return do
    assign return, fun(name, arguments, options, nil)
  end
  def fun(name, argument, options, _return) when not is_list argument do
    fun(name, [argument], options)
  end
  def fun(name, arguments, options, _return) when is_atom name do
    options = Enum.map options, fn {k, v} -> assign(k, v) end
    %{function: {name, arguments ++ options}}
  end

  def assign(variable, value) do
    %{assignment: {variable, value}}
  end

  def access(name, accessors) do
      %{accessor: {name, accessors}}
  end

end
