defmodule ParserTest do
  use ExUnit.Case

  @string "user.initials.first_name=Bob&user.initials.last_name=Marley&chief.position=cock&looks=good"

  @result %{
    "user" => %{
      "initials" => %{
        "first_name" => "Bob",
        "last_name" => "Marley"
      }
    },
    "chief" => %{
      "position" => "cock"
    },
    "looks" => "good"
  }

  test "return valid result" do
    assert Parser.parse(@string) == @result
  end
end
