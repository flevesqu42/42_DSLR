defmodule DescribeTest do
  use ExUnit.Case
  doctest Describe

  test "greets the world" do
    assert Describe.hello() == :world
  end
end
