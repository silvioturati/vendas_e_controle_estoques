unit UntFechamentoPedidosPeriodoAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, Mask;

type
  TFrmFechamentoPedidosPeriodoAvicola = class(TForm)
    DsClientes: TDataSource;
    TbClientes: TTable;
    DsReceberFra: TDataSource;
    TbReceberFra: TTable;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    BtnImprimir: TBitBtn;
    BtnFechar: TBitBtn;
    function TiraVirgula(cValue: String):String;
    Function FormatarString(cCampo: String; Tamanho: Word): String;
    Function FormatarNumero(Valor: String; Tamanho: Word): String;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFechamentoPedidosPeriodoAvicola: TFrmFechamentoPedidosPeriodoAvicola;

implementation

uses UntDataModulo, UntConf_Venda_Fra;

{$R *.DFM}

Function TFrmFechamentoPedidosPeriodoAvicola.FormatarString(cCampo: String; Tamanho: Word): String;
var i,y : Integer;
    nSpaces : Word;
    cString: String;
    Acentos: Array[1..26,1..2] of string;
begin
  Acentos[01,1] := 'á'; Acentos[01,2] := Chr(160);
  Acentos[02,1] := 'Á'; Acentos[02,2] := Chr(142);
  Acentos[03,1] := 'à'; Acentos[03,2] := Chr(133);
  Acentos[04,1] := 'À'; Acentos[04,2] := Chr(142);
  Acentos[05,1] := 'ã'; Acentos[05,2] := Chr(132);
  Acentos[06,1] := 'Ã'; Acentos[06,2] := Chr(142);
  Acentos[07,1] := 'Â'; Acentos[07,2] := Chr(143);
  Acentos[08,1] := 'â'; Acentos[08,2] := Chr(131);
  Acentos[09,1] := 'É'; Acentos[09,2] := Chr(144);
  Acentos[10,1] := 'é'; Acentos[10,2] := Chr(130);
  Acentos[11,1] := 'Ê'; Acentos[11,2] := Chr(69);
  Acentos[12,1] := 'ê'; Acentos[12,2] := Chr(136);
  Acentos[13,1] := 'Í'; Acentos[13,2] := Chr(73);
  Acentos[14,1] := 'í'; Acentos[14,2] := Chr(161);
  Acentos[15,1] := 'Ó'; Acentos[15,2] := Chr(79);
  Acentos[16,1] := 'ó'; Acentos[16,2] := Chr(162);
  Acentos[17,1] := 'Õ'; Acentos[17,2] := Chr(79);
  Acentos[18,1] := 'õ'; Acentos[18,2] := Chr(148);
  Acentos[19,1] := 'Ú'; Acentos[19,2] := Chr(85);
  Acentos[20,1] := 'ú'; Acentos[20,2] := Chr(163);
  Acentos[21,1] := 'Ç'; Acentos[21,2] := Chr(128);
  Acentos[22,1] := 'ç'; Acentos[22,2] := Chr(135);
  Acentos[23,1] := 'ù'; Acentos[23,2] := Chr(151);
  Acentos[24,1] := 'Ù'; Acentos[24,2] := Chr(85);
  Acentos[25,1] := 'ü'; Acentos[25,2] := Chr(129);
  Acentos[26,1] := 'Ü'; Acentos[26,2] := Chr(154);

  nSpaces := Tamanho - Length(cCampo);
  cString := Trim(Copy(cCampo,1,Tamanho));
  For i:= 1 to Length(cString) do
  begin
    For y := 1 to 26 do
    begin
      if cString[i] = Acentos[Y,1] then
        cString[i] := Acentos[Y,2][1];
    end;
  end;
  For I := 1 to nSpaces do
    cString := cString + ' ';
  Result := cString;
End;

Function TFrmFechamentoPedidosPeriodoAvicola.FormatarNumero(Valor: String; Tamanho: Word): String;
Var nI, nSpaces : Word;
    cString: String;
begin
  nSpaces := Tamanho - Length(Valor);
  cString := '';
  For nI := 1 to nSpaces do
    cString := cString + ' ';
  For nI := 1 to Length(Valor) do
    cString := cString + Valor[nI];
  Result := cString;
End;

function TFrmFechamentoPedidosPeriodoAvicola.TiraVirgula(cValue: String):String;
Var cValor: String;
    nI: Integer;
begin
  cValor := '';
  For nI := 1 to Length(cValue) do
  Begin
    If Copy(cValue,nI,1) <> '.' Then
      cValor := cValor + Copy(cValue,nI,1);
  End;
  Result := cValor;
End;

procedure TFrmFechamentoPedidosPeriodoAvicola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TBClientes.Active := False;
  DmPrincipal.TbReceberFra.Active  := False;
end;

