unit UntAlteraDevolucaoAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Menus;

type
  TFrmAlteraDevolucaoAvicola = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    DBGrid2: TDBGrid;
    GroupBox3: TGroupBox;
    DBGrid3: TDBGrid;
    DsAuxDevolucaoFra: TDataSource;
    TbAuxDevolucaoFra: TTable;
    DsAuxDev_MovFra: TDataSource;
    TbAuxDev_MovFra: TTable;
    TbAuxDevolucaoFraDev_Nr: TIntegerField;
    TbAuxDevolucaoFraCodigo: TIntegerField;
    TbAuxDevolucaoFraData: TDateField;
    TbAuxDevolucaoFraTotal: TCurrencyField;
    TbAuxDev_MovFraDev_Nr: TIntegerField;
    TbAuxDev_MovFraCod_Prod: TIntegerField;
    TbAuxDev_MovFraQtde: TFloatField;
    TbAuxDev_MovFraUnitario: TCurrencyField;
    TbAuxDev_MovFraDescrio: TStringField;
    TbAuxDev_MovFraUnidade: TStringField;
    TbAuxDev_MovFraTotal: TCurrencyField;
    PopupMenu1: TPopupMenu;
    Excluir1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Excluir2: TMenuItem;
    Alterar1: TMenuItem;
    N1: TMenuItem;
    TbAuxDevolucaoFraRazao: TStringField;
    TbAuxDevolucaoFraFantasia: TStringField;
    Alterar2: TMenuItem;
    N2: TMenuItem;
    Incluir1: TMenuItem;
    N3: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TbAuxDev_MovFraCalcFields(DataSet: TDataSet);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure Excluir2Click(Sender: TObject);
    function Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
    procedure Alterar1Click(Sender: TObject);
    procedure Alterar2Click(Sender: TObject);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure Incluir1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraDevolucaoAvicola: TFrmAlteraDevolucaoAvicola;

implementation

uses UntDataModulo, UntPesqCadCli, UntAlteraItensFra, UntAlteraDevolucaoFra,
  UntAlteraItensDevFra, UntIncluiItensDevFra;

{$R *.DFM}

procedure TFrmAlteraDevolucaoAvicola.FormShow(Sender: TObject);
begin
  DmPrincipal.TbClientes.Active    := True;
  DmPrincipal.TbReceberFra.Active  := True;
  TbAuxDevolucaoFra.Active         := True;
  TbAuxDev_MovFra.Active           := True;
end;

procedure TFrmAlteraDevolucaoAvicola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TbReceberFra.Active  := False;
  DmPrincipal.TbClientes.Active    := False;
  TbAuxDevolucaoFra.Active         := False;
  TbAuxDev_MovFra.Active           := False;
end;

procedure TFrmAlteraDevolucaoAvicola.TbAuxDev_MovFraCalcFields(DataSet: TDataSet);
begin
  TbAuxDev_MovFraTotal.AsCurrency := (TbAuxDev_MovFraQtde.AsFloat * TbAuxDev_MovFraUnitario.AsCurrency);
end;

procedure TFrmAlteraDevolucaoAvicola.RadioGroup1Click(Sender: TObject);
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

procedure TFrmAlteraDevolucaoAvicola.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadCli, frmPesqCadCli);
  FrmPesqCadCli.ShowModal;
  FrmPesqCadCli.Destroy;
end;

procedure TFrmAlteraDevolucaoAvicola.DBGrid2DblClick(Sender: TObject);
begin
  If TbAuxDevolucaoFra.IsEmpty Then
    Application.MessageBox('Não há nenhuma Devolução da Avicola a ser alterada !!! ',' Advertência ',48)
  Else
    Application.CreateForm(TFrmAlteraDevolucaoFra, FrmAlteraDevolucaoFra);
    FrmAlteraDevolucaoFra.ShowModal;
    FrmAlteraDevolucaoFra.Destroy;
end;

procedure TFrmAlteraDevolucaoAvicola.Excluir1Click(Sender: TObject);
Var ICodigo, IVenda : Integer;
begin
  ICodigo := DmPrincipal.TBClientes.FieldByName('Codigo').AsInteger;
  IVenda  := TbAuxDevolucaoFra.FieldByName('Dev_Nr').AsInteger;
  If not DmPrincipal.TbReceberFra.FindKey([ICodigo,IVenda,'D']) Then
    Application.MessageBox('Esta devolução não foi encontrada no '+Chr(13)+'Contas à Receber ...',' Advertência',64)
  Else
  Begin
    If Application.MessageBox('Deseja realmente excluir esta devolução',' Confirmação de Estorno de Devolução ',36) = IDYes Then
    Begin
      DmPrincipal.TbReceberFra.Delete;
      TbAuxDev_MovFra.First;
      While TbAuxDev_MovFra.FieldByName('Dev_Nr').AsInteger = IVenda do
        TbAuxDev_MovFra.Delete;

      TbAuxDevolucaoFra.Delete;
    End;
  End;
