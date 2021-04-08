unit UntAlteraItensFra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  TFrmAlteraItensFra = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBEdit5: TDBEdit;
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    Edit3: TEdit;
    RadioGroup1: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    function Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
    procedure Edit3Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraItensFra: TFrmAlteraItensFra;

implementation

uses UntDataModulo, UntAlteraPedidoAvicola, UntPedidoAvicola, UntCadProdFra,
  UntPesqCadProdFra;

{$R *.DFM}

function TFrmAlteraItensFra.Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
begin
  DmPrincipal.TbReceberFra.Active := True;
  If not DmPrincipal.TbReceberFra.FindKey([FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Codigo').AsInteger,FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Venda_Nr').AsInteger]) Then
    Application.MessageBox('Pedido de Venda não encontrado no Contas à Receber !!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError)
  Else
  begin
    If not DmPrincipal.TbReceberFra.FieldByName('Pago').AsBoolean Then
    Begin
      DmPrincipal.TbReceberFra.Edit;
      DmPrincipal.TbReceberFra.FieldByName('Total').AsFloat := nTotal;
      DmPrincipal.TbReceberFra.Post;
    End
    Else
      //Pagamento ja fora efetuado
      If Application.MessageBox('Este Pedido de Venda já fora pago(Contas à Receber) !!! '+Chr(13)+Chr(13)+'Deseja alterá-lo mesmo assim ? ',' Confirmação de regravação no Contas à Receber',52) = id_Yes Then
      begin
        DmPrincipal.TbReceberFra.Edit;
        DmPrincipal.TbReceberFra.FieldByName('Total').AsFloat := nTotal;
        DmPrincipal.TbReceberFra.Post;
      end;
  end;
  DmPrincipal.TbReceberFra.Active := False;
  Result := True;
End;

procedure TFrmAlteraItensFra.FormShow(Sender: TObject);
begin
  DmPrincipal.TbProdutosFra.FindKey([FrmAlteraPedidoAvicola.TbAuxMov_Vendas.FieldByName('Cod_Prod').AsString]);
  Edit1.Text := FrmAlteraPedidoAvicola.TbAuxMov_Vendas.FieldByName('Unitario').AsString;
  Edit3.Text := FrmAlteraPedidoAvicola.TbAuxMov_Vendas.FieldByName('qtde').AsString;
  Edit2.Text := FrmAlteraPedidoAvicola.TbAuxMov_Vendas.FieldByName('Total').AsString;
  Edit3.SetFocus;
end;

procedure TFrmAlteraItensFra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmAlteraPedidoAvicola.TbAuxMov_Vendas.Cancel;
end;

procedure TFrmAlteraItensFra.BitBtn1Click(Sender: TObject);
Var nTotal: Real;
begin
  FrmAlteraPedidoAvicola.TbAuxMov_Vendas.FieldByName('Unitario').AsFloat := StrToFloat(Edit1.Text);
  FrmAlteraPedidoAvicola.TbAuxMov_Vendas.FieldByName('Qtde').AsFloat := StrToFloat(Edit3.Text);
  FrmAlteraPedidoAvicola.TbAuxMov_Vendas.Post;
  FrmAlteraPedidoAvicola.TbAuxVendas.Edit;
  FrmAlteraPedidoAvicola.TbAuxMov_Vendas.First;
  nTotal := 0;
  While not FrmAlteraPedidoAvicola.TbAuxMov_Vendas.EOF do
  Begin
    nTotal := nTotal + FrmAlteraPedidoAvicola.TbAuxMov_VendasTotal.AsFloat;
    FrmAlteraPedidoAvicola.TbAuxMov_Vendas.Next;
  end;
  FrmAlteraPedidoAvicola.TbAuxVendas.FieldByName('Total').AsFloat := nTotal;
  FrmAlteraPedidoAvicola.TbAuxVendas.Post;
  Grava_no_Contas_a_Receber(nTotal);
end;

procedure TFrmAlteraItensFra.BitBtn2Click(Sender: TObject);
begin
  FrmAlteraPedidoAvicola.TbAuxMov_Vendas.Cancel;
end;

procedure TFrmAlteraItensFra.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
    0: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_BA').AsString;
    1: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_AP').AsString;
    2: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_TR').AsString;
  end;
end;

procedure TFrmAlteraItensFra.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadProdFra, frmPesqCadProdFra);
  FrmPesqCadProdFra.ShowModal;
  FrmPesqCadProdFra.Destroy;
  FrmAlteraPedidoAvicola.TbAuxMov_VendasCod_Prod.AsString := DmPrincipal.TbProdutosFra.FieldByName('Codigo').AsString;
  Edit1.Text := FormatCurr('#####0.00',DmPrincipal.TbProdutosFra.FieldbyName('Valor_BA').AsFloat);
end;

procedure TFrmAlteraItensFra.Edit3Exit(Sender: TObject);
begin
  Edit2.Text := FormatCurr('###,###,##0.00',(StrToFloat(Edit1.Text) * StrToFloat(Edit3.Text)));
end;


end.
