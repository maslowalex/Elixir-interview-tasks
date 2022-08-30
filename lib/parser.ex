defmodule Parser do
  def parse(string) do
    string
    |> String.split("&")
    |> Enum.map(&extract_values/1)
    |> Enum.reduce(%{}, &deep_merge/2)
  end

  defp extract_values(keyval) do
    # user.initials.first_name=Bob
    keyval
    # [user, initials, first_name=Bob]
    |> String.split(".")
    |> build_map([])
  end

  defp build_map([], acc), do: acc

  defp build_map([element], acc) do
    [key, value] = String.split(element, "=")

    %{key => value}
  end

  defp build_map([key | tail] = keys, acc) do
    # # ["user", "initials", "first_name=Bob"]

    # [{"user", {"initials", {"first_name", "Bob"}}}]
    build_map(key, tail, acc)
  end

  defp build_map(key, [], acc), do: acc

  # initials, ["first_name=Bob"], acc
  defp build_map(key, [elem], acc), do: %{key => build_map([elem], acc)}

  # user, ["initials", "first_name=Bob"], []
  defp build_map(key, [head | tail], acc), do: %{key => build_map(head, tail, acc)}

  # Deep merge

  defp deep_merge(left, right) do
    Map.merge(left, right, &deep_resolve/3)
  end

  defp deep_resolve(_key, left = %{}, right = %{}) do
    deep_merge(left, right)
  end

  defp deep_resolve(_key, _left, right) do
    right
  end
end
