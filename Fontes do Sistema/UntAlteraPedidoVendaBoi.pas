unit UntAlteraPedidoVendaBoi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, StdCtrls, Mask, Buttons, ComCtrls;

type
  TFrmAlteraPedidoVendaBoi = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox2: TGroupBox;
    DBRadioGroup1: TDBRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    BtnConfirmar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnImpressao: TBitBtn;
    Edit7: TEdit;
    UpDown1: TUpDown;
    MaskEdit1: TMaskEdit;
    DBEdit6: TDBEdit;
    Edit6: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    function TiraVirgula(cValue: String):String;
    procedure Edit7Change(Sender: TObject);
    procedure DBRadioGroup1Click(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure BtnImpressaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Impressao_Vale;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraPedidoVendaBoi: TFrmAlteraPedidoVendaBoi;

implementation

uses UntAlteraPedidoAcougue, UntDataModulo, UntConf_Venda_Boi,
  UntPedidoAcougue, UntAlteraItensBoi;

{$R *.DFM}

function TFrmAlteraPedidoVendaBoi.TiraVirgula(cValue: String):String;
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

procedure TFrmAlteraPedidoVendaBoi.FormShow(Sender: TObject);
Var nSubTotal: Currency;
    nValor: Currency;
    nDesconto: Currency;
begin
  nSubTotal := 0;
  Edit3.Text := DmPrincipal.TbClientes.FieldByName('Endereco').AsString;
  Edit4.Text := DmPrincipal.TbClientes.FieldByName('Bairro').AsString;
  Edit5.Text := DmPrincipal.TbClientes.FieldByName('Cidade').AsString;
  FrmAlteraPedidoAcougue.TbAuxMov_Vendas.First;
  While not FrmAlteraPedidoAcougue.TbAuxMov_Vendas.EOF do
  begin
    nSubTotal := nSubTotal + FrmAlteraPedidoAcougue.TbAuxMov_Vendas.FieldByName('Total').AsCurrency;
    FrmAlteraPedidoAcougue.TbAuxMov_Vendas.Next;
  End;
  Edit6.Text := FormatCurr('###,###,##0.00',nSubTotal);

  Dmprincipal.TbReceberBoi.Active := true;
  If DmPrincipal.TbReceberBoi.FindKey([FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Codigo').AsInteger, FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Venda_Nr').AsInteger, 'V']) Then
  Begin
    MaskEdit1.Text := Dmprincipal.TbReceberBoi.FieldByName('Data_Pgto').AsString;
    Edit7.Text     := FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Porc_Desc').AsString;
  End;

  // Setar o Valor do Desconto e do Total conforme a porcentagem que vier do TbAuxVendas
  nValor     := StrToCurr(TiraVirgula(Edit6.Text));
  Edit1.Text := FormatCurr('###,###,##0.00',((nValor * StrToCurr(Trim(Edit7.Text))) / 100));
  nDesconto  := StrToCurr(TiraVirgula(Edit1.Text));
  Edit2.Text := FormatCurr('###,###,##0.00',(nValor - nDesconto));
  FrmAlteraPedidoAcougue.TbAuxVendas.Edit;
end;

