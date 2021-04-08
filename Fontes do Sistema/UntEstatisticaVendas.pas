unit UntEstatisticaVendas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls, Mask, ExtCtrls, Buttons;

type
  TFrmEstatisticaVendas = class(TForm)
    DsProdutos: TDataSource;
    TbProdutos: TTable;
    DsVendas: TDataSource;
    TbVendas: TTable;
    DsMov_Vendas: TDataSource;
    TbMov_Vendas: TTable;
    DsAux_Temp: TDataSource;
    TbAux_Temp: TTable;
    GroupBox1: TGroupBox;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Bevel1: TBevel;
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEstatisticaVendas: TFrmEstatisticaVendas;

implementation

{$R *.DFM}
procedure TFrmEstatisticaVendas.BitBtn2Click(Sender: TObject);
begin
  TbProdutos.Active    := True;
  TbVendas.Active      := True;
  TbMov_Vendas.Active  := True;
  TbAux_Temp.Exclusive := True;
  TbAux_Temp.Active    := True;
  TbAux_Temp.EmptyTable;
  TbVendas.FindNearest([MaskEdit1.Text]);
  While (TbVendas.FieldByName('Data').AsDateTime >= StrToDate(MaskEdit1.Text)) AND (TbVendas.FieldByName('Data').AsDateTime <= StrToDate(MaskEdit2.Text)) do
  begin
    TbMov_Vendas.FindKey([TbVendas.FieldByName('Venda_Nr').AsString]);
    While TbMov_Vendas.FieldByName('Venda_Nr').AsString = TbVendas.FieldByName('Venda_Nr').AsString do
    begin
      TbProdutos.FindKey([TbMov_Vendas.FieldByName('Cod_Prod').AsString]);
      If TbAux_Temp.FindKey([TbMov_Vendas.FieldByName('Cod_Prod').AsString]) Then
        TbAux_Temp.Edit
      Else
        TbAux_Temp.Insert;

      TbAux_Temp.FieldByName('Cod_Prod').AsString  := TbMov_Vendas.FieldByName('Cod_Prod').AsString;
      TbAux_Temp.FieldByName('Descricao').AsString := TbProdutos.FieldByName('Descricao').AsString;
      TbAux_Temp.FieldByName('Unidade').AsString   := TbProdutos.FieldByName('Unidade').AsString;
      TbAux_Temp.FieldByName('Qtde').AsFloat := TbAux_Temp.FieldByName('Qtde').AsFloat + TbMov_Vendas.FieldByName('Qtde').AsFloat;
      TbAux_Temp.FieldByName('Total').AsFloat := TbAux_Temp.FieldByName('Total').AsFloat + (TbMov_Vendas.FieldByName('Qtde').AsFloat * TbMov_Vendas.FieldByName('Unitario').AsFloat);
      TbAux_Temp.FieldByName('Data').AsDateTime := TbVendas.FieldByName('Data').AsDateTime;
      TbAux_Temp.Post;
      TbMov_Vendas.Next;
    end;
    TbVendas.Next;
  end;
  TbProdutos.Active    := False;
  TbVendas.Active      := False;
  TbMov_Vendas.Active  := False;
end;

end.
