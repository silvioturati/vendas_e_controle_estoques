unit UntBaixaCancelamentoContasReceberAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, Db, DBTables, Menus;

type
  TFrmBaixaCancelamentoContasReceberAcougue = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    GroupBox3: TGroupBox;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    Edit1: TEdit;
    DBGrid2: TDBGrid;
    DsAuxReceberBoi: TDataSource;
    TbAuxReceberBoi: TTable;
    TbAuxReceberBoiCodigo: TIntegerField;
    TbAuxReceberBoiVenda_Nr: TIntegerField;
    TbAuxReceberBoiD_C: TStringField;
    TbAuxReceberBoiData: TDateField;
    TbAuxReceberBoiTotal: TCurrencyField;
    TbAuxReceberBoiData_Pgto: TDateField;
    TbAuxReceberBoiPago: TStringField;
    PopupMenu1: TPopupMenu;
    Baixar1: TMenuItem;
    N1: TMenuItem;
    Alterar1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    CancelarBaixa1: TMenuItem;
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure RadioGroup3Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure Baixar1Click(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure CancelarBaixa1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBaixaCancelamentoContasReceberAcougue: TFrmBaixaCancelamentoContasReceberAcougue;

implementation

uses UntDataModulo, UntPesqCadCli, UntConfirmaBaixaContasReceberAcougue;

{$R *.DFM}

procedure TFrmBaixaCancelamentoContasReceberAcougue.RadioGroup1Click(
  Sender: TObject);
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

procedure TFrmBaixaCancelamentoContasReceberAcougue.BitBtn1Click(
  Sender: TObject);
Var nTotal: Currency;
begin
  Application.CreateForm(TfrmPesqCadCli, frmPesqCadCli);
  FrmPesqCadCli.ShowModal;
  FrmPesqCadCli.Destroy;
  TbAuxReceberBoi.First;
  nTotal := 0;
  While not TbAuxReceberBoi.EOF do
  Begin
    If TbAuxReceberBoiPago.AsString <> 'Ok' Then
      nTotal := nTotal + TbAuxReceberBoiTotal.AsCurrency;
    TbAuxReceberBoi.Next;
  End;
  Edit1.Text := FormatCurr('###,###,###,##0.00',nTotal);
end;

procedure TFrmBaixaCancelamentoContasReceberAcougue.DBGrid1CellClick(
  Column: TColumn);
Var nTotal: Currency;
begin
  TbAuxReceberBoi.First;
  nTotal := 0;
  While not TbAuxReceberBoi.EOF do
  Begin
    If TbAuxReceberBoiPago.AsString <> 'Ok' Then
      nTotal := nTotal + TbAuxReceberBoiTotal.AsCurrency;
    TbAuxReceberBoi.Next;
  End;
  Edit1.Text := FormatCurr('###,###,###,##0.00',nTotal);
end;

procedure TFrmBaixaCancelamentoContasReceberAcougue.RadioGroup3Click(
  Sender: TObject);
begin
  If RadioGroup2.ItemIndex = 0 Then
    TbAuxReceberBoi.Filtered := True
  Else
    TbAuxReceberBoi.Filtered := False;
end;

procedure TFrmBaixaCancelamentoContasReceberAcougue.RadioGroup2Click(
  Sender: TObject);
begin
  If RadioGroup2.ItemIndex = 0 Then
    TbAuxReceberBoi.IndexName := ''   // Indexado por Cliente + Nº Pedido de Venda
  Else
    TbAuxReceberBoi.IndexName := 'RecBoi_Cli';  // Indexado por Cliente + Data
end;

procedure TFrmBaixaCancelamentoContasReceberAcougue.DBGrid2DblClick(
  Sender: TObject);
begin
  If TbAuxReceberBoi.FieldByName('Pago').AsString = 'Ok' then
  Begin
    Application.MessageBox('Título já fora baixado no Contas à Receber !!!'+Chr(13)+Chr(13)+'                   Verifique...',' Advertência ',48);
    Exit;
  End;
  Application.CreateForm(TFrmConfirmaBaixaContasReceberAcougue, FrmConfirmaBaixaContasReceberAcougue);
  FrmConfirmaBaixaContasReceberAcougue.DbEdit3.Enabled := False;
  FrmConfirmaBaixaContasReceberAcougue.DbEdit4.Enabled := False;
  FrmConfirmaBaixaContasReceberAcougue.DbEdit5.Enabled := False;
  FrmConfirmaBaixaContasReceberAcougue.DbEdit6.Enabled := True;
  FrmConfirmaBaixaContasReceberAcougue.Caption := 'Baixa no Contas à Receber';
  TbAuxReceberBoi.Edit;
  FrmConfirmaBaixaContasReceberAcougue.ShowModal;
  FrmConfirmaBaixaContasReceberAcougue.Destroy;
end;

procedure TFrmBaixaCancelamentoContasReceberAcougue.Baixar1Click(
  Sender: TObject);
begin
  If TbAuxReceberBoi.FieldByName('Pago').AsString = 'Ok' then
  Begin
    Application.MessageBox('Título já fora baixado no Contas à Receber !!!'+Chr(13)+Chr(13)+'                   Verifique...',' Advertência ',48);
    Exit;
  End;
  If TbAuxReceberBoi.IsEmpty Then
  Begin
    Application.MessageBox('Não há título a serem baixados !!!',' Informação ',64);
    Exit;
  End;
  Application.CreateForm(TFrmConfirmaBaixaContasReceberAcougue, FrmConfirmaBaixaContasReceberAcougue);
  FrmConfirmaBaixaContasReceberAcougue.DbEdit4.Enabled := False;
  FrmConfirmaBaixaContasReceberAcougue.DbEdit5.Enabled := False;
  FrmConfirmaBaixaContasReceberAcougue.DbEdit6.Enabled := True;
  FrmConfirmaBaixaContasReceberAcougue.Caption := 'Baixa no Contas à Receber';
  TbAuxReceberBoi.Edit;
  FrmConfirmaBaixaContasReceberAcougue.ShowModal;
  FrmConfirmaBaixaContasReceberAcougue.Destroy;
end;

procedure TFrmBaixaCancelamentoContasReceberAcougue.Alterar1Click(
  Sender: TObject);
begin
  Application.CreateForm(TFrmConfirmaBaixaContasReceberAcougue, FrmConfirmaBaixaContasReceberAcougue);
  FrmConfirmaBaixaContasReceberAcougue.DbEdit4.Enabled := True;
  FrmConfirmaBaixaContasReceberAcougue.DbEdit5.Enabled := True;
  FrmConfirmaBaixaContasReceberAcougue.DbEdit6.Enabled := True;
  FrmConfirmaBaixaContasReceberAcougue.Caption := 'Alteração de dados no Contas à Receber';
  TbAuxReceberBoi.Edit;
  FrmConfirmaBaixaContasReceberAcougue.ShowModal;
  FrmConfirmaBaixaContasReceberAcougue.Destroy;
end;

procedure TFrmBaixaCancelamentoContasReceberAcougue.N2Click(
  Sender: TObject);
begin
  If Application.MessageBox('Deseja realmente excluí-lo ? (Contas à Receber)',' Confirmação de exclusão ',36) = id_Yes Then
    TbAuxReceberBoi.Delete;
end;

procedure TFrmBaixaCancelamentoContasReceberAcougue.CancelarBaixa1Click(
  Sender: TObject);
begin
  FrmBaixaCancelamentoContasReceberAcougue.TbAuxReceberBoi.Edit;
  FrmBaixaCancelamentoContasReceberAcougue.TbAuxReceberBoiData_Pgto.AsString := DateToStr(Date());
  FrmBaixaCancelamentoContasReceberAcougue.TbAuxReceberBoiPago.AsString      := '';
  FrmBaixaCancelamentoContasReceberAcougue.TbAuxReceberBoi.Post;
end;

procedure TFrmBaixaCancelamentoContasReceberAcougue.FormShow(
  Sender: TObject);
Var nTotal: Currency;
begin
  DmPrincipal.TbClientes.Active := True;
  TbAuxReceberBoi.Active        := True;
  TbAuxReceberBoi.Filtered      := True;
  // Atualizar o Total Geral a Receber no Edit1 abaixo a direita
  TbAuxReceberBoi.First;
  nTotal := 0;
  While not TbAuxReceberBoi.EOF do
  Begin
    If TbAuxReceberBoiPago.AsString <> 'Ok' Then
      nTotal := nTotal + TbAuxReceberBoiTotal.AsCurrency;
    TbAuxReceberBoi.Next;
  End;
  Edit1.Text := FormatCurr('###,###,###,##0.00',nTotal);
end;

procedure TFrmBaixaCancelamentoContasReceberAcougue.FormClose(
  Sender: TObject; var Action: TCloseAction);
begin
  DmPrincipal.TbClientes.Active    := False;
  TbAuxReceberBoi.Filtered         := false;
  TbAuxReceberBoi.Active           := False;
  DmPrincipal.TbVendasBoi.Active   := False;
  DmPrincipal.TbReceberBoi.Active  := False;
end;

end.
