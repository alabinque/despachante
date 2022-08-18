defmodule CpfTest do
  use ExUnit.Case

  test "wrong entries should be false" do
    assert Despachante.valid?(:cpf, "111") == false
    assert Despachante.valid?(:cpf, "1234567899999999") == false
    assert Despachante.valid?(:cpf, "880.691.1770-87") == false
    assert Despachante.valid?(:cpf, "245.225.80-50") == false
    assert Despachante.valid?(:cpf, "a1b1c1") == false
  end

  test "valid cpfs should be true" do
    assert Despachante.valid?(:cpf, "812.480.202-51") == true
    assert Despachante.valid?(:cpf, "10860682463") == true
    assert Despachante.valid?(:cpf, "444.737.20292") == true
    assert Despachante.valid?(:cpf, "11437056296") == true
    assert Despachante.valid?(:cpf, "628.431.725-51") == true
  end

  test "should fomated cpfs be true when valid" do
    assert Despachante.valid?(:cpf, "973.123.773-94") == true
    assert Despachante.valid?(:cpf, "355.892.611-04") == true
    assert Despachante.valid?(:cpf, "462.565.337-12") == true
    assert Despachante.valid?(:cpf, "769.652.231-03") == true
    assert Despachante.valid?(:cpf, "657.586.293-40") == true
  end

  test "should number only valid cpfs be true" do
    assert Despachante.valid?(:cpf, "50924180609") == true
    assert Despachante.valid?(:cpf, "87504827185") == true
    assert Despachante.valid?(:cpf, "23460344105") == true
    assert Despachante.valid?(:cpf, "79727858481") == true
    assert Despachante.valid?(:cpf, "60987283480") == true
  end

  test "should invalid cpfs be false" do
    assert Despachante.valid?(:cpf, "665.483.274-00") == false
    assert Despachante.valid?(:cpf, "778.446.293-42") == false
    assert Despachante.valid?(:cpf, "379.607.129-02") == false
    assert Despachante.valid?(:cpf, "993.752.917-96") == false
    assert Despachante.valid?(:cpf, "992.244.554-57") == false
  end

  test "know invalid cpfs should be false" do
    assert Despachante.valid?(:cpf, "111.111.111-11") == false
    assert Despachante.valid?(:cpf, "22222222222") == false
    assert Despachante.valid?(:cpf, "123.456.789-10") == false
    assert Despachante.valid?(:cpf, "99999999999") == false
    assert Despachante.valid?(:cpf, "000.000.000-00") == false
  end

  test "values with more than 11 chars should be false" do
    assert Despachante.valid?(:cpf, "1") == false
    assert Despachante.valid?(:cpf, "973.123.773.940") == false
    assert Despachante.valid?(:cpf, "6575862934") == false
    assert Despachante.valid?(:cpf, "") == false
    assert Despachante.valid?(:cpf, "462.565.337-12000000") == false
  end
  
end
