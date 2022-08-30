defmodule ElixirAlgosTest do
  use ExUnit.Case

  describe "Sort algorithms" do
    test "quicksort actually sorts lists" do
      list = Enum.shuffle(1..100)

      assert ElixirAlgos.quicksort(list) == Enum.to_list(1..100)
    end
  end

  describe "Directed Graph algorithms" do
    setup do
      graph = %{
        a: [:b, :c],
        b: [:d],
        c: [:e],
        d: [:f],
        e: [],
        f: []
      }

      %{graph: graph}
    end

    test "Depth first traversal algorithm", %{graph: graph} do
      assert [:a, :b, :d, :f, :c, :e] == ElixirAlgos.depth_first_traversal(graph, :a)
    end

    test "Breadth first traversal algorithm", %{graph: graph} do
      assert [:a, :b, :c, :d, :e, :f] == ElixirAlgos.breadth_first_traversal(graph, :a)
    end
  end
end
