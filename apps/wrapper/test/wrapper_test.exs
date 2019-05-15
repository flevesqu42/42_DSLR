defmodule WrapperTest do
  use ExUnit.Case
  doctest Wrapper

  test "greets the world" do
    assert Wrapper.hello() == :world
  end
end
