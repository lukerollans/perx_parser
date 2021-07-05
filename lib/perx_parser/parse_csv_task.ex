defmodule Mix.Tasks.ParseCsv do
  @moduledoc """
  Provides a custom Mix task which when run expects CSV formatter data
  to exist on stdin.

  If the data exists, each cell is interpreted as
  postfix notation and the result of each cell is output in its place
  via stdout.

  If stdin is empty an error is displayed.
  """
  use Mix.Task

  alias PerxParser.PostfixNotation

  @doc """
  Streams all input from stdin, expecting the input to be in CSV format whose
  cells contain postfix notation expressions.

  Outputs the result of each expression in the same shape as it was input. If
  an expression is not valid, "#ERR" will be printed in its place.

  ## Examples

      $ cat sample.csv | mix parse_csv
      3,-4,3,#ERR
      4,5,0,3.5
      54,#ERR,0,14
  """
  def run(_arguments) do
    :stdio
    |> IO.stream(:line)
    |> Enum.into([])
    |> Enum.each(&evaluate_line/1)
  end

  defp evaluate_line(line) when is_binary(line) do
    line
    |> String.split(",")
    |> Enum.map(&evaluate_cell/1)
    |> Enum.join(",")
    |> IO.puts()
  end

  defp evaluate_cell(expression) when is_binary(expression) do
    case PostfixNotation.evaluate(String.trim(expression)) do
      number when is_number(number) -> number
      _error -> "#ERR"
    end
  end
end
