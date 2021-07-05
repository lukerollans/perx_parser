defmodule PerxParser.PostfixNotationTest do
  use ExUnit.Case, async: true

  alias PerxParser.PostfixNotation

  describe "PerxParser.PostfixNotation.evaluate/1" do
    test "returns zero for an empty expression" do
      assert PostfixNotation.evaluate("") == 0
    end

    test "returns a lone segment as the expression's result" do
      assert PostfixNotation.evaluate("1") == 1
    end

    test "supports basic addition" do
      assert PostfixNotation.evaluate("5 50 +") == 55
    end

    test "supports basic subtraction" do
      assert PostfixNotation.evaluate("50 5 -") == 45
    end

    test "supports basic multiplication" do
      assert PostfixNotation.evaluate("5 50 *") == 250
    end

    test "supports basic division" do
      assert PostfixNotation.evaluate("50 5 /") == 10
    end

    test "supports more complex expressions with multiple operators" do
      assert PostfixNotation.evaluate("500 14 10 4 * + /") == (500 / (14 + (10 * 4)))
    end

    test "strips out extraneous spaces" do
      assert PostfixNotation.evaluate("5   50  *") == 250
    end

    test "reports an error when the expression is not valid postfix" do
      assert PostfixNotation.evaluate("+ 0") == {:error, :not_valid_postfix_notation}
      assert PostfixNotation.evaluate("foobar") == {:error, :not_valid_postfix_notation}
      assert PostfixNotation.evaluate("5000 50") == {:error, :not_valid_postfix_notation}
    end
  end
end
