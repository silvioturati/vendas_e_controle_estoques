unit UntExcluiAlteraRequisicoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, Grids, DBGrids, Db, DBTables;

type
  TFrmExcluiAlteraRequisicoes = class(TForm)
    DsRequisicao: TDataSource;
    TbRequisicao: TTable;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExcluiAlteraRequisicoes: TFrmExcluiAlteraRequisicoes;

implementation

{$R *.DFM}

procedure TFrmExcluiAlteraRequisicoes.FormShow(Sender: TObject);
begin
  TbRequisicao.Active := True;
end;

procedure TFrmExcluiAlteraRequisicoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TbRequisicao.Active := False;
end;

end.
