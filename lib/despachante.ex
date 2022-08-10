defmodule Despachante do
  @moduledoc """
  Biblioteca para validação de documentos brasileiros.

    iex> Despachante.valida(:cpf, "11122233344")
    false

  """

  @doc """
  Função recursiva que recebe uma lista de 9 digitos
  e retorna o somatório de cada elemento multiplicado
  eles pelo peso de 10..2.

  ## Assinatura
  
  somatorio_digitos: [integer] -> integer -> integer -> integer

  ## Parametros
  
  @param digitos: [integer] = digitos do CPF
  @param peso: ?integer = valor a ser multiplicado o digito
  @param acc: ?integer = valor total da operação

  ## Exemplo
  
    iex> Despachante.somatorio_digitos([9, 7, 2, 7, 7, 7, 5, 1, 0], 10)
    318
  """
  def somatorio_digitos([], _, acc), do: acc
  def somatorio_digitos(digitos, peso, acc \\ 0) do
    [digito | resto] = digitos
    operacao = acc + (digito * peso)
    peso_restante = peso - 1
    somatorio_digitos(resto, peso_restante, operacao)
  end

  @doc """
  Função que compara o total retornado da operação de validação
  com o primeiro digito verificador do CPF.

  ## Assinatura
  
  verifica_primeiro: integer -> integer -> boolean

  ## Parametros
  
  @param valores: integer = valor da soma da multiplicação dos digitos pelo peso
  @param digito: integer = primeiro digito verificador do CPF

  ## Exemplo
  
    iex> Despachante.verifica_primeiro([9, 7, 2, 7, 7, 7, 5, 1, 0], 1)
    true
  """
  def verifica_primeiro(p_nove_digitos, digito) do
    soma = somatorio_digitos(p_nove_digitos, 10)
    rem(soma * 10, 11) == digito 
  end
  
  @doc """
  Função que compara o total retornado da operação de validação
  com o segundo digito verificador do CPF.

  ## Assinatura
  
  verifica_segundo: integer -> integer -> boolean

  ## Parametros
  
  @param valores: integer = valor da soma da multiplicação dos digitos pelo peso
  @param digito: integer = segundo digito verificador do CPF

  ## Exemplo
    iex> Despachante.verifica_segundo([9, 7, 2, 7, 7, 7, 5, 1, 0, 1], 9)
    true
  """ 
  def verifica_segundo(p_dez_digitos, digito) do
    soma = somatorio_digitos(p_dez_digitos, 11)
    rem(soma * 10, 11) == digito 
  end

  @doc """
  Valida o tamanho de um documento.

  ## Assinatura

  valida_tamanho: string -> integer -> string!

  ## Parametros
  @param documento: string = Número do documento
  @param tamanho: integer = Tamanho que o documento deve ter

  ## Exemplo

    iex> Despachante.valida_tamanho("111", 3)
    "111" 
  """
  def valida_tamanho(documento, tamanho) do 
    if String.length(documento) == tamanho do
      documento
    else
      raise "Erro: O documento não possui o tamanho correto!"
    end
  end
  
  def valida(), do: "Vazio"
  @doc """
  Valida CPF.

  ## Assinatura
  valida: atom -> string -> boolean

  ## Parametros

  @param :cpf = Constante que serve para indicar qual documento está sendo validado
  @param cpf: string = Número do CPF sem pontuações

  ## Exemplos
    iex> Despachante.valida(:cpf, "80186316038")
    true

    iex> Despachante.valida(:cpf, "33179307055")
    false
  """
  def valida(:cpf, cpf) do
    valores = valida_tamanho(cpf, 11) 
              |> String.split("") 
              |> Enum.filter(fn x -> x != "" end)
              |> Enum.map(fn x -> elem(Integer.parse(x),0) end)

    p_nove_digitos = Enum.slice(valores, 0, 8)
    p_dez_digitos = Enum.slice(valores, 0, 10)
    digitos_finais = Enum.slice(valores, 9, 2)

    p_verificado = verifica_primeiro(p_nove_digitos, hd(digitos_finais))
    s_verificado = verifica_segundo(p_dez_digitos, List.last(digitos_finais))

    p_verificado and s_verificado
   end
end
