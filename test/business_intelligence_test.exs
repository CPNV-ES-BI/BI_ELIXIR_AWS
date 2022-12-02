defmodule BusinessIntelligenceTest do
  use ExUnit.Case
  doctest BusinessIntelligence

  test "greets the world" do
    assert BusinessIntelligence.hello() == :world
  end
end
