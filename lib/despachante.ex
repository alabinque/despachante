defmodule Despachante do
  @moduledoc """
  Biblioteca para validação de documentos brasileiros.

     iex Despachante.valida_cpf("111") == true
  """

  @doc """
  Hello world.

  ## Examples

      iex> Despachante.hello()
      :world

  """
  def hello do
    IO.puts "Olá, Despachante"
  end

  def valida_tamanho(documento, tamanho) do 
    if String.length(documento) == tamanho do
      documento
    else
      raise "Erro: O documento não possui o tamanho correto!"
    end
  end

  def calculo_cpf(cpf) do
    if String.length(cpf) == 0 do
      raise "askdjsladjlaskl"
    end
    IO.puts cpf
    restante = String.slice(cpf, 1, 11)
    calculo_cpf(restante)
  end
  
  def valida_cpf(), do: "CPF Vazio"
  def valida_cpf(cpf) do
    cpf_valido = valida_tamanho(cpf, 11)
    calculo_cpf(cpf_valido)
   end
end
