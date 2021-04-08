unit UntConf_Itens_Fra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls;

type
  TFrmConf_Itens_Fra = class(TForm)
    GroupBox1: TGroupBox;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Label6: TLabel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel2: TBevel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Edit1: TEdit;
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure DBEdit4Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConf_Itens_Fra: TFrmConf_Itens_Fra;

implementation

uses UntDataModulo, UntPedidoAvicola, UntPesqCadCli;

{$R *.DFM}

procedure TFrmConf_Itens_Fra.FormShow(Sender: TObject);
begin
  Edit2.Text := '0';
  DbEdit4.Field.Value := 0;
  Case RadioGroup1.ItemIndex of
    0: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_BA').AsString;
    1: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_AP').AsString;
    2: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_TR').AsString;
  end;
end;

procedure TFrmConf_Itens_Fra.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
    0: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_BA').AsString;
    1: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_AP').AsString;
    2: Edit1.Text := DmPrincipal.TbProdutosFra.FieldByName('Valor_TR').AsString;
  end;
end;
procedure TFrmConf_Itens_Fra.DBEdit4Exit(Sender: TObject);
begin
  Edit2.Text := FormatCurr('###,###,##0.00',StrToCurr(StrToFloat(Edit1.Text) * DbEdit4.Field.Value));
end;

procedure TFrmConf_Itens_Fra.BitBtn1Click(Sender: TObject);
begin
  DmPrincipal.TbMov_VendasFra.FieldByName('Unitario').AsFloat := StrToFloat(Edit1.Text);
  DmPrincipal.TbMov_VendasFra.Post;
end;

procedure TFrmConf_Itens_Fra.BitBtn2Click(Sender: TObject);
begin
  DmPrincipal.TbMov_VendasFra.Cancel;
end;

procedure TFrmConf_Itens_Fra.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var nTotal: Currency;
begin
  DmPrincipal.TbMov_VendasFra.First;
  nTotal := 0;
  While Not DmPrincipal.TbMov_VendasFra.EOF do
  Begin
    nTotal := nTotal + DmPrincipal.TbMov_VendasFraTotal.AsCurrency;
    DmPrincipal.TbMov_VendasFra.Next;
  End;
  FrmPedidoAvicola.Edit2.Text := FormatCurr('###,###,###,##0.00',nTotal);
end;
end.
