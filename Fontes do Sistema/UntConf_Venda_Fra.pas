unit UntConf_Venda_Fra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, DBCtrls, Buttons, Spin, ComCtrls;

type
  TFrmConf_Venda_Fra = class(TForm)
    GroupBox1: TGroupBox;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    Edit2: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit6: TDBEdit;
    Label9: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label3: TLabel;
    Edit5: TEdit;
    Label10: TLabel;
    Edit6: TEdit;
    Label11: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    UpDown1: TUpDown;
    Edit7: TEdit;
    MaskEdit1: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    function TiraVirgula(cValue: String):String;
    procedure DBRadioGroup1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Impressao_Vale;
    Function FormatarNumero(Valor: String; Tamanho: Word): String;
    Function FormatarString(cCampo: String; Tamanho: Word): String;
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConf_Venda_Fra: TFrmConf_Venda_Fra;

implementation

uses UntDataModulo, UntPedidoAvicola;

{$R *.DFM}

Function TFrmConf_Venda_Fra.FormatarString(cCampo: String; Tamanho: Word): String;
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

Function TFrmConf_Venda_Fra.FormatarNumero(Valor: String; Tamanho: Word): String;
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

function TFrmConf_Venda_Fra.TiraVirgula(cValue: String):String;
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

procedure TFrmConf_Venda_Fra.FormShow(Sender: TObject);
begin
  Edit3.Text := DmPrincipal.TbClientes.FieldByName('Endereco').AsString;
  Edit4.Text := DmPrincipal.TbClientes.FieldByName('Bairro').AsString;
  Edit5.Text := DmPrincipal.TbClientes.FieldByName('Cidade').AsString;
  DmPrincipal.TbVendasFra.Edit;
  Edit6.Text := FrmPedidoAvicola.Edit2.Text;
  Edit2.Text := FrmPedidoAvicola.Edit2.Text;
  DbRadioGroup1.ItemIndex := 0;
  MaskEdit1.Text := FrmPedidoAvicola.MaskEdit1.Text;
  Edit7.Text := '2';
end;

procedure TFrmConf_Venda_Fra.Edit7Change(Sender: TObject);
Var nValor: Currency;
    nDesconto: Currency;
Begin
  nValor     := StrToCurr(TiraVirgula(Edit6.Text));
  Edit1.Text := FormatCurr('###,###,##0.00',((nValor * StrToCurr(Trim(Edit7.Text))) / 100));
  nDesconto  := StrToCurr(TiraVirgula(Edit1.Text));
  Edit2.Text := FormatCurr('###,###,##0.00',(nValor - nDesconto));
end;

procedure TFrmConf_Venda_Fra.BitBtn1Click(Sender: TObject);
Var nValor: Currency;
begin
  nValor := StrToCurr(TiraVirgula(Edit2.Text));
  DmPrincipal.TbVendasFra.Edit;
  DmPrincipal.TbVendasFra.FieldByName('Total').AsCurrency  := nValor;
  DmPrincipal.TbVendasFra.FieldByName('Porc_Desc').AsFloat := StrToFloat(Edit7.Text);
  DmPrincipal.TbVendasFRa.Post;
  DmPrincipal.TbReceberFra.Active := True;
  DmPrincipal.TbReceberFra.Insert;
  DmPrincipal.TbReceberFra.FieldByName('Codigo').AsInteger    := DmPrincipal.TbVendasFra.FieldByName('Codigo').AsInteger;
  DmPrincipal.TbReceberFra.FieldByName('Venda_nr').AsInteger  := DmPrincipal.TbVendasFra.FieldByName('Venda_Nr').AsInteger;
  DmPrincipal.TbReceberFra.FieldByName('D_C').AsString        := 'V'; // (V) => Venda de mercadorias
  DmPrincipal.TbReceberfra.FieldByName('Data').AsDateTime     := DmPrincipal.TbVendasFra.FieldByName('Data').AsDateTime;
  DmPrincipal.TbReceberfra.FieldByName('Total').AsCurrency    := nValor;
  DmPrincipal.TbReceberfra.FieldByName('Data_Pgto').AsDateTime:= StrToDate(MaskEdit1.Text);
  DmPrincipal.TbReceberFra.Post;
  BitBtn1.Enabled := False;  // Desabilitar o Botao de OK (do form Confirma Venda)
  FrmConf_venda_Fra.Close;
  FrmPedidoAvicola.CompletingComboBox1.Sorted := False;
  FrmPedidoavicola.Gera_Novo_Mov;
  FrmPedidoAvicola.CompletingComboBox2.SetFocus;
  FrmPedidoAvicola.DBRichEdit1.VISIBLE := False;
