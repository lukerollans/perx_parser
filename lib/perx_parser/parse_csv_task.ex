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

  def run(_arguments) do
  end
end
