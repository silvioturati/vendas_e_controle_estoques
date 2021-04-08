unit UntAlteraItensDevBoi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons;

type
  TFrmAlteraItensDevBoi = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RadioGroup1: TRadioGroup;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    function Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraItensDevBoi: TFrmAlteraItensDevBoi;

implementation

uses UntAlteraDevolucaoAcougue, UntPesqCadProdBoi, UntDataModulo;

{$R *.DFM}

procedure TFrmAlteraItensDevBoi.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadProdBoi, frmPesqCadProdBoi);
  FrmPesqCadProdBoi.ShowModal;
  FrmPesqCadProdBoi.Destroy;
  FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoiCod_Prod.AsString := DmPrincipal.TbProdutosBoi.FieldByName('Codigo').AsString;
  Edit1.Text := FormatCurr('#####0.00',DmPrincipal.TbProdutosBoi.FieldbyName('Valor_BA').AsFloat);
end;

procedure TFrmAlteraItensDevBoi.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
    0: Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_BA').AsString;
    1: Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_AP').AsString;
    2: Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_TR').AsString;
  end;
end;

procedure TFrmAlteraItensDevBoi.BitBtn1Click(Sender: TObject);
Var nTotal: Real;
begin
  FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.FieldByName('Unitario').AsFloat := StrToFloat(Edit1.Text);
  FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.FieldByName('Qtde').AsFloat := StrToFloat(Edit3.Text);
  FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.Post;
  FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.Edit;
  FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.First;
  nTotal := 0;
  While not FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.EOF do
  Begin
    nTotal := nTotal + FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoiTotal.AsFloat;
    FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.Next;
  end;
  FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.FieldByName('Total').AsFloat := nTotal;
  FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.Post;
  Grava_no_Contas_a_Receber(nTotal);
end;

function TFrmAlteraItensDevBoi.Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
begin
  DmPrincipal.TbReceberBoi.Active := True;
  If not DmPrincipal.TbReceberBoi.FindKey([FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.FieldByName('Codigo').AsInteger,FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.FieldByName('Venda_Nr').AsInteger]) Then
    Application.MessageBox('Devolução não encontrada no Contas à Receber !!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError)
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
      If Application.MessageBox('Esta Devolução já fora pago(Contas à Receber) !!! '+Chr(13)+Chr(13)+'Deseja alterá-la mesmo assim ? ',' Confirmação de regravação no Contas à Receber',52) = id_Yes Then
      begin
        DmPrincipal.TbReceberBoi.Edit;
        DmPrincipal.TbReceberBoi.FieldByName('Total').AsFloat := nTotal;
        DmPrincipal.TbReceberBoi.Post;
      end;
  end;
  DmPrincipal.TbReceberBoi.Active := False;
  Result := True;
End;

procedure TFrmAlteraItensDevBoi.BitBtn2Click(Sender: TObject);
begin
  FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.Cancel;
end;

procedure TFrmAlteraItensDevBoi.Edit3Exit(Sender: TObject);
begin
  Edit2.Text := FormatCurr('###,###,##0.00',(StrToFloat(Edit1.Text) * StrToFloat(Edit3.Text)));
end;

procedure TFrmAlteraItensDevBoi.FormShow(Sender: TObject);
begin
  DmPrincipal.TbProdutosBoi.FindKey([FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.FieldByName('Cod_Prod').AsString]);
  Edit1.Text := FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.FieldByName('Unitario').AsString;
  Edit3.Text := FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.FieldByName('qtde').AsString;
  Edit2.Text := FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.FieldByName('Total').AsString;
  Edit3.SetFocus;
end;

procedure TFrmAlteraItensDevBoi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmAlteraDevolucaoAcougue.TbAuxDev_MovBoi.Cancel;
end;

end.
