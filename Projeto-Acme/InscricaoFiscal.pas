unit InscricaoFiscal;

interface

uses Vcl.Dialogs, SysUtils;

type
  /// <summary>
  /// Classe base para validação da inscrição fiscal: CPF e CNPJ
  /// </summary>
  TInscricaoFiscal = class abstract(TObject)
  public
    function DocumentoValido(const ADocumento: string): string; virtual; abstract;
  end;

  TCNPJ = class(TInscricaoFiscal)
  public
    function DocumentoValido(const ADocumento: string): string; override;
  end;

  TCPF = class(TInscricaoFiscal)
  public
    function DocumentoValido(const ADocumento: string): string; override;
  end;

implementation

{ TCNPJ }

function TCNPJ.DocumentoValido(const ADocumento: string): string;
var
  digito13, digito14: string;
  soma, i, r, peso: integer;
begin
  try
    // Cálculo do 1o. Digito Verificador
    soma := 0;
    peso := 2;

    for i := 12 downto 1 do
    begin
      // Converte o i-ésimo caractere do CNPJ informado para um número
      soma := soma + (StrToInt(ADocumento[i]) * peso);
      peso := peso + 1;

      if (peso = 10) then
        peso := 2;
    end;

    r := soma mod 11;
    if ((r = 0) or (r = 1)) then
      digito13 := '0'
    else
      // Converte um número no respectivo caractere numérico
      Str((11-r):1, digito13);

    // Cálculo do 2o. Digito Verificador
    soma := 0;
    peso := 2;

    for i := 13 downto 1 do
    begin
      soma := soma + (StrToInt(ADocumento[i]) * peso);
      peso := peso + 1;

      if (peso = 10)
         then peso := 2;
    end;

    r := soma mod 11;
    if ((r = 0) or (r = 1)) then
      digito14 := '0'
    else
      Str((11-r):1, digito14);

    // Verifica se os digitos calculados conferem com os digitos informados
    if ((digito13 = ADocumento[13]) and (digito14 = ADocumento[14])) then
      Result := ''
    else
      Result := 'CNPJ inválio' +#13+#13+ 'Favor verificar';
  except
    Result := 'Erro ao validar o CNPJ'
  end;
end;

{ TCPF }

function TCPF.DocumentoValido(const ADocumento: string): String;
var
  digito10, digito11: string;
  soma, i, resto, peso: integer;

begin
  try
    // Cálculo do 1o. Digito Verificador
    soma := 0;
    peso := 10;

    for i := 1 to 9 do
    begin
      // StrToInt converte o i-ésimo caractere do CPF em um número
      soma := soma + (StrToInt(ADocumento[i]) * peso);
      peso := peso - 1;
    end;

    resto := 11 - (soma mod 11);
    if ((resto = 10) or (resto = 11)) then
      digito10 := '0'
    else
      // Converte um número no respectivo caractere numérico
      Str(resto:1, digito10);

    // Cálculo do 2o. Digito Verificador
    soma := 0;
    peso := 11;

    for i := 1 to 10 do
    begin
      soma := soma + (StrToInt(ADocumento[i]) * peso);
      peso := peso - 1;
    end;

    resto := 11 - (soma mod 11);
    if ((resto = 10) or (resto = 11)) then
      digito11 := '0'
    else
      Str(resto:1, digito11);

    // Verifica se os digitos calculados conferem com os digitos informados
    if ((digito10 = ADocumento[10]) and (digito11 = ADocumento[11])) then
      Result := ''
    else
      Result := 'CPF inválio' +#13+#13+ 'Favor verificar';
  except
    Result := 'Erro ao validar o CPF'
  end;
end;

end.
