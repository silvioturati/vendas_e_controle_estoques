unit UntAlteraPedidoVendaFra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, ComCtrls, StdCtrls, Buttons, Mask, Db, DBTables;

type
  TFrmAlteraPedidoVendaFra = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Edit1: TEdit;
    DBEdit6: TDBEdit;
    BtnConfirmar: TBitBtn;
    BtnCancelar: TBitBtn;
    Edit6: TEdit;
    UpDown1: TUpDown;
    DBRadioGroup1: TDBRadioGroup;
    MaskEdit1: TMaskEdit;
    Edit2: TEdit;
    Edit7: TEdit;
    BtnImpressao: TBitBtn;
    procedure FormShow(Sender: TObject);
    function TiraVirgula(cValue: String):String;
    procedure BtnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit7Change(Sender: TObject);
    procedure BtnImpressaoClick(Sender: TObject);
    procedure Impressao_Vale;
    procedure DBRadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraPedidoVendaFra: TFrmAlteraPedidoVendaFra;

implementation

uses UntDataModulo, UntConf_Venda_Fra, UntPedidoAvicola,
  UntAlteraItensFra, UntAlteraPedidoAvicola;

{$R *.DFM}

function TFrmAlteraPedidoVendaFra.TiraVirgula(cValue: String):String;
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

procedure TFrmAlteraPedidoVendaFra.FormShow(Sender: TObject);
Var nSubTotal: Currency;
    nValor: Currency;
    nDesconto: Currency;
begin
  nSubTotal := 0;
  Edit3.Text := DmPrincipal.TbClientes.FieldByName('Endereco').AsString;
  Edit4.Text := DmPrincipal.TbClientes.FieldByName('Bairro').AsString;
  Edit5.Text := DmPrincipal.TbClientes.FieldByName('Cidade').AsString;
  FrmAlteraPedidoAvicola.TbAuxMov_Vendas.First;
  While not FrmAlteraPedidoAvicola.TbAuxMov_Vendas.EOF do
  begin
    nSubTotal := nSubTotal + FrmAlteraPedidoAvicola.TbAuxMov_Vendas.FieldByName('Total').AsCurrency;
    FrmAlteraPedidoAvicola.TbAuxMov_Vendas.Next;
  End;
  Edit6.Text := FormatCurr('###,###,##0.00',nSubTotal);

  Dmprincipal.TbReceberFra.Active := true;
  If Dmprincipal.TbReceberFra.FindKey([FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Codigo').AsInteger,FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Venda_Nr').AsInteger, 'V']) Then
  Begin
    MaskEdit1.Text := Dmprincipal.TbReceberFra.FieldByName('Data_Pgto').AsString;
    Edit7.Text     := FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Porc_Desc').AsString;
  End;

  // Setar o Valor do Desconto e do Total conforme a porcentagem que vier do TbAuxVendas
  nValor     := StrToCurr(TiraVirgula(Edit6.Text));
  Edit1.Text := FormatCurr('###,###,##0.00',((nValor * StrToCurr(Trim(Edit7.Text))) / 100));
  nDesconto  := StrToCurr(TiraVirgula(Edit1.Text));
  Edit2.Text := FormatCurr('###,###,##0.00',(nValor - nDesconto));
  FrmAlteraPedidoAvicola.TbAuxVendas.Edit;
end;

