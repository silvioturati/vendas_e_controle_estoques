unit UntIncluiItensboi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, DBCtrls, Buttons;

type
  TFrmInclui_Itens_Boi = class(TForm)
    DBEdit6: TDBEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit5: TDBEdit;
    RadioGroup1: TRadioGroup;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    Edit3: TEdit;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInclui_Itens_Boi: TFrmInclui_Itens_Boi;

implementation

uses UntDataModulo, UntAlteraPedidoAcougue, UntPesqCadProdBoi;

{$R *.DFM}


procedure TFrmInclui_Itens_Boi.BtnOkClick(Sender: TObject);
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

procedure TFrmInclui_Itens_Boi.BtnCancelClick(Sender: TObject);
begin
  FrmAlteraPedidoAcougue.TbAuxMov_Vendas.Cancel;
end;

procedure TFrmInclui_Itens_Boi.FormShow(Sender: TObject);
begin
  DmPrincipal.TbProdutosBoi.Active := True;
  Case RadioGroup1.ItemIndex of
    0 : Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_BA').AsString;
    1 : Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_AP').AsString;
    2 : Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_TR').AsString;
  end;
  RadioGroup1.SetFocus;
end;

function TFrmInclui_Itens_Boi.Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
begin
  DmPrincipal.TbReceberBoi.Active := True;
  If not DmPrincipal.TbReceberBoi.FindKey([FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Codigo').AsInteger,FrmAlteraPedidoAcougue.TbAuxVendas.FieldByName('Venda_Nr').AsInteger]) Then
    Application.MessageBox('Este Pedido do Açougue não foi encontrado no Contas à Receber!!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError)
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
      If Application.MessageBox('Verifique no contas a receber pois este Pedido do Açougue já fora pago!!! '+Chr(13)+Chr(13)+'Deseja alterá-lo mesmo assim ? ',' Confirmação de regravação no Contas à Receber',52) = id_Yes Then
      begin
        DmPrincipal.TbReceberBoi.Edit;
        DmPrincipal.TbReceberBoi.FieldByName('Total').AsFloat := nTotal;
        DmPrincipal.TbReceberBoi.Post;
      end;
  end;
  DmPrincipal.TbReceberBoi.Active := False;
  Result := True;
End;

procedure TFrmInclui_Itens_Boi.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
    0 : Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_BA').AsString;
    1 : Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_AP').AsString;
    2 : Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_TR').AsString;
  end;
end;

procedure TFrmInclui_Itens_Boi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmAlteraPedidoAcougue.TbAuxMov_Vendas.Cancel;
  DmPrincipal.TbProdutosBoi.Active := False;
end;

procedure TFrmInclui_Itens_Boi.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadProdBoi, frmPesqCadProdBoi);
  FrmPesqCadProdboi.ShowModal;
  FrmPesqCadProdBoi.Destroy;
  FrmAlteraPedidoAcougue.TbAuxMov_VendasCod_Prod.AsString := DmPrincipal.TbProdutosBoi.FieldByName('Codigo').AsString;
  Case RadioGroup1.ItemIndex of
    0 : Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_BA').AsString;
    1 : Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_AP').AsString;
    2 : Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_TR').AsString;
  end;
end;

procedure TFrmInclui_Itens_Boi.Edit3Exit(Sender: TObject);
begin
  Edit2.Text := FormatCurr('###,###,##0.00',(StrToFloat(Edit1.Text) * StrToFloat(Edit3.Text)));
end;

end.
