unit UntCriaBasedeDados;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Table1: TTable;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
Var NewTable: TTable;
Begin
  If Edit1.Text <> 'advogados' Then
  Begin
    Application.MessageBox('Senha não confere !!!','Senha Incorreta',64);
    Edit1.SetFocus;
  End
  Else
  Begin
    If not FileExists('\bancodedados\Clientes.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'advogados';
        TableName:= 'Clientes';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Codcli'         ,ftInteger,0,True);
          Add('Dtacadcli'      ,ftDate,0,True);
          Add('Nomecli'        ,ftString,50,True);
          Add('Endcli'         ,ftString,50,False);
          Add('Bairrocli'      ,ftString,30,False);
          Add('CEPCLI'         ,ftString,12,False);
          Add('Cidadecli'      ,ftString,30,False);
          Add('Estadocli'      ,ftString,02,False);
          Add('RGcli'          ,ftString,14,False);
          Add('CICcli'         ,ftString,14,False);
          Add('IEcli'          ,ftString,15,False);
          Add('CGCcli'         ,ftString,18,False);
          Add('Dtanasccli'     ,ftString,10,False);
          Add('Idadecli'       ,ftInteger,0,False);
          Add('Endclicom'      ,ftString,50,False);
          Add('Bairroclicom'   ,ftString,30,False);
          Add('CEPclicom'      ,ftString,12,False);
          Add('Cidadeclicom'   ,ftString,30,False);
          Add('Estadoclicom'   ,ftString,02,False);
          Add('Empresacli'     ,ftString,50,False);
          Add('Reucli'         ,ftString,03,False);
          Add('Tipocli'        ,ftString,01,False);
          Add('Situacaocli'    ,ftString,01,False);
          Add('Telcli'         ,ftString,13,False);
          Add('Telclicom'      ,ftString,13,False);

          Add('Nomepart'        ,ftString,50,True);
          Add('Endpart'         ,ftString,50,False);
          Add('Bairropart'      ,ftString,30,False);
          Add('CEPpart'         ,ftString,12,False);
          Add('Cidadepart'      ,ftString,30,False);
          Add('Estadopart'      ,ftString,02,False);
          Add('RGpart'          ,ftString,14,False);
          Add('CICpart'         ,ftString,14,False);
          Add('IEpart'          ,ftString,15,False);
          Add('CGCpart'         ,ftString,18,False);
          Add('Dtanascpart'     ,ftString,10,False);
          Add('Idadepart'       ,ftInteger,0,False);
          Add('Endpartcom'      ,ftString,50,False);
          Add('Bairropartcom'   ,ftString,30,False);
          Add('CEPpartcom'      ,ftString,12,False);
          Add('Cidadepartcom'   ,ftString,30,False);
          Add('Estadopartcom'   ,ftString,02,False);
          Add('Empresapart'     ,ftString,50,False);
          Add('Tipopart'           ,ftString,01,False);
          Add('Situacaopart'       ,ftString,01,False);
          Add('Telpart'         ,ftString,13,False);
          Add('Telpartcom'      ,ftString,13,False);

          Add('Processo'      ,ftString,15,False);
          Add('Vara'          ,ftString,3,False);
          Add('Oficio'        ,ftString,3,False);
          Add('CidadeProc'    ,ftString,50,False);
          Add('EstadoProc'    ,ftString,02,False);
          Add('Acao'          ,ftString,120,False);
          Add('Natureza'      ,ftString,30,False);
          Add('DtaInicioProc' ,ftString,10,False);
          Add('DtaFimProc'    ,ftString,10,False);
          Add('Honorario'     ,ftString,14,False);
          Add('Dativo'        ,ftString,03,False);
          Add('Juizo'         ,ftString,15,False);
          Add('Andamento'     ,ftMemo,240,False);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Codcli',[ixPrimary,ixUnique]);
          Add('Index_Nomecli','Nomecli',[ixCaseInsensitive]);
          Add('Index_NomePart','NomePart',[ixCaseInsensitive]);
          Add('Index_Processo','Processo',[ixCaseInsensitive]);
          Add('Index_Acao','Acao',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\bancodedados\Receber.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'advogados';
        TableName:= 'Receber';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Codrec'         ,ftInteger,0,True);
          Add('Dtavencto'      ,ftDate,0,True);
          Add('Valor'          ,ftString,14,True);
          Add('Descricao'      ,ftString,254,False);
          Add('OBS'            ,ftString,254,False);
          Add('Pago'           ,ftString,3,False);
          Add('Dtapagto'       ,ftString,10,False);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Codrec',[ixPrimary,ixUnique]);
          Add('Index_Dtavencto','Dtavencto',[ixCaseInsensitive]);
          Add('Index_Descricao','Descricao',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\bancodedados\Pagar.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'advogados';
        TableName:= 'Pagar';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Codpag'         ,ftInteger,0,True);
          Add('Dtavencto'      ,ftDate,0,True);
          Add('Valor'          ,ftString,14,True);
          Add('Descricao'      ,ftString,254,False);
          Add('OBS'            ,ftString,254,False);
          Add('Pago'           ,ftString,3,False);
          Add('Dtapagto'       ,ftString,10,False);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Codpag',[ixPrimary,ixUnique]);
          Add('Index_Dtavencto','Dtavencto',[ixCaseInsensitive]);
          Add('Index_Descricao','Descricao',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

end.



