defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  @start [
    [:dead, :alive, :dead],
    [:dead, :alive, :dead],
    [:dead, :alive, :dead]
  ]

  @expected [
    [:dead, :dead, :dead],
    [:alive, :alive, :alive],
    [:dead, :dead, :dead]
  ]

  test "Acceptance Test" do
    assert GameOfLife.transform(@start) == @expected
  end
end
