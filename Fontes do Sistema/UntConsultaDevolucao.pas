unit UntConsultaDevolucao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Menus;

type
  TFrmConsultaDevolucao = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    DBGrid2: TDBGrid;
    GroupBox3: TGroupBox;
    DBGrid3: TDBGrid;
    DsAuxDevolucao: TDataSource;
    TbAuxDevolucao: TTable;
    DsAuxDev_Mov: TDataSource;
    TbAuxDev_Mov: TTable;
    TbAuxDevolucaoDev_Nr: TIntegerField;
    TbAuxDevolucaoCodigo: TIntegerField;
    TbAuxDevolucaoData: TDateField;
    TbAuxDevolucaoTotal: TCurrencyField;
    TbAuxDev_MovDev_Nr: TIntegerField;
    TbAuxDev_MovCod_Prod: TIntegerField;
    TbAuxDev_MovQtde: TFloatField;
    TbAuxDev_MovUnitario: TCurrencyField;
    TbAuxDev_MovDescrio: TStringField;
    TbAuxDev_MovUnidade: TStringField;
    TbAuxDev_MovTotal: TCurrencyField;
    PopupMenu1: TPopupMenu;
    Excluir1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TbAuxDev_MovCalcFields(DataSet: TDataSet);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsultaDevolucao: TFrmConsultaDevolucao;

implementation

uses UntDataModulo, UntPesqCadCli;

{$R *.DFM}



procedure TFrmConsultaDevolucao.FormShow(Sender: TObject);
begin
  DmPrincipal.TbClientes.Active := True;
  TbAuxDevolucao.Active         := True;
  TbAuxDev_Mov.Active           := True;
  DmPrincipal.TbReceber.Active  := True;
end;

procedure TFrmConsultaDevolucao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TbClientes.Active := False;
  TbAuxDevolucao.Active         := False;
  TbAuxDev_Mov.Active           := False;
  DmPrincipal.TbReceber.Active  := False;
end;

procedure TFrmConsultaDevolucao.TbAuxDev_MovCalcFields(DataSet: TDataSet);
begin
  TbAuxDev_MovTotal.AsCurrency := (TbAuxDev_MovQtde.AsFloat * TbAuxDev_MovUnitario.AsCurrency);
end;

procedure TFrmConsultaDevolucao.RadioGroup1Click(Sender: TObject);
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

procedure TFrmConsultaDevolucao.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadCli, frmPesqCadCli);
  FrmPesqCadCli.ShowModal;
  FrmPesqCadCli.Destroy;
end;

procedure TFrmConsultaDevolucao.DBGrid2DblClick(Sender: TObject);
Var ICodigo, IVenda : Integer;
begin
  ICodigo := DmPrincipal.TBClientes.FieldByName('Codigo').AsInteger;
  IVenda  := TbAuxDevolucao.FieldByName('Dev_Nr').AsInteger;
  If not DmPrincipal.TbReceber.FindKey([ICodigo,IVenda,'D']) Then
    Application.MessageBox('Esta devolução não foi encontrada no '+Chr(13)+'Contas à Receber ...',' Advertência',64)
  Else
  Begin
    If Application.MessageBox('Deseja realmente excluir esta devolução',' Confirmação de Estorno de Devolução ',36) = IDYes Then
    Begin
      DmPrincipal.TbReceber.Delete;
      TbAuxDev_Mov.First;
      While TbAuxDev_Mov.FieldByName('Dev_Nr').AsInteger = IVenda do
        TbAuxDev_Mov.Delete;

      TbAuxDevolucao.Delete;
    End;
  End;
end;

procedure TFrmConsultaDevolucao.Excluir1Click(Sender: TObject);
Var ICodigo, IVenda : Integer;
begin
  ICodigo := DmPrincipal.TBClientes.FieldByName('Codigo').AsInteger;
  IVenda  := TbAuxDevolucao.FieldByName('Dev_Nr').AsInteger;
  If not DmPrincipal.TbReceber.FindKey([ICodigo,IVenda,'D']) Then
    Application.MessageBox('Esta devolução não foi encontrada no '+Chr(13)+'Contas à Receber ...',' Advertência',64)
  Else
  Begin
    If Application.MessageBox('Deseja realmente excluir esta devolução',' Confirmação de Estorno de Devolução ',36) = IDYes Then
    Begin
      DmPrincipal.TbReceber.Delete;
      TbAuxDev_Mov.First;
      While TbAuxDev_Mov.FieldByName('Dev_Nr').AsInteger = IVenda do
        TbAuxDev_Mov.Delete;

      TbAuxDevolucao.Delete;
    End;
  End;
end;

end.
