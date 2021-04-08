unit UntAlteraPedidoAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, Menus, Db, DBTables;

type
  TFrmAlteraPedidoAcougue = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    RadioGroup1: TRadioGroup;
    BtnPesquisar: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    TbAuxVendas: TTable;
    DsAuxVendas: TDataSource;
    PopupMenuVendas: TPopupMenu;
    TbAuxMov_Vendas: TTable;
    DSAuxMov_Vendas: TDataSource;
    PopupMenuMov_Vendas: TPopupMenu;
    DBGrid3: TDBGrid;
    TbAuxMov_VendasVenda_Nr: TIntegerField;
    TbAuxMov_VendasCod_Prod: TIntegerField;
    TbAuxMov_VendasQtde: TFloatField;
    TbAuxMov_VendasUnitario: TCurrencyField;
    TbAuxMov_VendasDescricao: TStringField;
    TbAuxMov_VendasUnidade: TStringField;
    TbAuxMov_VendasTotal: TCurrencyField;
    MnAlterao1: TMenuItem;
    N1: TMenuItem;
    MnExclusao1: TMenuItem;
    Alterao2: TMenuItem;
    Inclusotens1: TMenuItem;
    N2: TMenuItem;
    Excluso3: TMenuItem;
    TbAuxVendasVenda_Nr: TIntegerField;
    TbAuxVendasCodigo: TIntegerField;
    TbAuxVendasData: TDateField;
    TbAuxVendasTotal: TCurrencyField;
    TbAuxVendasTp_Venda: TStringField;
    TbAuxVendasPorc_Desc: TFloatField;
    procedure DBGrid2DblClick(Sender: TObject);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure TbAuxMov_VendasCalcFields(DataSet: TDataSet);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MnAlterao1Click(Sender: TObject);
    procedure MnExclusao1Click(Sender: TObject);
    procedure Alterao2Click(Sender: TObject);
    procedure Inclusotens1Click(Sender: TObject);
    procedure Excluso3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraPedidoAcougue: TFrmAlteraPedidoAcougue;

implementation

uses UntDataModulo, UntPesqCadCli, UntAlteraItensBoi,
  UntAlteraPedidoVendaBoi, UntConf_Itens_Boi, UntIncluiItensboi;

{$R *.DFM}

procedure TFrmAlteraPedidoAcougue.DBGrid2DblClick(Sender: TObject);
begin
  If TbAuxVendas.IsEmpty Then
    Application.MessageBox('Não há nenhum Pedido de Venda a ser alterado !!! ',' Advertência ',48)
  Else
  Begin
    Application.CreateForm(TFrmAlteraPedidoVendaBoi, FrmAlteraPedidoVendaBoi);
    FrmAlteraPedidoVendaBoi.ShowModal;
    FrmAlteraPedidoVendaBoi.Destroy;
  End;
end;

procedure TFrmAlteraPedidoAcougue.DBGrid3DblClick(Sender: TObject);
begin
  TbAuxMov_Vendas.Edit;
  Application.CreateForm(TFrmAlteraItensBoi, FrmAlteraItensBoi);
  FrmAlteraItensBoi.ShowModal;
  FrmAlteraItensBoi.Destroy;
end;

procedure TFrmAlteraPedidoAcougue.BtnPesquisarClick(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadCli, frmPesqCadCli);
  FrmPesqCadCli.ShowModal;
  FrmPesqCadCli.Destroy;
end;

procedure TFrmAlteraPedidoAcougue.TbAuxMov_VendasCalcFields(
  DataSet: TDataSet);
begin
  TbAuxMov_VendasTotal.AsCurrency := TbAuxMov_VendasUnitario.AsCurrency * TbAuxMov_VendasQtde.AsCurrency;
end;

procedure TFrmAlteraPedidoAcougue.RadioGroup1Click(Sender: TObject);
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
  Begin        //pesquisa por nome fantasia
    DmPrincipal.TbClientes.IndexName := 'Cli_Apel';
    DbGrid1.Columns[0].Title.Caption := 'Nome Fantasia';
    DbGrid1.Columns[0].FieldName := 'Fantasia';
    DbGrid1.Columns[1].Title.Caption := 'Razão Social';
    DbGrid1.Columns[1].FieldName := 'Razao';
  End;
end;

procedure TFrmAlteraPedidoAcougue.FormShow(Sender: TObject);
begin
  DmPrincipal.TbClientes.Active   := True;
  TbAuxVendas.Active     := True;
  TbAuxMov_Vendas.Active := True;
  If RadioGroup1.ItemIndex = 1 Then  // Pesquisa por Razao Social
  Begin
    DmPrincipal.TbClientes.IndexName := 'Cli_Nome';
    DbGrid1.Columns[0].Title.Caption := 'Razão Social';
    DbGrid1.Columns[0].FieldName := 'Razao';
    DbGrid1.Columns[1].Title.Caption := 'Nome Fantasia';
    DbGrid1.Columns[1].FieldName := 'Fantasia';
  End
  Else
  Begin        //pesquisa por nome fantasia
    DmPrincipal.TbClientes.IndexName := 'Cli_Apel';
    DbGrid1.Columns[0].Title.Caption := 'Nome Fantasia';
    DbGrid1.Columns[0].FieldName := 'Fantasia';
    DbGrid1.Columns[1].Title.Caption := 'Razão Social';
    DbGrid1.Columns[1].FieldName := 'Razao';
  End;
