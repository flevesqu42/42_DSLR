defmodule DatasTest do
  use ExUnit.Case
  doctest Datas

  test "greets the world" do
    assert Datas.hello() == :world
  end
end
