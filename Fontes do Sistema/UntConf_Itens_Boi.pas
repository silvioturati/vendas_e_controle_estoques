unit UntConf_Itens_Boi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls;

type
  TFrmConf_Itens_Boi = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    Bevel1: TBevel;
    Edit2: TEdit;
    Label6: TLabel;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure DBEdit4Exit(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConf_Itens_Boi: TFrmConf_Itens_Boi;

implementation

uses UntDataModulo, UntPedidoAcougue;

{$R *.DFM}

procedure TFrmConf_Itens_Boi.DBEdit4Exit(Sender: TObject);
begin
  Edit2.Text := FormatCurr('###,###,##0.00',StrToCurr(StrToFloat(Edit1.Text) * DbEdit4.Field.Value));
end;

procedure TFrmConf_Itens_Boi.RadioGroup1Click(Sender: TObject);
begin
  Case RadioGroup1.ItemIndex of
    0: Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_BA').AsString;
    1: Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_AP').AsString;
    2: Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_TR').AsString;
  end;
end;

procedure TFrmConf_Itens_Boi.BitBtn1Click(Sender: TObject);
begin
  DmPrincipal.TbMov_VendasBoi.FieldByName('Unitario').AsFloat := StrToFloat(Edit1.Text);
  DmPrincipal.TbMov_VendasBoi.Post;
end;

procedure TFrmConf_Itens_Boi.BitBtn2Click(Sender: TObject);
begin
  DmPrincipal.TbMov_VendasBoi.Cancel;
end;

procedure TFrmConf_Itens_Boi.FormShow(Sender: TObject);
begin
  Edit2.Text := '0';
  DbEdit4.Field.Value := 0;
  Edit1.Text := DmPrincipal.TbProdutosBoi.FieldByName('Valor_Ba').AsString;
end;

procedure TFrmConf_Itens_Boi.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var nTotal: Currency;
begin
  DmPrincipal.TbMov_VendasBoi.First;
  nTotal := 0;
  While Not DmPrincipal.TbMov_VendasBoi.EOF do
  Begin
    nTotal := nTotal + DmPrincipal.TbMov_VendasBoiTotal.AsCurrency;
    DmPrincipal.TbMov_VendasBoi.Next;
  End;
  FrmPedidoAcougue.Edit2.Text := FormatCurr('###,###,###,##0.00',nTotal);
end;

end.
