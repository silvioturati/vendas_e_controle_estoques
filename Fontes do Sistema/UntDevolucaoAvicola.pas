unit UntDevolucaoAvicola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, Buttons, ComCtrls, DBCtrls, Mask, Menus,
  TcCombobox;

type
  TFrmDevolucaoAvicola = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MaskEdit1: TMaskEdit;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    DBGrid2: TDBGrid;
    GroupBox4: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox6: TGroupBox;
    Edit2: TEdit;
    PopupMenu2: TPopupMenu;
    CadastarProdutos1: TMenuItem;
    PopupMenu1: TPopupMenu;
    A1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Label4: TLabel;
    CompletingComboBox2: TCompletingComboBox;
    CompletingComboBox1: TCompletingComboBox;
    DBRichEdit1: TDBRichEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure CadastarProdutos1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Gera_Novo_Mov;
    procedure BitBtn2Click(Sender: TObject);
    procedure CompletingComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure CompletingComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure CompletingComboBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CompletingComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDevolucaoAvicola: TFrmDevolucaoAvicola;

implementation

uses UntDataModulo, UntPesqCadCli, UntConf_Itens_DevFra, UntCadProdFra,
  UntPesqCadProdFra, UntConf_Venda_Fra, UntConf_Itens_Fra,
  UntConfirmaDevolucaoAvicola;

{$R *.DFM}

Procedure TFrmDevolucaoAvicola.Gera_Novo_Mov;
begin
  MaskEdit1.Text := DateToStr(Date());
  DmPrincipal.TbDevolucaoFra.Last;
  Edit1.Text := IntToStr(DmPrincipal.TbDevolucaoFra.FieldByName('Dev_Nr').AsInteger + 1);
  GroupBox2.Visible := False;
  GroupBox3.Visible := False;
  GroupBox4.Visible := False;
  GroupBox6.Visible := False;
end;

procedure TFrmDevolucaoAvicola.FormShow(Sender: TObject);
begin
  DmPrincipal.TbProdutosfra.IndexFieldNames := 'Descricao';
  DmPrincipal.TbClientes.Active   := True;
  DmPrincipal.TbProdutosFra.Active   := True;
  DmPrincipal.TbDevolucaoFra.Active  := True;
  DmPrincipal.TbMov_DevFra.Active    := True;
  DmPrincipal.TbReceberFra.Active    := True;
  MaskEdit1.Text := DateToStr(Date());
  DmPrincipal.TbDevolucaoFra.Last;
  Edit1.Text := IntToStr(DmPrincipal.TbDevolucaoFra.FieldByName('Dev_Nr').AsInteger + 1);
  DmPrincipal.TBClientes.First;
  While not DmPrincipal.TbClientes.Eof do
  Begin
    CompletingComboBox2.Items.Add(DmPrincipal.TbClientes.FieldByName('Fantasia').AsString);
    DmPrincipal.TbClientes.Next;
  end;
  // Carregar o Completing combo box dos produtos
  DmPrincipal.TbProdutosFra.First;
  While not DmPrincipal.TbProdutosFra.Eof do
  Begin
    CompletingComboBox1.Items.Add(DmPrincipal.TbProdutosFra.FieldByName('Descricao').AsString);
    DmPrincipal.TbProdutosFra.Next;
  end;
  CompletingComboBox2.SetFocus;
end;

procedure TFrmDevolucaoAvicola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TbProdutosFra.IndexFieldNames := '';
  DmPrincipal.TbClientes.Active  := False;
  DmPrincipal.TbProdutosFra.Active  := False;
  DmPrincipal.TbDevolucaoFra.Active := False;
  DmPrincipal.TbMov_DevFra.Active   := False;
  DmPrincipal.TbReceberFra.Active   := False;
end;

procedure TFrmDevolucaoAvicola.DBGrid1DblClick(Sender: TObject);
begin
  Application.CreateForm(TfrmConf_Itens_DevFra, FrmConf_Itens_DevFra);
  DmPrincipal.TbMov_DevFra.Insert;
  DmPrincipal.TbMov_DevFra.FieldByName('Dev_Nr').AsString   := Edit1.Text;
  DmPrincipal.TbMov_DevFra.FieldByName('Cod_Prod').AsString := DmPrincipal.TbProdutosFra.FieldByName('Codigo').AsString;
  FrmConf_Itens_DevFra.ShowModal;
  BitBtn1.Enabled := True; // Habilitar o Botao Confirmar do Vale Venda
  FrmConf_Itens_DevFra.Destroy;
end;

procedure TFrmDevolucaoAvicola.CadastarProdutos1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmCadProdFra, FrmCadProdFra);
  FrmCadProdFra.ShowModal;
  FrmCadProdFra.Destroy;
  DmPrincipal.TbProdutosFra.Active := True;
