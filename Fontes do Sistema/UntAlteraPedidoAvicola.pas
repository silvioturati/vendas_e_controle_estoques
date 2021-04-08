unit UntAlteraPedidoAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, ExtCtrls, Buttons, Db, DBTables, Menus;

type
  TFrmAlteraPedidoAvicola = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    RadioGroup1: TRadioGroup;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    DBGrid2: TDBGrid;
    GroupBox3: TGroupBox;
    DBGrid3: TDBGrid;
    DsAuxVendas: TDataSource;
    TbAuxVendas: TTable;
    DsAuxMov_Vendas: TDataSource;
    TbAuxMov_Vendas: TTable;
    TbAuxMov_VendasVenda_Nr: TIntegerField;
    TbAuxMov_VendasCod_Prod: TIntegerField;
    TbAuxMov_VendasQtde: TFloatField;
    TbAuxMov_VendasUnitario: TCurrencyField;
    TbAuxMov_VendasDescricao: TStringField;
    TbAuxMov_VendasUnidade: TStringField;
    TbAuxMov_VendasTotal: TCurrencyField;
    PopupMenuVendas: TPopupMenu;
    MnAlteracao1: TMenuItem;
    N1: TMenuItem;
    MnExclusao1: TMenuItem;
    PopupMenuMov_Vendas: TPopupMenu;
    Alterao2: TMenuItem;
    Excluso2: TMenuItem;
    Excluso3: TMenuItem;
    Inclusotens1: TMenuItem;
    N2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TbAuxMov_VendasCalcFields(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure Alterao2Click(Sender: TObject);
    procedure Inclusotens1Click(Sender: TObject);
    procedure Excluso3Click(Sender: TObject);
    procedure MnExclusao1Click(Sender: TObject);
    procedure MnAlteracao1Click(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlteraPedidoAvicola: TFrmAlteraPedidoAvicola;

implementation

uses UntDataModulo, UntPesqCadCli, UntAlteraPedidoVendaFra, UntAlteraItensFra,
  UntIncluiItensFra;

{$R *.DFM}

procedure TFrmAlteraPedidoAvicola.FormShow(Sender: TObject);
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
  Begin
    DmPrincipal.TbClientes.IndexName := 'Cli_Apel';
    DbGrid1.Columns[0].Title.Caption := 'Nome Fantasia';
    DbGrid1.Columns[0].FieldName := 'Fantasia';
    DbGrid1.Columns[1].Title.Caption := 'Razão Social';
    DbGrid1.Columns[1].FieldName := 'Razao';
  End;
end;

procedure TFrmAlteraPedidoAvicola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TbClientes.Active   := False;
  TbAuxVendas.Active     := False;
  TbAuxMov_Vendas.Active := False;
  DmPrincipal.TbClientes.IndexName := '';
end;

procedure TFrmAlteraPedidoAvicola.TbAuxMov_VendasCalcFields(DataSet: TDataSet);
begin
  TbAuxMov_VendasTotal.AsCurrency := TbAuxMov_VendasUnitario.AsCurrency * TbAuxMov_VendasQtde.AsCurrency;
end;

procedure TFrmAlteraPedidoAvicola.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmPesqCadCli, frmPesqCadCli);
  FrmPesqCadCli.ShowModal;
  FrmPesqCadCli.Destroy;
end;

procedure TFrmAlteraPedidoAvicola.RadioGroup1Click(Sender: TObject);
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

procedure TFrmAlteraPedidoAvicola.DBGrid3DblClick(Sender: TObject);
begin
  TbAuxMov_Vendas.Edit;
  Application.CreateForm(TFrmAlteraItensFra, FrmAlteraItensFra);
  FrmAlteraItensFra.ShowModal;
  FrmAlteraItensFra.Destroy;
end;

procedure TFrmAlteraPedidoAvicola.Alterao2Click(Sender: TObject);
begin
  If TbAuxMov_Vendas.IsEmpty Then
    Application.MessageBox('Não há ítens a ser alterado !!! ',' Advertência ',48)
  Else
  Begin
    TbAuxMov_Vendas.Edit;
    Application.CreateForm(TFrmAlteraItensFra, FrmAlteraItensFra);
    FrmAlteraItensFra.ShowModal;
    FrmAlteraItensFra.Destroy;
  End;
end;

procedure TFrmAlteraPedidoAvicola.Inclusotens1Click(Sender: TObject);
begin
  TbAuxMov_Vendas.Insert;
  Application.CreateForm(TFrmInclui_Itens_Fra, FrmInclui_Itens_Fra);
  FrmInclui_Itens_Fra.ShowModal;
  FrmInclui_Itens_Fra.Destroy;
end;

procedure TFrmAlteraPedidoAvicola.Excluso3Click(Sender: TObject);
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
      FrmAlteraItensFra.Grava_no_Contas_a_Receber(nTotal);
    End;
end;

procedure TFrmAlteraPedidoAvicola.MnExclusao1Click(Sender: TObject);
begin
  If TbAuxVendas.IsEmpty Then
  Begin
    Application.MessageBox('Não há nenhum Pedido de Venda a ser alterado !!! ',' Advertência ',48);
    Exit;
  End;
  // Apagar o pedido de Venda no Contas a Receber
  If Application.MessageBox('Tem certeza que deseja apagar este Pedido de Venda ? '+Chr(13)+Chr(13)+' Esta operação apagará este Pedido no Contas a Receber também ',' Confirmação de exclusão ',52) = id_no Then
    Exit;

  DmPrincipal.TbReceberFra.Active := True;
  If not DmPrincipal.TbReceberFra.FindKey([TbAuxVendas.FieldByName('Codigo').AsInteger,TbAuxVendas.FieldByName('Venda_Nr').AsInteger]) Then
  Begin
    Application.MessageBox('Pedido de Venda não encontrado no Contas à Receber !!! '+CHR(13)+CHR(13)+'            V e r i f i q u e   !!!  ',' Erro de regravação ',mb_Ok+Mb_IconError);
    Exit;
  End;

  If not DmPrincipal.TbReceberFra.FieldByName('Pago').AsBoolean Then
    DmPrincipal.TbReceberFra.Delete
  Else
    //Pagamento ja fora efetuado
    If Application.MessageBox('Este Pedido de Venda já fora pago(Contas à Receber) !!! '+Chr(13)+Chr(13)+'Deseja excluí-lo mesmo assim ? ',' Confirmação de exclusão no Contas à Receber',52) = id_Yes Then
      DmPrincipal.TbReceberFra.Delete;

  // Apagar os itens do pedido de venda no Mov_Vendas
  TbAuxMov_Vendas.First;
  While not TbAuxMov_Vendas.EOF do
  Begin
    TbAuxMov_Vendas.Delete;
    TbAuxMov_Vendas.Next;
  End;
  // Apagar o Pedido de Venda no Vendas
  TbAuxVendas.Delete;
  DmPrincipal.TbReceberFra.Active := False;
End;

procedure TFrmAlteraPedidoAvicola.MnAlteracao1Click(Sender: TObject);
begin
  If TbAuxVendas.IsEmpty Then
    Application.MessageBox('Não há nenhum Pedido de Venda a ser alterado !!! ',' Advertência ',48)
  Else
    Application.CreateForm(TFrmAlteraPedidoVendaFra, FrmAlteraPedidoVendaFra);
    FrmAlteraPedidoVendaFra.ShowModal;
    FrmAlteraPedidoVendaFra.Destroy;
end;

procedure TFrmAlteraPedidoAvicola.DBGrid2DblClick(Sender: TObject);
begin
  If TbAuxVendas.IsEmpty Then
    Application.MessageBox('Não há nenhum Pedido de Venda a ser alterado !!! ',' Advertência ',48)
  Else
  Begin
    Application.CreateForm(TFrmAlteraPedidoVendaFra, FrmAlteraPedidoVendaFra);
    FrmAlteraPedidoVendaFra.ShowModal;
    FrmAlteraPedidoVendaFra.Destroy;
  End;
end;
end.
