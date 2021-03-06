unit UntConf_Venda_Boi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, StdCtrls, Mask, ComCtrls, Buttons;

type
  TFrmConf_Venda_Boi = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    DBRadioGroup1: TDBRadioGroup;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    UpDown1: TUpDown;
    Label11: TLabel;
    Label8: TLabel;
    MaskEdit1: TMaskEdit;
    Label9: TLabel;
    DBEdit6: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit6: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure Edit7Change(Sender: TObject);
    procedure DBRadioGroup1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Impressao_Vale;
    Function FormatarNumero(Valor: String; Tamanho: Word): String;
    Function FormatarString(cCampo: String; Tamanho: Word): String;
    Function TiraVirgula(cValue: String):String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConf_Venda_Boi: TFrmConf_Venda_Boi;

implementation

uses UntDataModulo, UntPedidoAcougue;

{$R *.DFM}

procedure TFrmConf_Venda_Boi.Edit7Change(Sender: TObject);
Var nValor: Currency;
    nDesconto: Currency;
begin
  nValor     := StrToCurr(TiraVirgula(Edit6.Text));
  Edit1.Text := FormatCurr('###,###,##0.00',((nValor * StrToCurr(Trim(Edit7.Text))) / 100));
  nDesconto  := StrToCurr(TiraVirgula(Edit1.Text));
  Edit2.Text := FormatCurr('###,###,##0.00',(nValor - nDesconto));
end;

procedure TFrmConf_Venda_Boi.DBRadioGroup1Click(Sender: TObject);
begin
  If DbRadioGroup1.ItemIndex = 0 Then
  Begin
    MaskEdit1.Text := FrmPedidoAcougue.MaskEdit1.Text;
    Edit7.Text     := '2';
  End
  Else
  Begin
    MaskEdit1.Text := DateToStr(StrToDate(FrmPedidoAcougue.MaskEdit1.Text) + 7);
    Edit7.Text     := '0';
  End;
end;

procedure TFrmConf_Venda_Boi.BitBtn3Click(Sender: TObject);
begin
  BitBtn1.Enabled := True;  // Botao de OK (Descongelado)
  Impressao_Vale();
end;

procedure TFrmConf_Venda_Boi.BitBtn1Click(Sender: TObject);
Var nValor: Currency;
begin
  nValor := StrToCurr(TiraVirgula(Edit2.Text));
  DmPrincipal.TbVendasBoi.Edit;
  DmPrincipal.TbVendasBoi.FieldByName('Total').AsCurrency  := nValor;
  DmPrincipal.TbVendasBoi.FieldByName('Porc_Desc').AsFloat := StrToFloat(Edit7.Text);
  DmPrincipal.TbVendasBoi.Post;
  DmPrincipal.TbReceberBoi.Active := True;
  DmPrincipal.TbReceberBoi.Insert;
  DmPrincipal.TbReceberBoi.FieldByName('Codigo').AsInteger    := DmPrincipal.TbVendasBoi.FieldByName('Codigo').AsInteger;
  DmPrincipal.TbReceberBoi.FieldByName('Venda_nr').AsInteger  := DmPrincipal.TbVendasBoi.FieldByName('Venda_Nr').AsInteger;
  DmPrincipal.TbReceberBoi.FieldByName('D_C').AsString        := 'V'; // (V) => Venda de mercadorias
  DmPrincipal.TbReceberBoi.FieldByName('Data').AsDateTime     := DmPrincipal.TbVendasBoi.FieldByName('Data').AsDateTime;
  DmPrincipal.TbReceberBoi.FieldByName('Total').AsCurrency    := nValor;
  DmPrincipal.TbReceberBoi.FieldByName('Data_Pgto').AsDateTime:= StrToDate(MaskEdit1.Text);
  DmPrincipal.TbReceberBoi.Post;
  BitBtn1.Enabled := False;  // Desabilitar o Botao de OK (do form Confirma Venda)
  FrmConf_Venda_Boi.Close;
  FrmPedidoAcougue.CompletingComboBox1.Sorted := false;
  FrmPedidoAcougue.Gera_Novo_Mov;
  FrmPedidoAcougue.CompletingComboBox2.SetFocus;
  FrmPedidoAcougue.DbRichEdit1.VISIBLE := False;
