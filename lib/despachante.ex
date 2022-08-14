defmodule Despachante do
  @moduledoc """
  Utils for validation, mocking and generation of brazilian document information.

    iex>  Despachante.valid?(:cpf, "081.495.660-23")
    true
  """
  defp validate_digit(digits, validate_array, digit) do
    remainder = digits
                |> Enum.zip_reduce(validate_array, 0, fn left, right, acc -> acc + (left * right) end)
                |> Kernel.*(10)
                |> Kernel.rem(11)

    remainder == digit or (remainder == 10 and digit == 0)
  end

  @doc """
  Function that returns if the required document is valid. 

  Despachante.valid?(document, document_number) where: 
    document is one of 
    | :cpf for Cadastro de Pessoa Física (CPF) validation 
    | :cnpj for Cadastro Nacional de Pessoa Jurídica (CNPJ) validation
    document_number is the value to be validated 

    iex> Despachante.valid?(:cpf, "825.205.780-25")
    true 

    iex> Despachante.valid?(:cpf, "39549381030")
    true 

    iex> Despachante.valid?(:cpf, "946.502.280-25")
    false
  """
  def valid?(:cpf, document_number) do
    cpf = Regex.replace(~r/[^0-9]/, document_number, "")
          |> String.split("", trim: true)
          |> Enum.map(fn x -> elem(Integer.parse(x), 0) end)

    digits = cpf
             |> Enum.slice(9, 2)

    is_first_digit_valid? = cpf
                            |> Enum.slice(0, 9)
                            |> validate_digit(Enum.to_list(10..2), List.first(digits)) 

    is_second_digit_valid? = cpf
                            |> Enum.slice(0, 10)
                            |> validate_digit(Enum.to_list(11..2), List.last(digits)) 

    is_first_digit_valid? and is_second_digit_valid?
  end

end
