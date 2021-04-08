unit UntCriaTabelas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBTables;

type
  TFrmCriaTabela = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    Table1: TTable;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCriaTabela: TFrmCriaTabela;

implementation

{$R *.DFM}

procedure TFrmCriaTabela.BtnOkClick(Sender: TObject);
Var NewTable: TTable;
Begin
  If Edit1.Text <> 'vale' Then
  Begin
    Application.MessageBox('Senha não confere !!!','Senha Incorreta',64);
    Edit1.SetFocus;
  End
  Else
  Begin
    If not FileExists('\SCIT_fa2001\Tabelas2001\Clientes.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'Clientes';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Codigo'     ,ftInteger,0,True);
          Add('Razao'      ,ftString,50,True);
          Add('Tipo'       ,ftString,01,True);
          Add('Fantasia'   ,ftString,50,True);
          Add('Data'       ,ftDate,0,False);
          Add('CGC'        ,ftString,18,False);
          Add('IE'         ,ftString,15,False);
          Add('CPF'        ,ftString,14,False);
          Add('RG'         ,ftString,13,False);
          Add('Endereco'   ,ftString,50,False);
          Add('Bairro'     ,ftString,25,False);
          Add('Cidade'     ,ftString,25,False);
          Add('Estado'     ,ftString,02,False);
          Add('Cep'        ,ftString,10,False);
          Add('Telefone'   ,ftString,18,False);
          Add('Fax'        ,ftString,18,False);
          Add('Obs'        ,ftString,255,False);
          Add('NomeProp'   ,ftString,50,False);
          Add('DataNasc'   ,ftDate,0,False);
          Add('RGProp'     ,ftString,13,False);
          Add('CICProp'    ,ftString,14,False);
          Add('Pai'        ,ftString,50,False);
          Add('Mae'        ,ftString,50,False);
          Add('EndProp'    ,ftString,50,False);
          Add('CEPProp'    ,ftString,10,False);
          Add('BairroProp' ,ftString,25,False);
          Add('CidProp'    ,ftString,25,False);
          Add('EstProp'    ,ftString,02,False);
          Add('TelProp'    ,ftString,18,False);
          Add('FaxProp'    ,ftString,18,False);
          Add('email'      ,ftString,50,False);
          Add('loja1'      ,ftString,20,False);
          Add('loja2'      ,ftString,20,False);
          Add('Banco1'     ,ftString,20,False);
          Add('Banco2'     ,ftString,20,False);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Codigo',[ixPrimary,ixUnique]);
          Add('Cli_Nome','Razao',[ixCaseInsensitive]);
          Add('Cli_Apel','Fantasia',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\ProdutosFra.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'ProdutosFra';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Codigo'     ,ftInteger,0,True);
          Add('Descricao'  ,ftString,30,True);
          Add('Unidade'    ,ftString,02,False);
          Add('Valor_AV'   ,ftCurrency,0,False); // Valor a Vista
          Add('Valor_AP'   ,ftCurrency,0,False); // Valor a Prazo
          Add('Valor_BA'   ,ftCurrency,0,False); // Valor Balcao
          Add('Valor_TR'   ,ftCurrency,0,False); // Valor Transferência
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Codigo',[ixPrimary,ixUnique]);
          Add('Pro_DescFra','Descricao',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\ProdutosBoi.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'ProdutosBoi';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Codigo'     ,ftInteger,0,True);
          Add('Descricao'  ,ftString,30,True);
          Add('Unidade'    ,ftString,02,False);
          Add('Valor_AV'   ,ftCurrency,0,False); // Valor a Vista
          Add('Valor_AP'   ,ftCurrency,0,False); // Valor a Prazo
          Add('Valor_BA'   ,ftCurrency,0,False); // Valor Balcao
          Add('Valor_TR'   ,ftCurrency,0,False); // Valor Transferência
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Codigo',[ixPrimary,ixUnique]);
          Add('Pro_DescBoi','Descricao',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\VendasFra.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'VendasFra';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Venda_Nr'   ,ftInteger,0,True);
          Add('Codigo'     ,ftInteger,0,True);
          Add('Data'       ,ftDate,0,True);
          Add('Total'      ,ftCurrency,0,False);
          Add('Tp_Venda'   ,ftString,30,False);
          Add('Porc_Desc'  ,ftFloat,0,False);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Venda_Nr',[ixPrimary,ixUnique]);
          Add('VendasFra_Cod','Codigo;Data',[ixCaseInsensitive]);
          Add('VendasFra_Dat','Data',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\VendasBoi.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'VendasBoi';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Venda_Nr'   ,ftInteger,0,True);
          Add('Codigo'     ,ftInteger,0,True);
          Add('Data'       ,ftDate,0,True);
          Add('Total'      ,ftCurrency,0,False);
          Add('Tp_Venda'   ,ftString,30,False);
          Add('Porc_Desc'  ,ftFloat,0,False);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Venda_Nr',[ixPrimary,ixUnique]);
          Add('VendasBoi_Cod','Codigo;Data',[ixCaseInsensitive]);
          Add('VendasBoi_Dat','Data',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\Mov_VendasFra.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'Mov_VendasFra';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Venda_Nr'     ,ftInteger,0,True);
          Add('Cod_Prod'     ,ftInteger,0,True);
          Add('Qtde'         ,ftFloat,0,True);
          Add('Unitario'     ,ftCurrency,0,True);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Venda_Nr;Cod_Prod;Qtde;Unitario',[ixPrimary,ixUnique]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\Mov_VendasBoi.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'Mov_VendasBoi';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Venda_Nr'     ,ftInteger,0,True);
          Add('Cod_Prod'     ,ftInteger,0,True);
          Add('Qtde'         ,ftFloat,0,True);
          Add('Unitario'     ,ftCurrency,0,True);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Venda_Nr;Cod_Prod;Qtde;Unitario',[ixPrimary,ixUnique]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\ReceberFra.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'ReceberFra';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Codigo'   ,ftInteger,0,True);
          Add('Venda_Nr' ,ftInteger,0,True);
          Add('D_C'      ,FtString,1,True); // Aceita 'D' => Devolucao ou 'V' => Vendas
          Add('Data'     ,ftDate,0,True);
          Add('Total'    ,ftCurrency,0,True);
          Add('Data_Pgto',ftDate,0,False);
          Add('Pago'     ,FtString,2,False);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Codigo;Venda_Nr;D_C',[ixPrimary,ixUnique]);
          Add('RecFra_Cli','Codigo;Data',[ixCaseInsensitive]);
          Add('RecFra_Dat','Data;Codigo',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\ReceberBoi.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'ReceberBoi';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Codigo'   ,ftInteger,0,True);
          Add('Venda_Nr' ,ftInteger,0,True);
          Add('D_C'      ,FtString,1,True); // Aceita 'D' => Devolucao ou 'V' => Vendas
          Add('Data'     ,ftDate,0,True);
          Add('Total'    ,ftCurrency,0,True);
          Add('Data_Pgto',ftDate,0,False);
          Add('Pago'     ,FtString,2,False);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Codigo;Venda_Nr;D_C',[ixPrimary,ixUnique]);
          Add('RecBoi_Cli','Codigo;Data',[ixCaseInsensitive]);
          Add('RecBoi_Dat','Data;Codigo',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\DevolucaoFra.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'DevolucaoFra';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Dev_Nr',ftInteger,0,True);
          Add('Codigo',ftInteger,0,True);
          Add('Data'  ,ftDate,0,False);
          Add('Total' ,ftCurrency,0,False);
        End           ;
        With IndexDefs do
        Begin
          Clear;
          Add('','Dev_Nr',[ixPrimary,ixUnique]);
          Add('Codigo_DevFra','Codigo;Dev_Nr',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\DevolucaoBoi.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'DevolucaoBoi';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Dev_Nr',ftInteger,0,True);
          Add('Codigo',ftInteger,0,True);
          Add('Data'  ,ftDate,0,False);
          Add('Total' ,ftCurrency,0,False);
        End           ;
        With IndexDefs do
        Begin
          Clear;
          Add('','Dev_Nr',[ixPrimary,ixUnique]);
          Add('Codigo_DevBoi','Codigo;Dev_Nr',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\Mov_DevFra.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'Mov_DevFra';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Dev_Nr',ftInteger,0,True);
          Add('Cod_Prod',ftInteger,0,True);
          Add('Qtde'    ,ftFloat,0,True);
          Add('Unitario',ftCurrency,0,True);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Dev_Nr;Cod_Prod;Qtde;Unitario',[ixPrimary,ixUnique]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\Mov_DevBoi.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'Mov_DevBoi';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Dev_Nr',ftInteger,0,True);
          Add('Cod_Prod',ftInteger,0,True);
          Add('Qtde'    ,ftFloat,0,True);
          Add('Unitario',ftCurrency,0,True);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Dev_Nr;Cod_Prod;Qtde;Unitario',[ixPrimary,ixUnique]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\Aux_Temp.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'Aux_Temp';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Cod_Prod'     ,ftInteger,0,True);
          Add('Descricao'    ,ftString,50,True);
          Add('Unidade'      ,ftString,02,True);
          Add('Qtde'         ,ftFloat,0,False);
          Add('Total'        ,ftCurrency,0,False);
          Add('Data'         ,ftDate,0,False)
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Cod_Prod',[ixPrimary,ixUnique]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\Requisicao.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'Requisicao';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Nr_requisicao' ,ftInteger,0,True);
          Add('Data'          ,ftDate,0,True);
          Add('Nome_Posto'    ,ftString,25,True);
          Add('Nome_mot'      ,ftstring,25,True);
          Add('Placa'         ,ftstring,7,True);
          Add('QTDE'          ,ftInteger,0,true);
          Add('Responsavel'   ,ftString,25,False);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Nr_requisicao',[ixPrimary,ixUnique]);
          Add('Req_data','Data',[ixCaseInsensitive]);
          Add('Req_placa','Placa',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\Veiculos.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'Veiculos';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Placa'         ,ftString,7,True);
          Add('Descricao'     ,ftString,25,True);
          Add('Ano'           ,ftString,4,False);
          Add('Cor'           ,ftstring,15,True);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Placa',[ixPrimary,ixUnique]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\Manutencao.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'Manutencao';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Manutencao_nr' ,ftInteger,0,True);
          Add('Placa'         ,ftString,7,True);
          Add('Prestador_Ser' ,ftString,20,False);
          Add('Revenda_Pecas' ,ftString,20,False);
          Add('Serico_presta' ,ftString,256,False);
          Add('Pecas_Trocada' ,ftString,256,False);
          Add('Valor_Servico' ,ftCurrency,0,True);
          Add('Valor_pecas'   ,ftCurrency,0,True);
          Add('Data'          ,ftDate,0,True);
          Add('Garantia_peca' ,ftDate,0,True);
          Add('Garantia_Serv' ,ftDate,0,True);
          Add('Responsavel'   ,ftString,15,True);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Manutencao_nr',[ixPrimary,ixUnique]);
          Add('Placa_Manu','Placa',[ixCaseInsensitive]);
          Add('Placa_data','Data;Placa',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

    If not FileExists('\SCIT_fa2001\Tabelas2001\Prestadora.DB') then
    Begin
      NewTable := TTable.Create(Owner);
      With NewTable do
      Begin
        Active:= False;
        DataBaseName:= 'Atacado2001';
        TableName:= 'Prestadora';
        TableType:= ttParadox;
        With FieldDefs do
        Begin
          Clear;
          Add('Cod_pres'     ,ftInteger,0,True);
          Add('Prestadora'   ,ftString,50,True);
          Add('Endereco'     ,ftString,50,False);
          Add('Telefone'     ,ftString,18,False);
          Add('Celular'      ,ftString,18,False);
          Add('FAX'          ,ftString,18,False);
          Add('Respons1'     ,ftString,30,False); //Responsavél pela prestadora
          Add('Respons2'     ,ftString,30,False);
          Add('Ramo'         ,ftString,15,False);
        End;
        With IndexDefs do
        Begin
          Clear;
          Add('','Cod_pres',[ixPrimary,ixUnique]);
          Add('Presta','Prestadora',[ixCaseInsensitive]);
        end;
      end;
      NewTable.CreateTable;
      NewTable.Destroy;
    end;

  end;
end;

procedure TFrmCriaTabela.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