end;

procedure TFrmConf_Venda_Fra.DBRadioGroup1Click(Sender: TObject);
begin
  If DbRadioGroup1.ItemIndex = 0 Then
  Begin
    MaskEdit1.Text := FrmPedidoAvicola.MaskEdit1.Text;
    Edit7.Text     := '2';
  End
  Else
  Begin
    MaskEdit1.Text := DateToStr(StrToDate(FrmPedidoAvicola.MaskEdit1.Text) + 7);
    Edit7.Text     := '0';
  End;
end;

procedure TFrmConf_Venda_Fra.BitBtn3Click(Sender: TObject);
begin
  BitBtn1.Enabled := True;  // Botao de OK (Descongelado)
  Impressao_Vale();
end;

procedure TFrmConf_Venda_Fra.Impressao_Vale;
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
            cCab := '|           P E D I D O     D A      A V I C O L A              |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+===============================================================+');
    cCab := 'Pedido nr .: '+FormatarNumero(FormatFloat('###,###,###',DmPrincipal.TbVendasFra.FieldByName('Venda_Nr').AsFloat),11);
    cCab := cCab+'               Data ..: '+FormatarString(DmPrincipal.TbVendasFra.FieldByName('Data').AsString,10);
    WriteLn(Arquivo,cCab);
    cCab := 'Nome ......: '+DmPrincipal.TbClientes.FieldByName('Fantasia').AsString;
    WriteLn(Arquivo,cCab);
    cCab := 'Endereco ..: '+FrmConf_Venda_Fra.Edit3.Text;
    WriteLn(Arquivo,cCab);
    cCab := 'Bairro ....: '+FormatarString(FrmConf_Venda_Fra.Edit4.Text,25);
    cCab := cCab + ' Cidade : '+FormatarString(FrmConf_Venda_Fra.Edit5.Text,25);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+-------+--+-------------------------+----------+---------------+');
            cCab := '| Qtde. |Un|           Especie       |Preco Unt.|    Total      |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+-------+--+-------------------------+----------+---------------+');

    DmPrincipal.TbMov_VendasFra.First;
    While not DmPrincipal.TbMov_VendasFra.EOF do
    begin
      cCab   := '';
      cCab   := FormatarNumero(FormatFloat('###0.000',DmPrincipal.TbMov_VendasFraQtde.AsFloat),8);
      cCab   := cCab + ' ';
      cCab   := cCab + FormatarString(DmPrincipal.TbMov_VendasFraUnidade.AsString,2);
      cCab   := cCab + ' ';
      cCab   := cCab + FormatarString(Copy(DmPrincipal.TbMov_VendasFraDescricao.AsString,1,25),25);
      cCab   := cCab + ' ';
      cCab   := cCab + FormatarNumero(FormatFloat('###,##0.00',DmPrincipal.TbMov_VendasFraUnitario.AsFloat),10);
      cCab   := cCab + ' ';
      cCab   := cCab + FormatarNumero(FormatFloat('###,###,##0.00',DmPrincipal.TbMov_VendasFraTotal.AsFloat),14);
      cCab   := cCab + ' ';
      WriteLn(Arquivo,cCab);
      DmPrincipal.TbMov_VendasFra.Next;
    End;
    WriteLn(Arquivo,'--------------------------------------------------------------');
    cCab :=  '                                    Total ..: '+FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(TiraVirgula(Edit6.Text))),17);
    WriteLn(Arquivo,cCab);
    cCab :=  '                                 Desconto ..: '+FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(TiraVirgula(Edit1.Text))),17);
    WriteLn(Arquivo,cCab);
    cCab :=  '                            Total A Pagar ..: '+FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(TiraVirgula(Edit2.Text))),17);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    If DbRadioGroup1.ItemIndex = 0 Then  // Se for venda a Vista
      WriteLn(Arquivo,'                                         A    V I S T A       ');

    WriteLn(Arquivo,'-------------------------        -----------------------------');
           cCab :=  '    - MOTORISTA -                         - ASSINATURA -        ';
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


procedure TFrmConf_Venda_Fra.BitBtn2Click(Sender: TObject);
begin
  Close;
  FrmPedidoAvicola.CompletingComboBox1.SetFocus;
end;


end.