end;

procedure TFrmConf_Venda_Boi.BitBtn2Click(Sender: TObject);
begin
  Close;
  FrmPedidoAcougue.CompletingComboBox1.SetFocus;
end;

procedure TFrmConf_Venda_Boi.Impressao_Vale;
Var Arquivo: TextFile;
    cCab   : String;
    nI     : Word;
begin
  Screen.Cursor := crHourGlass;
  AssignFile(Arquivo,'\LPT1');
  Rewrite(Arquivo);
  For nI := 1 to 3 do
  Begin
    WriteLn(Arquivo,'+===============================================================+');
            cCab := '|           P E D I D O     D O      A C O U G U E              |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+===============================================================+');
    cCab := 'Pedido nr .: '+FormatarNumero(FormatFloat('###,###,###',DmPrincipal.TbVendasBoi.FieldByName('Venda_Nr').AsFloat),11);
    cCab := cCab+'               Data ..: '+FormatarString(DmPrincipal.TbVendasBoi.FieldByName('Data').AsString,10);
    WriteLn(Arquivo,cCab);
    cCab := 'Nome ......: '+DmPrincipal.TbClientes.FieldByName('Fantasia').AsString;
    WriteLn(Arquivo,cCab);
    cCab := 'Endereco ..: '+FrmConf_Venda_Boi.Edit3.Text;
    WriteLn(Arquivo,cCab);
    cCab := 'Bairro ....: '+FormatarString(FrmConf_Venda_Boi.Edit4.Text,25);
    cCab := cCab + ' Cidade : '+FormatarString(FrmConf_Venda_Boi.Edit5.Text,25);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+-------+--+-------------------------+----------+---------------+');
            cCab := '| Qtde. |Un|           Especie       |Preco Unt.|    Total      |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+-------+--+-------------------------+----------+---------------+');

    DmPrincipal.TbMov_VendasBoi.First;
    While not DmPrincipal.TbMov_VendasBoi.EOF do
    begin
      cCab   := '';
      cCab   := FormatarNumero(FormatFloat('###0.000',DmPrincipal.TbMov_VendasBoi.FieldByName('Qtde').AsFloat),8);
      cCab   := cCab + ' ';
      cCab   := cCab + FormatarString(DmPrincipal.TbMov_VendasBoi.FieldByName('Unidade').AsString,2);
      cCab   := cCab + ' ';
      cCab   := cCab + FormatarString(Copy(DmPrincipal.TbMov_VendasBoi.FieldByName('Descricao').AsString,1,25),25);
      cCab   := cCab + ' ';
      cCab   := cCab + FormatarNumero(FormatFloat('###,##0.00',DmPrincipal.TbMov_VendasBoi.FieldByName('Unitario').AsFloat),10);
      cCab   := cCab + ' ';
      cCab   := cCab + FormatarNumero(FormatFloat('###,###,##0.00',DmPrincipal.TbMov_VendasBoi.FieldByName('Total').AsFloat),14);
      cCab   := cCab + ' ';
      WriteLn(Arquivo,cCab);
      DmPrincipal.TbMov_VendasBoi.Next;
    End;
    WriteLn(Arquivo,'-----------------------------------------------------------------');
    cCab :=  '                                    Total ..: '+FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(TiraVirgula(Edit6.Text))),17);
    WriteLn(Arquivo,cCab);
    cCab :=  '                                 Desconto ..: '+FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(TiraVirgula(Edit1.Text))),17);
    WriteLn(Arquivo,cCab);
    cCab :=  '                            Total A Pagar ..: '+FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(TiraVirgula(Edit2.Text))),17);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    If DbRadioGroup1.ItemIndex = 0 Then  // Se for venda a Vista
      WriteLn(Arquivo,'                                         A    V I S T A        ');

    WriteLn(Arquivo,'-------------------------        --------------------------------');
           cCab :=  '    - MOTORISTA -                         - ASSINATURA -         ';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
  End;
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  WriteLn(Arquivo,'');
  CloseFile(Arquivo);
  Screen.Cursor := crDefault;