procedure TFrmAlteraPedidoVendaBoi.BtnConfirmarClick(Sender: TObject);
begin
  FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Total').AsString := Edit2.Text;
  FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Porc_Desc').AsString := Edit7.Text;
  FrmAlteraPedidoAcougue.TbAuxVendas.Post;
  If not Dmprincipal.TbReceberBoi.FindKey([FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Codigo').AsInteger,FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Venda_Nr').AsInteger, 'V']) Then
    Application.MessageBox('Pedido de Venda não encontrado no Contas à Receber !!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError)
  Else
  begin
    If not Dmprincipal.TbReceberBoi.FieldByName('Pago').AsBoolean Then
    Begin
      Dmprincipal.TbReceberBoi.Edit;
      Dmprincipal.TbReceberBoi.FieldByName('Total').AsFloat := StrToFloat(Edit2.Text);
      Dmprincipal.TbReceberBoi.FieldByName('Data_Pgto').AsString := MaskEdit1.Text;
      Dmprincipal.TbReceberBoi.Post;
    End
    Else
      //Pagamento ja fora efetuado
      If Application.MessageBox('Este Pedido de Venda já fora pago(Contas à Receber) !!! '+Chr(13)+Chr(13)+'Deseja alterá-lo mesmo assim ? ',' Confirmação de regravação no Contas à Receber',52) = id_Yes Then
      begin
        Dmprincipal.TbReceberBoi.Edit;
        Dmprincipal.TbReceberBoi.FieldByName('Total').AsFloat := StrToFloat(Edit2.Text);
        Dmprincipal.TbReceberBoi.FieldByName('Data_Pgto').AsString := MaskEdit1.Text;
        Dmprincipal.TbReceberFra.Post;
      end;
  end;
  BtnConfirmar.Enabled := False;  // Desabilitar o Botao de OK (do form Confirma Venda)
  FrmAlteraPedidoVendaBoi.Close;
end;

procedure TFrmAlteraPedidoVendaBoi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Dmprincipal.TbReceberBoi.Active := False;
end;

procedure TFrmAlteraPedidoVendaBoi.Edit7Change(Sender: TObject);
Var nValor: Currency;
    nDesconto: Currency;
begin
  nValor     := StrToCurr(FrmConf_Venda_Boi.TiraVirgula(Edit6.Text));
  Edit1.Text := FormatCurr('###,###,##0.00',((nValor * StrToCurr(Trim(Edit7.Text))) / 100));
  nDesconto  := StrToCurr(FrmConf_Venda_Boi.TiraVirgula(Edit1.Text));
  Edit2.Text := FormatCurr('###,###,##0.00',(nValor - nDesconto));
end;

procedure TFrmAlteraPedidoVendaBoi.DBRadioGroup1Click(Sender: TObject);
begin
  If DbRadioGroup1.ItemIndex = 0 Then
    Edit7.Text := '2'
  Else
    Edit7.Text := '0';
end;

procedure TFrmAlteraPedidoVendaBoi.BtnImpressaoClick(Sender: TObject);
begin
  BTNConfirmar.Enabled := True;  // Botao de OK (Descongelado)
  Impressao_Vale();
end;

procedure TFrmAlteraPedidoVendaboi.Impressao_Vale;
Var Arquivo: TextFile;
    cCab   : String;
    nI     : Word;
begin
  Screen.Cursor := crHourGlass;
  AssignFile(Arquivo,'\LPT1');
  Rewrite(Arquivo);
  For nI := 1 to 3 do
  Begin
    WriteLn(Arquivo,'+=================================================================+');
            cCab := '|               P E D I D O    D O     A C O U G U E              |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+=================================================================+');
    cCab := 'Pedido Nr..: '+FrmConf_Venda_Boi.FormatarNumero(FormatFloat('###,###,###',FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Venda_Nr').AsFloat),11);
    cCab := cCab+'               Data ..: '+FrmConf_Venda_Boi.FormatarString(FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Data').AsString,10);
    WriteLn(Arquivo,cCab);
    cCab := 'Nome ......: '+DmPrincipal.TbClientes.FieldByName('Fantasia').AsString;
    WriteLn(Arquivo,cCab);
    cCab := 'Endereco ..: '+FrmAlteraPedidoVendaBoi.Edit3.Text;
    WriteLn(Arquivo,cCab);
    cCab := 'Bairro ....: '+FrmConf_venda_Boi.FormatarString(FrmAlteraPedidoVendaBoi.Edit4.Text,25);
    cCab := cCab + ' Cidade : '+FrmConf_Venda_Boi.FormatarString(FrmAlteraPedidoVendaBoi.Edit5.Text,25);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+-------+--+-------------------------+----------+-----------------+');
            cCab := '| Qtde. |Un|           Especie       |Preco Unt.|    Total        |';
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'+-------+--+-------------------------+----------+-----------------+');

    FrmAlteraPedidoAcougue.TbAuxMov_Vendas.First;
    While not FrmAlteraPedidoAcougue.TbAuxMov_Vendas.EOF do
    begin
      cCab   := '';
      cCab   := FrmConf_Venda_Boi.FormatarNumero(FormatFloat('###0.000',FrmAlteraPedidoAcougue.TbAuxMov_VendasQtde.AsFloat),8);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Boi.FormatarString(FrmAlteraPedidoAcougue.TbAuxMov_VendasUnidade.AsString,2);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Boi.FormatarString(Copy(FrmAlteraPedidoAcougue.TbAuxMov_VendasDescricao.AsString,1,25),25);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Boi.FormatarNumero(FormatFloat('###,##0.00',FrmAlteraPedidoAcougue.TbAuxMov_VendasUnitario.AsFloat),10);
      cCab   := cCab + ' ';
      cCab   := cCab + FrmConf_Venda_Boi.FormatarNumero(FormatFloat('###,###,##0.00',FrmAlteraPedidoAcougue.TbAuxMov_VendasTotal.AsFloat),14);
      cCab   := cCab + ' ';
      WriteLn(Arquivo,cCab);
      FrmAlteraPedidoAcougue.TbAuxMov_Vendas.Next;
    End;
    WriteLn(Arquivo,'-------------------------------------------------------------------');
    cCab :=  '                                    Total ..: '+FrmConf_Venda_Boi.FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(FrmConf_Venda_Boi.TiraVirgula(Edit6.Text))),17);
    WriteLn(Arquivo,cCab);
    cCab :=  '                                 Desconto ..: '+FrmConf_Venda_Boi.FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(FrmConf_Venda_Boi.TiraVirgula(Edit1.Text))),17);
    WriteLn(Arquivo,cCab);
    cCab :=  '                            Total A Pagar ..: '+FrmConf_Venda_Boi.FormatarNumero(FormatCurr('##,###,###,##0.00',STrToCurr(FrmConf_Venda_Boi.TiraVirgula(Edit2.Text))),17);
    WriteLn(Arquivo,cCab);
    WriteLn(Arquivo,'');
    WriteLn(Arquivo,'');
    If DbRadioGroup1.ItemIndex = 0 Then  // Se for venda a Vista
      WriteLn(Arquivo,'                                        A    V I S T A           ');

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
  CloseFile(Arquivo);
  Screen.Cursor := crDefault;
End;

end.