end;

procedure TFrmAlteraPedidoAcougue.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TbClientes.Active   := False;
  TbAuxVendas.Active     := False;
  TbAuxMov_Vendas.Active := False;
  DmPrincipal.TbClientes.IndexName := '';
end;


procedure TFrmAlteraPedidoAcougue.MnAlterao1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmAlteraPedidoVendaBoi, FrmAlteraPedidoVendaBoi);
  If TbAuxVendas.EOF Then
    Application.MessageBox('Não há nenhum Pedido de Venda a ser alterado !!! ',' Advertência ',48)
  Else
    FrmAlteraPedidoVendaBoi.ShowModal;
    FrmAlteraPedidoVendaBoi.Destroy;
end;

procedure TFrmAlteraPedidoAcougue.MnExclusao1Click(Sender: TObject);
begin
  If TbAuxVendas.IsEmpty Then
  Begin
    Application.MessageBox('Não há nenhum Pedido de Venda a ser alterado !!! ',' Advertência ',48);
    Exit;
  End;
  // Apagar o pedido de Venda no Contas a Receber
  If Application.MessageBox('Tem certeza que deseja apagar este Pedido de Venda ? '+Chr(13)+Chr(13)+' Esta operação apagará este Pedido no Contas a Receber também ',' Confirmação de exclusão ',52) = id_no Then
    Exit;

  DmPrincipal.TbReceberBoi.Active := True;
  If not DmPrincipal.TbReceberBoi.FindKey([TbAuxVendas.FieldByName('Codigo').AsInteger,TbAuxVendas.FieldByName('Venda_Nr').AsInteger]) Then
  Begin
    Application.MessageBox('Pedido de Venda não encontrado no Contas à Receber !!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError);
    Exit;
  End;

  If not DmPrincipal.TbReceberBoi.FieldByName('Pago').AsBoolean Then
    DmPrincipal.TbReceberBoi.Delete
  Else
    //Pagamento ja fora efetuado
    If Application.MessageBox('Este Pedido de Venda já fora pago(Contas à Receber) !!! '+Chr(13)+Chr(13)+'Deseja excluí-lo mesmo assim ? ',' Confirmação de exclusão no Contas à Receber',52) = id_Yes Then
      DmPrincipal.TbReceberBoi.Delete;

  // Apagar os itens do pedido de venda no Mov_Vendas
  TbAuxMov_Vendas.First;
  While not TbAuxMov_Vendas.EOF do
  Begin
    TbAuxMov_Vendas.Delete;
    TbAuxMov_Vendas.Next;
  End;
  // Apagar o Pedido de Venda no Vendas
  TbAuxVendas.Delete;
  DmPrincipal.TbReceberBoi.Active := False;
end;

procedure TFrmAlteraPedidoAcougue.Alterao2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmAlteraPedidoVendaBoi, FrmAlteraPedidoVendaBoi);
  If TbAuxMov_Vendas.EOF Then
    Application.MessageBox('Não há ítens a ser alterado !!! ',' Advertência ',48)
  Else
  Begin
    TbAuxMov_Vendas.Edit;
    FrmAlteraItensBoi.ShowModal;
    FrmAlteraItensBoi.Destroy;
  End;
end;

procedure TFrmAlteraPedidoAcougue.Inclusotens1Click(Sender: TObject);
begin
  TbAuxMov_Vendas.Insert;
  TbAuxMov_Vendas.Edit;
  Application.CreateForm(TFrmInclui_Itens_boi, FrmInclui_Itens_boi);
  FrmInclui_Itens_boi.ShowModal;
  FrmInclui_Itens_boi.Destroy;
end;

procedure TFrmAlteraPedidoAcougue.Excluso3Click(Sender: TObject);
Var nTotal: Real;
begin
  If TbAuxMov_Vendas.IsEmpty Then
    Application.MessageBox('Não há nenhum ítem a ser excluído !!! ',' Advertência ',48)
  Else
    If Application.MessageBox('Deseja realmente excluir este ítem ? ',' Confirmação de exclusão ',36) = id_Yes Then
    Begin
      TbAuxMov_Vendas.Delete;
      TbAuxMov_Vendas.First;
      nTotal := 0;
      While not TbAuxMov_Vendas.EOF do
      Begin
        nTotal := nTotal + TbAuxMov_VendasTotal.AsFloat;
        TbAuxMov_Vendas.Next;
      end;
      TbAuxVendas.Edit;
      TbAuxVendas.FieldByName('Total').AsFloat := nTotal;
      TbAuxVendas.Post;
      // Alteracao no Contas a Receber
      FrmAlteraItensBoi.Grava_no_Contas_a_Receber(nTotal);
    End;
end;

end.