end;

procedure TFrmAlteraDevolucaoAvicola.Excluir2Click(Sender: TObject);
Var nTotal: Real;
begin
  If TbAuxDev_MovFra.IsEmpty Then
    Application.MessageBox('Não há nenhum ítem a ser excluído !!! ',' Advertência ',48)
  Else
    If Application.MessageBox('Deseja realmente excluir este ítem ? ',' Confirmação de exclusão ',36) = id_Yes Then
    Begin
      TbAuxDev_MovFra.Delete;
      TbAuxDev_MovFra.First;
      nTotal := 0;
      While not TbAuxDev_MovFra.EOF do
      Begin
        nTotal := nTotal + TbAuxDev_MovFraTotal.AsFloat;
        TbAuxDev_MovFra.Next;
      end;
      TbAuxDevolucaoFra.Edit;
      TbAuxDevolucaoFra.FieldByName('Total').AsFloat := nTotal;
      TbAuxDevolucaoFra.Post;
      // Alteracao no Contas a Receber
      FrmAlteraDevolucaoAvicola.Grava_no_Contas_a_Receber(nTotal);
    End;
end;

function TFrmAlteraDevolucaoAvicola.Grava_no_Contas_a_Receber(nTotal: Real):Boolean;
begin
  If not DmPrincipal.TbReceberFra.FindKey([FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.FieldByName('Codigo').AsInteger, FrmAlteraDevolucaoAvicola.TbAuxDevolucaoFra.FieldByName('Dev_Nr').AsInteger]) Then
    Application.MessageBox('Devolução de Avícola não encontrada no Contas à Receber !!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError)
  Else
  begin
    If not DmPrincipal.TbReceberFra.FieldByName('Pago').AsBoolean Then
    Begin
      DmPrincipal.TbReceberfra.Edit;
      DmPrincipal.TbReceberfra.FieldByName('Total').AsFloat := nTotal;
      DmPrincipal.TbReceberfra.Post;
    End
    Else
      //Pagamento ja fora efetuado
      If Application.MessageBox('Esta devolução de avícola já fora pago(Contas à Receber) !!! '+Chr(13)+Chr(13)+'Deseja alterá-la mesmo assim ? ',' Confirmação de regravação no Contas à Receber',52) = id_Yes Then
      begin
        DmPrincipal.TbReceberFra.Edit;
        DmPrincipal.TbReceberFra.FieldByName('Total').AsFloat := nTotal;
        DmPrincipal.TbReceberFra.Post;
      end;
  end;
  Result := True;
End;

procedure TFrmAlteraDevolucaoAvicola.Alterar1Click(Sender: TObject);
begin
  If TbAuxDevolucaoFra.IsEmpty Then
    Application.MessageBox('Não há nenhuma Devolução da Avicola a ser alterada !!! ',' Advertência ',48)
  Else
    Application.CreateForm(TFrmAlteraDevolucaoFra, FrmAlteraDevolucaoFra);
    FrmAlteraDevolucaoFra.ShowModal;
    FrmAlteraDevolucaoFra.Destroy;
end;

procedure TFrmAlteraDevolucaoAvicola.Alterar2Click(Sender: TObject);
begin
  If TbAuxDev_MovFra.IsEmpty Then
    Application.MessageBox('Não há ítens a ser alterado !!! ',' Advertência ',48)
  Else
  Begin
    TbAuxDev_MovFra.Edit;
    Application.CreateForm(TFrmAlteraItensDevFra, FrmAlteraItensDevFra);
    FrmAlteraItensDevFra.ShowModal;
    FrmAlteraItensDevFra.Destroy;
  End;
end;

procedure TFrmAlteraDevolucaoAvicola.DBGrid3DblClick(Sender: TObject);
begin
  If TbAuxDev_MovFra.IsEmpty Then
    Application.MessageBox('Não há ítens a ser alterado !!! ',' Advertência ',48)
  Else
  Begin
    TbAuxDev_MovFra.Edit;
    Application.CreateForm(TFrmAlteraItensDevFra, FrmAlteraItensDevFra);
    FrmAlteraItensDevFra.ShowModal;
    FrmAlteraItensDevFra.Destroy;
  End;
end;

procedure TFrmAlteraDevolucaoAvicola.Incluir1Click(Sender: TObject);
begin
  TbAuxDev_MovFra.Insert;
  Application.CreateForm(TFrmInclui_Itens_DevFra, FrmInclui_Itens_DevFra);
  FrmInclui_Itens_DevFra.ShowModal;
  FrmInclui_Itens_DevFra.Destroy;
end;

end.
