defmodule ErrorHandlerTest do
  use ExUnit.Case
  doctest ErrorHandler

  test "greets the world" do
    assert ErrorHandler.hello() == :world
  end
end