End;

Function TFrmConf_Venda_Boi.FormatarString(cCampo: String; Tamanho: Word): String;
var i,y : Integer;
    nSpaces : Word;
    cString: String;
    Acentos: Array[1..26,1..2] of string;
begin
  Acentos[01,1] := '?'; Acentos[01,2] := Chr(160);
  Acentos[02,1] := '?'; Acentos[02,2] := Chr(142);
  Acentos[03,1] := '?'; Acentos[03,2] := Chr(133);
  Acentos[04,1] := '?'; Acentos[04,2] := Chr(142);
  Acentos[05,1] := '?'; Acentos[05,2] := Chr(132);
  Acentos[06,1] := '?'; Acentos[06,2] := Chr(142);
  Acentos[07,1] := '?'; Acentos[07,2] := Chr(143);
  Acentos[08,1] := '?'; Acentos[08,2] := Chr(131);
  Acentos[09,1] := '?'; Acentos[09,2] := Chr(144);
  Acentos[10,1] := '?'; Acentos[10,2] := Chr(130);
  Acentos[11,1] := '?'; Acentos[11,2] := Chr(69);
  Acentos[12,1] := '?'; Acentos[12,2] := Chr(136);
  Acentos[13,1] := '?'; Acentos[13,2] := Chr(73);
  Acentos[14,1] := '?'; Acentos[14,2] := Chr(161);
  Acentos[15,1] := '?'; Acentos[15,2] := Chr(79);
  Acentos[16,1] := '?'; Acentos[16,2] := Chr(162);
  Acentos[17,1] := '?'; Acentos[17,2] := Chr(79);
  Acentos[18,1] := '?'; Acentos[18,2] := Chr(148);
  Acentos[19,1] := '?'; Acentos[19,2] := Chr(85);
  Acentos[20,1] := '?'; Acentos[20,2] := Chr(163);
  Acentos[21,1] := '?'; Acentos[21,2] := Chr(128);
  Acentos[22,1] := '?'; Acentos[22,2] := Chr(135);
  Acentos[23,1] := '?'; Acentos[23,2] := Chr(151);
  Acentos[24,1] := '?'; Acentos[24,2] := Chr(85);
  Acentos[25,1] := '?'; Acentos[25,2] := Chr(129);
  Acentos[26,1] := '?'; Acentos[26,2] := Chr(154);

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
end;

Function TFrmConf_Venda_Boi.FormatarNumero(Valor: String; Tamanho: Word): String;
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
end;

function TFrmConf_Venda_Boi.TiraVirgula(cValue: String):String;
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
end;

procedure TFrmConf_Venda_Boi.FormShow(Sender: TObject);
begin
  Edit3.Text := DmPrincipal.TbClientes.FieldByName('Endereco').AsString;
  Edit4.Text := DmPrincipal.TbClientes.FieldByName('Bairro').AsString;
  Edit5.Text := DmPrincipal.TbClientes.FieldByName('Cidade').AsString;
  DmPrincipal.TbVendasBoi.Edit;
  Edit6.Text := FrmPedidoAcougue.Edit2.Text;
  Edit2.Text := FrmPedidoAcougue.Edit2.Text;
  DbRadioGroup1.ItemIndex := 0;
  MaskEdit1.Text := FrmPedidoAcougue.MaskEdit1.Text;
  Edit7.Text := '2';
end;
end.
