unit UntAlteraItensDevFra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls;

type
  TFrmAlteraItensDevFra = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    RadioGroup1: TRadioGroup;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit5: TDBEdit;
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    function Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraItensDevFra: TFrmAlteraItensDevFra;

implementation

uses UntAlteraDevolucaoAvicola, UntDataModulo, UntPesqCadProdFra,
  UntAlteraDevolucaoAcougue;

{$R *.DFM}

procedure TFrmAlteraItensDevFra.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadProdFra, frmPesqCadProdFra);
  FrmPesqCadProdFra.ShowModal;
  FrmPesqCadProdFra.Destroy;
  FrmAlteraDevolucaoAvicola.TbAuxDev_MovFraCod_Prod.AsString := DmPrincipal.TbProdutosFra.FieldByName('Codigo').AsString;
  Edit1.Text := FormatCurr('#####0.00',DmPrincipal.TbProdutosFra.FieldbyName('Valor_BA').AsFloat);
end;

procedure TFrmAlteraItensDevFra.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
    0: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_BA').AsString;
    1: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_AP').AsString;
    2: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_TR').AsString;
  end;
end;

procedure TFrmAlteraItensDevFra.Edit3Exit(Sender: TObject);
begin
  Edit2.Text := FormatCurr('###,###,##0.00',(StrToFloat(Edit1.Text) * StrToFloat(Edit3.Text)));
end;

procedure TFrmAlteraItensDevFra.BitBtn1Click(Sender: TObject);
Var nTotal: Real;
begin
  FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.FieldByName('Unitario').AsFloat := StrToFloat(Edit1.Text);
  FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.FieldByName('Qtde').AsFloat := StrToFloat(Edit3.Text);
  FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.Post;
  FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.Edit;
  FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.First;
  nTotal := 0;
  While not FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.EOF do
  Begin
    nTotal := nTotal + FrmAlteraDevolucaoAvicola.TbAuxDev_MovFraTotal.AsFloat;
    FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.Next;
  end;
  FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.FieldByName('Total').AsFloat := nTotal;
  FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.Post;
  Grava_no_Contas_a_Receber(nTotal);
end;

function TFrmAlteraItensDevFra.Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
begin
  DmPrincipal.TbReceberFra.Active := True;
  If not DmPrincipal.TbReceberFra.FindKey([FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.FieldByName('Codigo').AsInteger,FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.FieldByName('Venda_Nr').AsInteger]) Then
    Application.MessageBox('Devolução não encontrada no Contas à Receber !!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError)
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
      If Application.MessageBox('Esta Devolução já fora pago(Contas à Receber) !!! '+Chr(13)+Chr(13)+'Deseja alterá-la mesmo assim ? ',' Confirmação de regravação no Contas à Receber',52) = id_Yes Then
      begin
        DmPrincipal.TbReceberFra.Edit;
        DmPrincipal.TbReceberFra.FieldByName('Total').AsFloat := nTotal;
        DmPrincipal.TbReceberFra.Post;
      end;
  end;
  DmPrincipal.TbReceberFra.Active := False;
  Result := True;
End;

procedure TFrmAlteraItensDevFra.BitBtn2Click(Sender: TObject);
begin
  FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.Cancel;
end;

procedure TFrmAlteraItensDevFra.FormShow(Sender: TObject);
begin
  DmPrincipal.TbProdutosFra.FindKey([FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.FieldByName('Cod_Prod').AsString]);
  Edit1.Text := FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.FieldByName('Unitario').AsString;
  Edit3.Text := FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.FieldByName('qtde').AsString;
  Edit2.Text := FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.FieldByName('Total').AsString;
  Edit3.SetFocus;
end;

procedure TFrmAlteraItensDevFra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FrmAlteraDevolucaoAvicola.TbAuxDev_MovFra.Cancel;
end;

end.