end;

procedure TFrmDevolucaoAvicola.A1Click(Sender: TObject);
begin
  If DmPrincipal.TbMov_DevFra.EOF Then
  Begin
    Application.MessageBox('Não há ítens a ser alterado !!! ',' Advertência ',48);
    Exit;
  End;
  Application.CreateForm(TfrmConf_Itens_DevFra, FrmConf_Itens_DevFra);
  DmPrincipal.TbMov_DevFra.Edit;
  FrmConf_Itens_DevFra.ShowModal;
  FrmConf_Itens_DevFra.Destroy;
end;

procedure TFrmDevolucaoAvicola.Excluir1Click(Sender: TObject);
begin
  If DmPrincipal.TbMov_DevFra.IsEmpty Then
    Application.MessageBox('Não há ítens a ser excluído !!! ',' Advertência ',48)
  Else
    If Application.MessageBox('Deseja realmente excluir este ítem ?',' Confirmação de Exclusão ',36) = IDYes Then
      DmPrincipal.TbMov_DevFra.Delete;
end;

procedure TFrmDevolucaoAvicola.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmConfirmaDevolucaoAvicola, FrmConfirmaDevolucaoAvicola);
  FrmConfirmaDevolucaoAvicola.showModal;
  FrmConfirmaDevolucaoAvicola.destroy;
end;

procedure TFrmDevolucaoAvicola.BitBtn2Click(Sender: TObject);
begin
  If Application.MessageBox('Deseja realmente abandonar a operação ?','Confirmação',36) = idYes Then
  Begin
    DmPrincipal.TbMov_DevFra.First;
    While not DmPrincipal.TbMov_DevFra.IsEmpty do
    begin
      DmPrincipal.TbMov_DevFra.Delete;
    end;
    DmPrincipal.TbDevolucaoFra.Delete;
    GroupBox2.Visible := False;
    GroupBox3.Visible := False;
    GroupBox4.Visible := False;
    GroupBox6.Visible := False;
    CompletingComboBox2.SetFocus;
    DBRichEdit1.Visible := False;
  End;
end;

procedure TFrmDevolucaoAvicola.CompletingComboBox2KeyPress(Sender: TObject;
  var Key: Char);
begin
  CompletingComboBox2.DroppedDown := True;
  If Key = #13 Then
  Begin
    DmPrincipal.TBClientes.IndexName := 'Cli_Apel';
    DmPrincipal.TBClientes.FindKey([CompletingComboBox2.Text]);
    DBRichEdit1.Visible := True;
    DmPrincipal.TbDevolucaoFra.Insert;
    DmPrincipal.TbDevolucaoFra.FieldByName('Dev_Nr').AsString   := Edit1.Text;
    DmPrincipal.TbDevolucaoFra.FieldByName('Codigo').AsInteger  := DmPrincipal.TbClientes.FieldByName('Codigo').AsInteger;
    DmPrincipal.TbDevolucaoFra.FieldByName('Data').AsString     := MaskEdit1.Text;
    DmPrincipal.TbDevolucaoFra.Post;
    GroupBox2.Visible := True;
    GroupBox3.Visible := True;
    GroupBox4.Visible := True;
    GroupBox6.Visible := True;
    CompletingComboBox1.SetFocus;
  End;
  if Key = #27 then
    close;
end;

procedure TFrmDevolucaoAvicola.CompletingComboBox1KeyPress(Sender: TObject;
  var Key: Char);
begin
  CompletingComboBox1.DroppedDown := True;
  If Key = #13 Then
  Begin
    DmPrincipal.TbProdutosFra.IndexName := 'Pro_DescFra';
    DmPrincipal.TbProdutosFra.FindKey([CompletingComboBox1.Text]);
    Application.CreateForm(TfrmConf_Itens_DevFra, FrmConf_Itens_DevFra);
    DmPrincipal.TbMov_DevFra.Insert;
    DmPrincipal.TbMov_DevFra.FieldByName('Dev_Nr').AsString := Edit1.Text;

    DmPrincipal.TbMov_DevFra.FieldByName('Cod_Prod').AsInteger := DmPrincipal.TbProdutosFra.FieldByName('Codigo').AsInteger;
    FrmConf_Itens_DevFra.ShowModal;
    BitBtn1.Enabled := True; // Habilitar o Botao Confirmar do Vale Venda
    FrmConf_Itens_DevFra.Destroy;
  End;
end;


procedure TFrmDevolucaoAvicola.MaskEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
    close;
end;

procedure TFrmDevolucaoAvicola.CompletingComboBox2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CompletingComboBox2.DroppedDown := True;
end;

procedure TFrmDevolucaoAvicola.CompletingComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CompletingComboBox1.DroppedDown := True;
end;
end.
