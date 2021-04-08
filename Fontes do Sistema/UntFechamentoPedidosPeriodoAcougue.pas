unit UntFechamentoPedidosPeriodoAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, Buttons, Mask;

type
  TFrmFechamentoPedidosPeriodoAcougue = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    BtnImprimir: TBitBtn;
    BtnFechar: TBitBtn;
    DsClientes: TDataSource;
    TbClientes: TTable;
    DsReceberBoi: TDataSource;
    TbReceberBoi: TTable;
    function TiraVirgula(cValue: String):String;
    function FormatarString(cCampo: String; Tamanho: Word): String;
    function FormatarNumero(Valor: String; Tamanho: Word): String;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFechamentoPedidosPeriodoAcougue: TFrmFechamentoPedidosPeriodoAcougue;

implementation

uses UntDataModulo;

{$R *.DFM}

Function TFrmFechamentoPedidosPeriodoAcougue.FormatarString(cCampo: String; Tamanho: Word): String;
var i,y : Integer;
    nSpaces : Word;
    cString: String;
    Acentos: Array[1..26,1..2] of string;
begin
  Acentos[01,1] := '�'; Acentos[01,2] := Chr(160);
  Acentos[02,1] := '�'; Acentos[02,2] := Chr(142);
  Acentos[03,1] := '�'; Acentos[03,2] := Chr(133);
  Acentos[04,1] := '�'; Acentos[04,2] := Chr(142);
  Acentos[05,1] := '�'; Acentos[05,2] := Chr(132);
  Acentos[06,1] := '�'; Acentos[06,2] := Chr(142);
  Acentos[07,1] := '�'; Acentos[07,2] := Chr(143);
  Acentos[08,1] := '�'; Acentos[08,2] := Chr(131);
  Acentos[09,1] := '�'; Acentos[09,2] := Chr(144);
  Acentos[10,1] := '�'; Acentos[10,2] := Chr(130);
  Acentos[11,1] := '�'; Acentos[11,2] := Chr(69);
  Acentos[12,1] := '�'; Acentos[12,2] := Chr(136);
  Acentos[13,1] := '�'; Acentos[13,2] := Chr(73);
  Acentos[14,1] := '�'; Acentos[14,2] := Chr(161);
  Acentos[15,1] := '�'; Acentos[15,2] := Chr(79);
  Acentos[16,1] := '�'; Acentos[16,2] := Chr(162);
  Acentos[17,1] := '�'; Acentos[17,2] := Chr(79);
  Acentos[18,1] := '�'; Acentos[18,2] := Chr(148);
  Acentos[19,1] := '�'; Acentos[19,2] := Chr(85);
  Acentos[20,1] := '�'; Acentos[20,2] := Chr(163);
  Acentos[21,1] := '�'; Acentos[21,2] := Chr(128);
  Acentos[22,1] := '�'; Acentos[22,2] := Chr(135);
  Acentos[23,1] := '�'; Acentos[23,2] := Chr(151);
  Acentos[24,1] := '�'; Acentos[24,2] := Chr(85);
  Acentos[25,1] := '�'; Acentos[25,2] := Chr(129);
  Acentos[26,1] := '�'; Acentos[26,2] := Chr(154);

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

Function TFrmFechamentoPedidosPeriodoAcougue.FormatarNumero(Valor: String; Tamanho: Word): String;
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

function TFrmFechamentoPedidosPeriodoAcougue.TiraVirgula(cValue: String):String;
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

procedure TFrmFechamentoPedidosPeriodoAcougue.BtnFecharClick(
  Sender: TObject);
begin
     Close;
end;

procedure TFrmFechamentoPedidosPeriodoAcougue.BtnImprimirClick(
  Sender: TObject);
var nCodigo: Integer;
    nTotal: Real;
    Arquivo: TextFile;
    cCab: String;
    nI: word;
begin
  TbClientes.Active    := True;
  TbReceberBoi.Active  := True;
  Screen.Cursor := crHourGlass;
  AssignFile(Arquivo,'\LPT1');
  Rewrite(Arquivo);

  TbClientes.First;
  TbReceberBoi.First;
  while not TbClientes.EOF do
  begin
    TbReceberBoi.First;
    nCodigo := TbClientes.FieldByName('Codigo').AsInteger;
    TbReceberBoi.FindKey([nCodigo]);
    nTotal := 0;
    while not TbReceberBoi.EOF do
    begin
      if (TbReceberBoi.FieldByName('Data').AsDateTime >= StrToDate(MaskEdit1.Text)) AND (TbReceberBoi.FieldByName('Data').AsDateTime <= StrToDate(MaskEdit2.Text)) Then
        if TbReceberBoi.FieldByName('Pago').AsString <> 'Ok' Then
          if TbReceberBoi.FieldByName('Codigo').AsInteger = nCodigo Then
            nTotal := nTotal + TbReceberBoi.FieldByName('Total').AsFloat
          else
            Break;
      TbReceberBoi.Next;
    end;
    if nTotal <> 0 Then
    begin
      for nI := 1 to 2 do
      begin
      WriteLn(Arquivo,'+=============================================================+');
              cCab := '|       FECHAMENTO  SEMANAL  DE  PEDIDOS  DO  ACOUGUE         |';
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
      TbReceberBoi.FindKey([nCodigo]);
      while not TbReceberBoi.EOF do
      begin
        If (TbReceberBoi.FieldByName('Data').AsDateTime >= StrToDate(MaskEdit1.Text)) AND (TbReceberBoi.FieldByName('Data').AsDateTime <= StrToDate(MaskEdit2.Text)) Then
          If TbReceberBoi.FieldByName('Pago').AsString <> 'Ok' Then
            If TbReceberBoi.FieldByName('Codigo').AsInteger = nCodigo Then
            begin
              cCab := '|  '+FormatarNumero(FormatFloat('##,###,###',TbReceberBoi.FieldByName('Venda_Nr').AsFloat),12)+'  |  ';
              cCab := cCab + FormatarString(TbReceberBoi.FieldByName('Data').AsString,10)+ '  |  ';
              cCab := cCab + TbReceberBoi.FieldByName('D_C').AsString+'  |  ';
              cCab := cCab + FormatarNumero(FormatFloat('###,###,###,##0.00',TbReceberBoi.FieldByName('Total').AsFloat),18)+'   |';
              WriteLn(Arquivo,cCab);
            end;
        TbReceberBoi.Next;
      end;
      WriteLn(Arquivo,'+----------------+--------------+-----+-----------------------+');
      WriteLn(Arquivo,'');
      WriteLn(Arquivo,'');                                //  9.999.999.999.999,99
      cCab :=         '                      Total Geral ....:'+FormatarNumero(FormatFloat('#,###,###,###,##0.00',nTotal),20);
      WriteLn(Arquivo,cCab);
      WriteLn(Arquivo,'');
      WriteLn(Arquivo,'');
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
  TbReceberBoi.Active:= False;
end;

procedure TFrmFechamentoPedidosPeriodoAcougue.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TBClientes.Active := False;
  DmPrincipal.TbReceberBoi.Active  := False;
end;

end.