procedure TFrmFechamentoPedidosPeriodoAvicola.BtnImprimirClick(Sender: TObject);
var nCodigo: Integer;
    nTotal: Real;
    Arquivo: TextFile;
    cCab: String;
    nI: word;
begin
  TbClientes.Active    := True;
  TbReceberFra.Active  := True;
  Screen.Cursor := crHourGlass;
  AssignFile(Arquivo,'\LPT1');
  Rewrite(Arquivo);

  TbClientes.First;
  TbReceberFra.First;
  while not TbClientes.EOF do
  begin
    TbReceberFra.First;
    nCodigo := TbClientes.FieldByName('Codigo').AsInteger;
    TbReceberFra.FindKey([nCodigo]);
    nTotal := 0;
    while not TbReceberFra.EOF do
    begin
      if (TbReceberFra.FieldByName('Data').AsDateTime >= StrToDate(MaskEdit1.Text)) AND (TbReceberFra.FieldByName('Data').AsDateTime <= StrToDate(MaskEdit2.Text)) Then
        if TbReceberFra.FieldByName('Pago').AsString <> 'Ok' Then
          if TbReceberFra.FieldByName('Codigo').AsInteger = nCodigo Then
            nTotal := nTotal + TbReceberFra.FieldByName('Total').AsFloat
          else
            Break;
      TbReceberFra.Next;
    end;
    if nTotal <> 0 Then
    begin
      for nI := 1 to 2 do
      begin
      WriteLn(Arquivo,'+=============================================================+');
              cCab := '|       FECHAMENTO  SEMANAL  DE  PEDIDOS  DA  AVICOLA         |';
      WriteLn(Arquivo,cCab);
      WriteLn(Arquivo,'+=============================================================+');
      cCab :=         'Nome ...: '+FormatarString(TbClientes.FieldByName('Fantasia').AsString,50);
      WriteLn(Arquivo,cCab);
      cCab :=         'Endereco: '+FormatarString(TbClientes.FieldByName('Endereco').AsString,50);
      WriteLn(Arquivo,cCab);
      cCab :=         'Bairro .: '+FormatarString(TbClientes.FieldByName('Bairro').AsString,25);
      WriteLn(Arquivo,cCab);
      cCab :=         'Cidade .: '+FormatarString(TbClientes.FieldByName('Cidade').AsString,25);
      WriteLn(Arquivo,cCab);
      WriteLn(Arquivo,'+----------------+--------------+-----+-----------------------+');
      cCab :=         '|     Numero     |     Data     | V/D |         Total         |';
      WriteLn(Arquivo,cCab);
      WriteLn(Arquivo,'+----------------+--------------+-----+-----------------------+');
                     //   999,999,999      99/99/9999     D     999.999.999.999,99
      TbReceberFra.FindKey([nCodigo]);
      while not TbReceberFra.EOF do
      begin
        If (TbReceberFra.FieldByName('Data').AsDateTime >= StrToDate(MaskEdit1.Text)) AND (TbReceberFra.FieldByName('Data').AsDateTime <= StrToDate(MaskEdit2.Text)) Then
          If TbReceberFra.FieldByName('Pago').AsString <> 'Ok' Then
            If TbReceberFra.FieldByName('Codigo').AsInteger = nCodigo Then
            begin
              cCab := '|  '+FormatarNumero(FormatFloat('##,###,###',TbReceberFra.FieldByName('Venda_Nr').AsFloat),12)+'  |  ';
              cCab := cCab + FormatarString(TbReceberFra.FieldByName('Data').AsString,10)+ '  |  ';
              cCab := cCab + TbReceberFra.FieldByName('D_C').AsString+'  |  ';
              cCab := cCab + FormatarNumero(FormatFloat('###,###,###,##0.00',TbReceberFra.FieldByName('Total').AsFloat),18)+'   |';
              WriteLn(Arquivo,cCab);
            end;
        TbReceberFra.Next;
      end;
      WriteLn(Arquivo,'+----------------+--------------+-----+-----------------------+');
      WriteLn(Arquivo,'');
      WriteLn(Arquivo,'');                                 //  9.999.999.999.999,99
      cCab :=         '                      Total Geral ....:'+FormatarNumero(FormatFloat('#,###,###,###,##0.00',nTotal),20);
      WriteLn(Arquivo,cCab);
      WriteLn(Arquivo,'');
      WriteLn(Arquivo,'');
      WriteLn(Arquivo,'');
      WriteLn(Arquivo,'');
      WriteLn(Arquivo,'');
      WriteLn(Arquivo,'');
      end;
    end;
    TbClientes.Next;
  end;
  CloseFile(Arquivo);
  Screen.Cursor      := crDefault;
  TbClientes.Active  := False;
  TbReceberFra.Active:= False;
end;

procedure TFrmFechamentoPedidosPeriodoAvicola.BtnFecharClick(Sender: TObject);
begin
     Close;
end;

end.