procedure TFrmAlteraPedidoVendaFra.BtnConfirmarClick(Sender: TObject);
begin
  FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Total').AsString := Edit2.Text;
  FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Porc_Desc').AsString := Edit7.Text;
  FrmAlteraPedidoAvicola.TbAuxVendas.Post;
  If not Dmprincipal.TbReceberFra.FindKey([FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Codigo').AsInteger,FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Venda_Nr').AsInteger, 'V']) Then
    Application.MessageBox('Pedido de Venda não encontrado no Contas à Receber !!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError)
  Else
  begin
    If not Dmprincipal.TbReceberFra.FieldByName('Pago').AsBoolean Then
    Begin
      Dmprincipal.TbReceberFra.Edit;
      Dmprincipal.TbReceberFra.FieldByName('Total').AsFloat := StrToFloat(Edit2.Text);
      Dmprincipal.TbReceberFra.FieldByName('Data_Pgto').AsString := MaskEdit1.Text;
      Dmprincipal.TbReceberFra.Post;
    End
    Else
      //Pagamento ja fora efetuado
      If Application.MessageBox('Este Pedido de Venda já fora pago(Contas à Receber) !!! '+Chr(13)+Chr(13)+'Deseja alterá-lo mesmo assim ? ',' Confirmação de regravação no Contas à Receber',52) = id_Yes Then
      begin
        Dmprincipal.TbReceberFra.Edit;
        Dmprincipal.TbReceberFra.FieldByName('Total').AsFloat := StrToFloat(Edit2.Text);
        Dmprincipal.TbReceberFra.FieldByName('Data_Pgto').AsString := MaskEdit1.Text;
        Dmprincipal.TbReceberFra.Post;
      end;
  end;
  BtnConfirmar.Enabled := False;  // Desabilitar o Botao de OK (do form Confirma Venda)
  FrmAlteraPedidoVendaFra.Close;
end;

procedure TFrmAlteraPedidoVendaFra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Dmprincipal.TbReceberFra.Active := False;
end;

procedure TFrmAlteraPedidoVendaFra.Edit7Change(Sender: TObject);
Var nValor: Currency;
    nDesconto: Currency;
Begin
  nValor     := StrToCurr(FrmConf_Venda_Fra.TiraVirgula(Edit6.Text));
  Edit1.Text := FormatCurr('###,###,##0.00',((nValor * StrToCurr(Trim(Edit7.Text))) / 100));
  nDesconto  := StrToCurr(FrmConf_Venda_Fra.TiraVirgula(Edit1.Text));
  Edit2.Text := FormatCurr('###,###,##0.00',(nValor - nDesconto));
end;

procedure TFrmAlteraPedidoVendaFra.BtnImpressaoClick(Sender: TObject);
begin
  BtnConfirmar.Enabled := True;  // Botao de OK (Descongelado)
  Impressao_Vale();
end;

procedure TFrmAlteraPedidoVendaFra.Impressao_Vale;
Var Arquivo: TextFile;
    cCab   : String;
    nI     : Word;
begin
  Screen.Cursor := crHourGlass;
  AssignFile(Arquivo,'\LPT1');
  Rewrite(Arquivo);
  For nI := 1 to 3 do
  Begin
    WriteLn(Arquivo,'+==================================================================+');
            cCab := '|               P E D I D O    D A     A V I C O L A               |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+==================================================================+');
    cCab := 'Pedido Nr..: '+FrmConf_Venda_fra.FormatarNumero(FormatFloat('###,###,###',FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Venda_Nr').AsFloat),11);
    cCab := cCab+'               Data ..: '+FrmConf_Venda_Fra.FormatarString(FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Data').AsString,10);
    WriteLn(Arquivo,cCab);
    cCab := 'Nome ......: '+DmPrincipal.TbClientes.FieldByName('Fantasia').AsString;
    WriteLn(Arquivo,cCab);
    cCab := 'Endereco ..: '+FrmAlteraPedidoVendaFra.Edit3.Text;
    WriteLn(Arquivo,cCab);
    cCab := 'Bairro ....: '+FrmConf_venda_Fra.FormatarString(FrmAlteraPedidoVendaFra.Edit4.Text,25);
    cCab := cCab + ' Cidade : '+FrmConf_Venda_Fra.FormatarString(FrmAlteraPedidoVendaFra.Edit5.Text,25);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+-------+--+-------------------------+----------+-----------------+');
            cCab := '| Qtde. |Un|           Especie       |Preco Unt.|    Total        |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+-------+--+-------------------------+----------+-----------------+');

    FrmAlteraPedidoAvicola.TbAuxMov_Vendas.First;
    While not FrmAlteraPedidoAvicola.TbAuxMov_Vendas.EOF do
    begin
      cCab   := '';
      cCab   := FrmConf_Venda_Fra.FormatarNumero(FormatFloat('###0.000',FrmAlteraPedidoAvicola.TbAuxMov_VendasQtde.AsFloat),8);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarString(FrmAlteraPedidoAvicola.TbAuxMov_VendasUnidade.AsString,2);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarString(Copy(FrmAlteraPedidoAvicola.TbAuxMov_VendasDescricao.AsString,1,25),25);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarNumero(FormatFloat('###,##0.00',FrmAlteraPedidoAvicola.TbAuxMov_VendasUnitario.AsFloat),10);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Fra.FormatarNumero(FormatFloat('###,###,##0.00',FrmAlteraPedidoAvicola.TbAuxMov_VendasTotal.AsFloat),14);
      cCab   := cCab + ' ';
      WriteLn(Arquivo,cCab);
      FrmAlteraPedidoAvicola.TbAuxMov_Vendas.Next;
    End;
    WriteLn(Arquivo,'-------------------------------------------------------------------');
    cCab :=  '                                    Total ..: '+FrmConf_Venda_fra.FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(FrmConf_Venda_Fra.TiraVirgula(Edit6.Text))),17);
    WriteLn(Arquivo,cCab);
    cCab :=  '                                 Desconto ..: '+FrmConf_Venda_Fra.FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(FrmConf_Venda_Fra.TiraVirgula(Edit1.Text))),17);
    WriteLn(Arquivo,cCab);
    cCab :=  '                            Total A Pagar ..: '+FrmConf_Venda_Fra.FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(FrmConf_Venda_Fra.TiraVirgula(Edit2.Text))),17);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    If DbRadioGroup1.ItemIndex = 0 Then  // Se for venda a Vista
      WriteLn(Arquivo,'                                         A    V I S T A          ');

    WriteLn(Arquivo,'-------------------------        -------------------------------   ');
           cCab :=  '    - MOTORISTA -                         - ASSINATURA -           ';
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
  CloseFile(Arquivo);
  Screen.Cursor := crDefault;
End;

procedure TFrmAlteraPedidoVendaFra.DBRadioGroup1Click(Sender: TObject);
begin
  If DbRadioGroup1.ItemIndex = 0 Then
    Edit7.Text := '2'
  Else
    Edit7.Text := '0';
end;

end.
