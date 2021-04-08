unit UntAlteraDevolucaoAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Db, DBTables, Menus;

type
  TFrmAlteraDevolucaoAcougue = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DsAuxDevolucaoboi: TDataSource;
    TbAuxDevolucaoBoi: TTable;
    DsAuxDev_MovBoi: TDataSource;
    TbAuxDev_MovBoi: TTable;
    TbAuxDevolucaoBoiDev_Nr: TIntegerField;
    TbAuxDevolucaoBoiCodigo: TIntegerField;
    TbAuxDevolucaoBoiData: TDateField;
    TbAuxDevolucaoBoiTotal: TCurrencyField;
    TbAuxDev_MovBoiDev_Nr: TIntegerField;
    TbAuxDev_MovBoiCod_Prod: TIntegerField;
    TbAuxDev_MovBoiQtde: TFloatField;
    TbAuxDev_MovBoiUnitario: TCurrencyField;
    TbAuxDev_MovBoiDescrio: TStringField;
    TbAuxDev_MovBoiunidade: TStringField;
    TbAuxDev_MovBoiTotal: TCurrencyField;
    PopupMenu1: TPopupMenu;
    Excluir1: TMenuItem;
    DBGrid3: TDBGrid;
    PopupMenu2: TPopupMenu;
    Excluir2: TMenuItem;
    Alterar1: TMenuItem;
    N1: TMenuItem;
    Alterar2: TMenuItem;
    N2: TMenuItem;
    Incluir1: TMenuItem;
    N3: TMenuItem;
    TbAuxDevolucaoBoiRazao: TStringField;
    TbAuxDevolucaoBoiFantasia: TStringField;
    procedure TbAuxDev_MovBoiCalcFields(DataSet: TDataSet);
    procedure Excluir1Click(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Excluir2Click(Sender: TObject);
    function Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
    procedure DBGrid3DblClick(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure Alterar2Click(Sender: TObject);
    procedure Incluir1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraDevolucaoAcougue: TFrmAlteraDevolucaoAcougue;

implementation

uses UntDataModulo, UntPesqCadCli, UntAlteraItensBoi, UntDevolucaoAcougue,
  UntAlteraDevolucaoBoi, UntAlteraItensDevBoi, UntIncluiItensDevBoi;

{$R *.DFM}

procedure TFrmAlteraDevolucaoAcougue.TbAuxDev_MovBoiCalcFields(
  DataSet: TDataSet);
begin
  TbAuxDev_MovBoiTotal.AsCurrency := (TbAuxDev_MovBoiQtde.AsFloat * TbAuxDev_MovBoiUnitario.AsCurrency);
end;

procedure TFrmAlteraDevolucaoAcougue.Excluir1Click(Sender: TObject);
Var ICodigo, IVenda : Integer;
begin
  ICodigo := DmPrincipal.TBClientes.FieldByName('Codigo').AsInteger;
  IVenda  := TbAuxDevolucaoBoi.FieldByName('Dev_Nr').AsInteger;
  If not DmPrincipal.TbReceberBoi.FindKey([ICodigo,IVenda,'D']) Then
    Application.MessageBox('Esta devolução não foi encontrada no '+Chr(13)+'Contas à Receber ...',' Advertência',64)
  Else
  Begin
    If Application.MessageBox('Deseja realmente excluir esta devolução',' Confirmação de Estorno de Devolução ',36) = IDYes Then
    Begin
      DmPrincipal.TbReceberBoi.Delete;
      TbAuxDev_MovBoi.First;
      While TbAuxDev_MovBoi.FieldByName('Dev_Nr').AsInteger = IVenda do
        TbAuxDev_MovBoi.Delete;

      TbAuxDevolucaoBoi.Delete;
    End;
  End;
end;

procedure TFrmAlteraDevolucaoAcougue.DBGrid2DblClick(Sender: TObject);
begin
  If TbAuxDevolucaoBoi.IsEmpty Then
    Application.MessageBox('Não há nenhuma Devolução do Açougue a ser alterada !!! ',' Advertência ',48)
  Else
  Begin
    Application.CreateForm(TFrmAlteraDevolucaoBoi, FrmAlteraDevolucaoBoi);
    FrmAlteraDevolucaoBoi.ShowModal;
    FrmAlteraDevolucaoBoi.Destroy;
  end
end;

procedure TFrmAlteraDevolucaoAcougue.FormShow(Sender: TObject);
begin
  DmPrincipal.TbClientes.Active    := True;
  TbAuxDevolucaoBoi.Active         := True;
  TbAuxDev_MovBoi.Active           := True;
  DmPrincipal.TbReceberBoi.Active  := True;
end;

procedure TFrmAlteraDevolucaoAcougue.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TbClientes.Active    := False;
  TbAuxDevolucaoBoi.Active         := False;
  TbAuxDev_MovBoi.Active           := False;
  DmPrincipal.TbReceberBoi.Active  := False;
end;

procedure TFrmAlteraDevolucaoAcougue.RadioGroup1Click(Sender: TObject);
begin
  If RadioGroup1.ItemIndex = 1 Then  // Pesquisa por Razao Social
  Begin
    DmPrincipal.TbClientes.IndexName := 'Cli_Nome';
    DbGrid1.Columns[0].Title.Caption := 'Razão Social';
    DbGrid1.Columns[0].FieldName := 'Razao';
    DbGrid1.Columns[1].Title.Caption := 'Nome Fantasia';
    DbGrid1.Columns[1].FieldName := 'Fantasia';
  End
  Else
  Begin
    DmPrincipal.TbClientes.IndexName := 'Cli_Apel';
    DbGrid1.Columns[0].Title.Caption := 'Nome Fantasia';
    DbGrid1.Columns[0].FieldName := 'Fantasia';
    DbGrid1.Columns[1].Title.Caption := 'Razão Social';
    DbGrid1.Columns[1].FieldName := 'Razao';
  End;
end;

procedure TFrmAlteraDevolucaoAcougue.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadCli, frmPesqCadCli);
  FrmPesqCadCli.ShowModal;
  FrmPesqCadCli.Destroy;
end;

procedure TFrmAlteraDevolucaoAcougue.Excluir2Click(Sender: TObject);
Var nTotal: Real;
begin
  If TbAuxDev_MovBoi.IsEmpty Then
    Application.MessageBox('Não há nenhum ítem a ser excluído !!! ',' Advertência ',48)
  Else
    If Application.MessageBox('Deseja realmente excluir este ítem ? ',' Confirmação de exclusão ',36) = id_Yes Then
    Begin
      TbAuxDev_MovBoi.Delete;
      TbAuxDev_MovBoi.First;
      nTotal := 0;
      While not TbAuxDev_MovBoi.EOF do
      Begin
        nTotal := nTotal + TbAuxDev_MovBoiTotal.AsFloat;
        TbAuxDev_MovBoi.Next;
      end;
      TbAuxDevolucaoBoi.Edit;
      TbAuxDevolucaoBoi.FieldByName('Total').AsFloat := nTotal;
      TbAuxDevolucaoBoi.Post;
      // Alteracao no Contas a Receber
      FrmAlteraDevolucaoAcougue.Grava_no_Contas_a_Receber(nTotal);
    End;
end;

function TFrmAlteraDevolucaoAcougue.Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
begin
  If not DmPrincipal.TbReceberBoi.FindKey([FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.FieldByName('Codigo').AsInteger, FrmAlteraDevolucaoAcougue.TbAuxDevolucaoBoi.FieldByName('Dev_Nr').AsInteger]) Then
    Application.MessageBox('Devolução de Açougue não encontrado no Contas à Receber !!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError)
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
      If Application.MessageBox('Esta devoluçõ de açougue já fora pago(Contas à Receber) !!! '+Chr(13)+Chr(13)+'Deseja alterá-lo mesmo assim ? ',' Confirmação de regravação no Contas à Receber',52) = id_Yes Then
      begin
        DmPrincipal.TbReceberBoi.Edit;
        DmPrincipal.TbReceberBoi.FieldByName('Total').AsFloat := nTotal;
        DmPrincipal.TbReceberBoi.Post;
      end;
  end;
  Result := True;
End;

procedure TFrmAlteraDevolucaoAcougue.DBGrid3DblClick(Sender: TObject);
Var nTotal: Real;
begin
  If TbAuxDev_MovBoi.IsEmpty Then
    Application.MessageBox('Não há nenhum ítem a ser excluído !!! ',' Advertência ',48)
  Else
    If Application.MessageBox('Deseja realmente excluir este ítem ? ',' Confirmação de exclusão ',36) = id_Yes Then
    Begin
      TbAuxDev_MovBoi.Delete;
      TbAuxDev_MovBoi.First;
      nTotal := 0;
      While not TbAuxDev_MovBoi.EOF do
      Begin
        nTotal := nTotal + TbAuxDev_MovBoiTotal.AsFloat;
        TbAuxDev_MovBoi.Next;
      end;
      TbAuxDevolucaoBoi.Edit;
      TbAuxDevolucaoBoi.FieldByName('Total').AsFloat := nTotal;
      TbAuxDevolucaoBoi.Post;
      // Alteracao no Contas a Receber
      FrmAlteraDevolucaoAcougue.Grava_no_Contas_a_Receber(nTotal);
    End;
end;

procedure TFrmAlteraDevolucaoAcougue.Alterar1Click(Sender: TObject);
begin
  If TbAuxDevolucaoBoi.IsEmpty Then
    Application.MessageBox('Não há nenhuma Devolução do Açougue a ser alterada !!! ',' Advertência ',48)
  Else
  Begin
    Application.CreateForm(TFrmAlteraDevolucaoBoi, FrmAlteraDevolucaoBoi);
    FrmAlteraDevolucaoBoi.ShowModal;
    FrmAlteraDevolucaoBoi.Destroy;
  end
end;


procedure TFrmAlteraDevolucaoAcougue.Alterar2Click(Sender: TObject);
begin
  If TbAuxDev_MovBoi.IsEmpty Then
    Application.MessageBox('Não há ítens a ser alterado !!! ',' Advertência ',48)
  Else
  Begin
    TbAuxDev_MovBoi.Edit;
    Application.CreateForm(TFrmAlteraItensDevBoi, FrmAlteraItensDevBoi);
    FrmAlteraItensDevBoi.ShowModal;
    FrmAlteraItensDevBoi.Destroy;
  End;
end;

procedure TFrmAlteraDevolucaoAcougue.Incluir1Click(Sender: TObject);
begin
  TbAuxDev_MovBoi.Insert;
  Application.CreateForm(TFrmInclui_Itens_DevBoi, FrmInclui_Itens_DevBoi);
  FrmInclui_Itens_DevBoi.ShowModal;
  FrmInclui_Itens_DevBoi.Destroy;
end;

end.
