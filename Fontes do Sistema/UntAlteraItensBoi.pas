unit UntAlteraItensBoi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls;

type
  TFrmAlteraItensBoi = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit5: TDBEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    SpeedButton1: TSpeedButton;
    Edit3: TEdit;
    RadioGroup1: TRadioGroup;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
    procedure Edit3Exit(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraItensBoi: TFrmAlteraItensBoi;

implementation

uses UntAlteraPedidoAcougue, UntDataModulo, UntPesqCadProdBoi;

{$R *.DFM}

procedure TFrmAlteraItensBoi.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadProdBoi, frmPesqCadProdBoi);
  FrmPesqCadProdboi.ShowModal;
  FrmPesqCadProdBoi.Destroy;
  FrmAlteraPedidoAcougue.TbAuxMov_VendasCod_Prod.AsString := DmPrincipal.TbProdutosBoi.FieldByName('Codigo').AsString;
end;

procedure TFrmAlteraItensBoi.BitBtn1Click(Sender: TObject);
Var nTotal: Real;
begin
  Edit2.Text := FormatCurr('###,###,##0.00',(StrToFloat(Edit1.Text) * StrToFloat(Edit3.Text)));
  FrmAlteraPedidoAcougue.TbAuxMov_Vendas.FieldByName('Unitario').AsFloat := StrToFloat(Edit1.Text);
  FrmAlteraPedidoAcougue.TbAuxMov_Vendas.FieldByName('Qtde').AsFloat := StrToFloat(Edit3.Text);
  FrmAlteraPedidoAcougue.TbAuxMov_Vendas.Post;
  FrmAlteraPedidoAcougue.TbAuxVendas.Edit;
  FrmAlteraPedidoAcougue.TbAuxMov_Vendas.First;
  nTotal := 0;
  While not FrmAlteraPedidoAcougue.TbAuxMov_Vendas.EOF do
  Begin
    nTotal := nTotal + FrmAlteraPedidoAcougue.TbAuxMov_VendasTotal.AsFloat;
    FrmAlteraPedidoAcougue.TbAuxMov_Vendas.Next;
  end;
  FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Total').AsFloat := nTotal;
  FrmAlteraPedidoAcougue.TbAuxVendas.Post;
  Grava_no_Contas_a_Receber(nTotal);
end;

procedure TFrmAlteraItensBoi.BitBtn2Click(Sender: TObject);
begin
  FrmAlteraPedidoAcougue.TbAuxMov_Vendas.Cancel;
end;

procedure TFrmAlteraItensBoi.FormShow(Sender: TObject);
begin
  DmPrincipal.TbProdutosBoi.FindKey([FrmAlteraPedidoAcougue.TbAuxMov_Vendas.FieldByName('Cod_Prod').AsString]);
  Edit1.Text := FrmAlteraPedidoAcougue.TbAuxMov_Vendas.FieldByName('Unitario').asString;
  Edit3.Text := FrmAlteraPedidoAcougue.TbAuxMov_Vendas.FieldByName('Qtde').asString;
  edit2.Text := FrmAlteraPedidoAcougue.TbAuxMov_Vendas.FieldByName('Total').asString;
  Edit3.SetFocus;
end;

procedure TFrmAlteraItensBoi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmAlteraPedidoAcougue.TbAuxMov_Vendas.Cancel;
end;

function TFrmAlteraItensBoi.Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
begin
  DmPrincipal.TbReceberBoi.Active := True;
  If not DmPrincipal.TbReceberBoi.FindKey([FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Codigo').AsInteger,FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Venda_Nr').AsInteger]) Then
    Application.MessageBox('Pedido de Venda não encontrado no Contas à Receber !!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError)
  Else
  begin
    If not DmPrincipal.TbReceberBoi.FieldByName('Pago').AsBoolean Then
    Begin
      DmPrincipal.TbReceberBoi.Edit;
      DmPrincipal.TbReceberBoi.FieldByName('Total').AsFloat := nTotal;
      DmPrincipal.TbReceberBoi.Post;
    End
    Else
      //Pagamento ja fora efetuado
      If Application.MessageBox('Este Pedido de Venda já fora pago(Contas à Receber) !!! '+Chr(13)+Chr(13)+'Deseja alterá-lo mesmo assim ? ',' Confirmação de regravação no Contas à Receber',52) = id_Yes Then
      begin
        DmPrincipal.TbReceberBoi.Edit;
        DmPrincipal.TbReceberBoi.FieldByName('Total').AsFloat := nTotal;
        DmPrincipal.TbReceberBoi.Post;
      end;
  end;
  DmPrincipal.TbReceberBoi.Active := False;
  Result := True;
End;

procedure TFrmAlteraItensBoi.Edit3Exit(Sender: TObject);
begin
  Edit2.Text := FormatCurr('###,###,##0.00',(StrToFloat(Edit1.Text) * StrToFloat(Edit3.Text)));
end;

procedure TFrmAlteraItensBoi.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
    0: Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_BA').AsString;
    1: Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_AP').AsString;
    2: Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_TR').AsString;
  end;
end;

end.
