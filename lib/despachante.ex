defmodule Despachante do
  @moduledoc """
  Biblioteca para validação de documentos brasileiros.

     iex Despachante.valida_cpf("111") == true
  """
  def _validate_digit(digits, validate_array, digit) do
    digits
    |> Enum.zip_reduce(validate_array, 0, fn left, right, acc -> acc + (left * right) end)
    |> Kernel.*(10)
    |> Kernel.rem(11)
    |> Kernel.==(digit)
  end

  def valid?(:cpf, document_number) do
    cpf = Regex.replace(~r/[^0-9]/, document_number, "")
          |> String.split("", trim: true)
          |> Enum.map(fn x -> elem(Integer.parse(x), 0) end)

    digits = cpf
             |> Enum.slice(9, 2)

    is_first_digit_valid? = cpf
                            |> Enum.slice(0, 9)
                            |> _validate_digit(Enum.to_list(10..2), List.first(digits)) 

    is_second_digit_valid? = cpf
                            |> Enum.slice(0, 10)
                            |> _validate_digit(Enum.to_list(11..2), List.last(digits)) 

    is_first_digit_valid? and is_second_digit_valid?
  end

end
