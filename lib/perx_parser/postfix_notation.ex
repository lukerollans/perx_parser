defmodule PerxParser.PostfixNotation do
  @moduledoc """
  An implementation of postfix notation evaluation in Elixir
  https://en.wikipedia.org/wiki/Reverse_Polish_notation
  """

  @doc """
  Evaluate a postfix notation expression and return the result.

  ## Examples

      iex> PerxParser.PostfixNotation.evaluate("5 2 *")
      10

      iex> PerxParser.PostfixNotation.evaluate("10 2 +")
      12
  """
  def evaluate(expression) do
    expression
    |> String.replace(~r/ +/, " ")
    |> String.split(" ")
    |> parse_numbers()
    |> do_evaluate()
  end

  defp parse_numbers(segments) do
    Enum.map(segments, fn segment ->
      case Integer.parse(segment) do
        {number, _remainder} -> number
        _operator -> segment
      end
    end)
  end

  defp do_evaluate(segments, stack \\ [])

  # If there are no segments and we haven't procured any results yet, then
  # the expression is empty and we'll return zero
  defp do_evaluate([""], []), do: 0

  # If there's no more segments (the first argument is an empty list) to
  # process then we can return the stack's head as the result as that's where
  # we're continuously pushing the accumulated value.
  defp do_evaluate([], [final_result]) do
    final_result
  end

  # The current segment is a number which means we need to continue converting
  # to infix
  defp do_evaluate([segment | tail], stack) when is_number(segment) do
    do_evaluate(tail, [segment | stack])
  end

  # The current segment is a binary (string) which means we can assume it is
  # an operator and need to evaluate it using the two numbers on top of the
  # stack
  defp do_evaluate([operator | segments_tail], [first_num, second_num | stack_tail]) when is_binary(operator) do
    case perform_arithmetic(operator, second_num, first_num) do
      number when is_number(number) -> do_evaluate(segments_tail, [number | stack_tail])
      error -> error
    end
  end

  # If nothing previous has matched then it isn't a valid notation and we should
  # return an error
  defp do_evaluate(_segments, _stack) do
    {:error, :not_valid_postfix_notation}
  end

  defp perform_arithmetic("+", first, second), do: first + second
  defp perform_arithmetic("-", first, second), do: first - second
  defp perform_arithmetic("*", first, second), do: first * second
  defp perform_arithmetic("/", first, second), do: first / second
end
