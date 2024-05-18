defmodule MinettiFwTest do
  use ExUnit.Case
  doctest MinettiFw

  test "greets the world" do
    assert MinettiFw.hello() == :world
  end
end
