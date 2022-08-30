defmodule ElixirAlgos do
  @moduledoc """
  Documentation for `ElixirAlgos`.
  """

  @doc """
  Quicksort recursive implementation
  """
  def quicksort([]), do: []

  def quicksort([x | xs]) do
    quicksort(for smaller when smaller < x <- xs, do: smaller) ++
      [x] ++
      quicksort(for larger when larger >= x <- xs, do: larger)
  end

  @doc """
  Depth first traversal graph algorithm use Stack
  as underlying data structure
  """
  def depth_first_traversal(graph, source) when is_map(graph) do
    do_depth_first_traversal(graph, [source], [])
  end

  defp do_depth_first_traversal(_graph, [], result), do: result

  defp do_depth_first_traversal(graph, stack, result) do
    [current | stack_tail] = stack

    stack = List.flatten([Map.get(graph, current) | stack_tail])

    do_depth_first_traversal(graph, stack, result ++ [current])
  end

  @doc """
  Breadth first traversal use Queue
  as underlying data structure
  """
  def breadth_first_traversal(graph, source) do
    queue = :queue.new()

    do_breadth_first_traversal(graph, :queue.in(source, queue), [])
  end

  defp do_breadth_first_traversal(graph, queue, result) do
    case :queue.out(queue) do
      {{:value, current}, queue} ->
        queue =
          graph
          |> Map.get(current)
          |> Enum.reduce(queue, fn value, queue ->
            :queue.in(value, queue)
          end)

        do_breadth_first_traversal(graph, queue, result ++ [current])

      {:empty, _} ->
        result
    end
  end
end
