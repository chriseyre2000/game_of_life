defmodule GameOfLife do
  @moduledoc """
  Documentation for `GameOfLife`.
  """

  @offsets for i <- -1..1, j <- -1..1, !(i == 0 and j == 0), do: {i, j}

  def transform(gen) do
    size =
      gen
      |> Enum.count()

    flat_gen =
      gen
      |> List.flatten()

    flat_gen
    |> Enum.with_index()
    |> Enum.map(fn {data, index} -> {data, coordinate_from_index(index, size)} end)
    |> Enum.map(&count_neighbours(&1, flat_gen, size))
    |> Enum.map(fn
      {_, 3} -> :alive
      {:alive, 2} -> :alive
      {_, _} -> :dead
    end)
    |> Enum.chunk_every(size)
  end

  defp count_neighbours({data, {cx, cy}}, flat_gen, size) do
    totals =
      @offsets
      |> Enum.map(fn {x, y} -> {x + cx, y + cy} end)
      |> Enum.filter(fn {x, y} -> x in 0..(size - 1) and y in 0..(size - 1) end)
      |> Enum.map(&index_from_coordinate(&1, size))
      |> Enum.map(fn index ->
        Enum.at(flat_gen, index)
      end)
      |> Enum.count(&(&1 == :alive))

    {data, totals}
  end

  defp coordinate_from_index(index, width) do
    {rem(index, width), div(index, width)}
  end

  defp index_from_coordinate({x, y}, width) do
    x + y * width
  end
end
