unit UntDataModulo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDmPrincipal = class(TDataModule)
    DsProdutosBoi: TDataSource;
    TbProdutosBoi: TTable;
    DsMov_VendasBoi: TDataSource;
    TbMov_VendasBoi: TTable;
    DsVendasBoi: TDataSource;
    TbVendasBoi: TTable;
    TbMov_VendasBoiVenda_Nr: TIntegerField;
    TbMov_VendasBoiCod_Prod: TIntegerField;
    TbMov_VendasBoiUnitario: TCurrencyField;
    TbMov_VendasBoiQtde: TFloatField;
    TbMov_VendasBoiDescricao: TStringField;
    DsReceberBoi: TDataSource;
    TbReceberBoi: TTable;
    TbMov_VendasBoiTotal: TCurrencyField;
    TbMov_VendasBoiUnidade: TStringField;
    DsDevolucaoBoi: TDataSource;
    TbDevolucaoBoi: TTable;
    DsMov_DevBoi: TDataSource;
    TbMov_DevBoi: TTable;
    TbMov_DevBoiDev_Nr: TIntegerField;
    TbMov_DevBoiCod_Prod: TIntegerField;
    TbMov_DevBoiQtde: TFloatField;
    TbMov_DevBoiUnitario: TCurrencyField;
    TbMov_DevBoiDescricao: TStringField;
    TbMov_DevBoiTotal: TCurrencyField;
    TbMov_DevBoiUnidade: TStringField;
    TBClientes: TTable;
    DSClientes: TDataSource;
    TbProdutosFra: TTable;
    DsProdutosFra: TDataSource;
    TbReceberFra: TTable;
    DsReceberFra: TDataSource;
    TbVendasFra: TTable;
    DsVendasFra: TDataSource;
    TbMov_VendasFra: TTable;
    DsMov_VendasFra: TDataSource;
    TbDevolucaoFra: TTable;
    DsDevolucaoFra: TDataSource;
    TbMov_DevFra: TTable;
    DsMov_DevFra: TDataSource;
    TbRequisicao: TTable;
    DsRequisicao: TDataSource;
    TbManutencao: TTable;
    DsManutencao: TDataSource;
    TbMov_VendasFraVenda_Nr: TIntegerField;
    TbMov_VendasFraCod_Prod: TIntegerField;
    TbMov_VendasFraQtde: TFloatField;
    TbMov_VendasFraUnitario: TCurrencyField;
    TbMov_VendasFraDescricao: TStringField;
    TbMov_VendasFraUnidade: TStringField;
    TbMov_VendasFraTotal: TCurrencyField;
    TbProdutosBoiCodigo: TIntegerField;
    TbProdutosBoiDescricao: TStringField;
    TbProdutosBoiUnidade: TStringField;
    TbProdutosBoiValor_AV: TCurrencyField;
    TbProdutosBoiValor_AP: TCurrencyField;
    TbProdutosBoiValor_BA: TCurrencyField;
    TbProdutosBoiValor_TR: TCurrencyField;
    TbProdutosFraCodigo: TIntegerField;
    TbProdutosFraDescricao: TStringField;
    TbProdutosFraUnidade: TStringField;
    TbProdutosFraValor_AV: TCurrencyField;
    TbProdutosFraValor_AP: TCurrencyField;
    TbProdutosFraValor_BA: TCurrencyField;
    TbProdutosFraValor_TR: TCurrencyField;
    TbVeiculos: TTable;
    TbPrestadora: TTable;
    DSVeiculos: TDataSource;
    DsPrestadora: TDataSource;
    TbMov_DevFraDev_Nr: TIntegerField;
    TbMov_DevFraCod_Prod: TIntegerField;
    TbMov_DevFraQtde: TFloatField;
    TbMov_DevFraUnitario: TCurrencyField;
    TbMov_DevFraDescricao: TStringField;
    TbMov_DevFratotal: TCurrencyField;
    TbMov_DevFraUnidade: TStringField;
    procedure TbMov_VendasFraCalcFields(DataSet: TDataSet);
    procedure TbMov_DevFraCalcFields(DataSet: TDataSet);
    procedure TbMov_VendasBoiCalcFields(DataSet: TDataSet);
    procedure TbMov_DevBoiCalcFields(DataSet: TDataSet);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmPrincipal: TDmPrincipal;

implementation

uses UntRelatorioSinteseDevolucaoAvicola, UntQRRelatorioSinteseDevolucaoAvicola;

{$R *.DFM}

procedure TDmPrincipal.TbMov_VendasBoiCalcFields(DataSet: TDataSet);
begin
  DmPrincipal.TbMov_VendasBoiTotal.AsCurrency := DmPrincipal.TbMov_VendasBoi.FieldByName('Unitario').AsFloat * DmPrincipal.TbMov_VendasBoi.FieldByName('Qtde').AsCurrency;
end;

procedure TDmPrincipal.TbMov_DevBoiCalcFields(DataSet: TDataSet);
begin
  DmPrincipal.TbMov_DevBoiTotal.AsCurrency := DmPrincipal.TbMov_DevBoi.FieldByName('Unitario').AsFloat * DmPrincipal.TbMov_DevBoi.FieldByName('Qtde').AsCurrency;
end;

procedure TDmPrincipal.TbMov_VendasFraCalcFields(DataSet: TDataSet);
begin
  DmPrincipal.TbMov_VendasFraTotal.AsCurrency := DmPrincipal.TbMov_VendasFra.FieldByName('Unitario').AsFloat * DmPrincipal.TbMov_VendasFra.FieldByName('Qtde').AsCurrency;
end;

procedure TDmPrincipal.TbMov_DevFraCalcFields(DataSet: TDataSet);
begin
  DmPrincipal.TbMov_DevFraTotal.AsCurrency := DmPrincipal.TbMov_DevFra.FieldByName('Unitario').AsFloat * DmPrincipal.TbMov_DevFra.FieldByName('Qtde').AsCurrency;
end;

end.
