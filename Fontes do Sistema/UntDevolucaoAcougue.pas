unit UntDevolucaoAcougue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, TcCombobox, ComCtrls, DBCtrls, Menus, Grids, DBGrids,
  Buttons;

type
  TFrmDevolucaoAcougue = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox6: TGroupBox;
    Edit2: TEdit;
    Label3: TLabel;
    CompletingComboBox2: TCompletingComboBox;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    Label1: TLabel;
    Edit1: TEdit;
    DBRichEdit1: TDBRichEdit;
    Label4: TLabel;
    CompletingComboBox1: TCompletingComboBox;
    DBGrid1: TDBGrid;
    PopupMenu2: TPopupMenu;
    CadastarProdutos1: TMenuItem;
    DBGrid2: TDBGrid;
    PopupMenu1: TPopupMenu;
    A1: TMenuItem;
    N1: TMenuItem;
    Excluir1: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Procedure Gera_Novo_Mov;
    procedure CompletingComboBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CompletingComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure CompletingComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CompletingComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure CadastarProdutos1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
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
  FrmDevolucaoAcougue: TFrmDevolucaoAcougue;

implementation

uses UntDataModulo, UntCadProdBoi, UntPesqCadCli, UntPesqCadProdBoi,
  UntConf_Itens_DevBoi, UntConfirmaDevolucaoAcougue;

{$R *.DFM}

Procedure TFrmDevolucaoAcougue.Gera_Novo_Mov;
begin
  MaskEdit1.Text := DateToStr(Date());
  DmPrincipal.TbDevolucaoBoi.Last;
  Edit1.Text := IntToStr(DmPrincipal.TbDevolucaoBoi.FieldByName('Dev_Nr').AsInteger + 1);
  GroupBox2.Visible := False;
  GroupBox3.Visible := False;
  GroupBox4.Visible := False;
  GroupBox6.Visible := False;
end;

procedure TFrmDevolucaoAcougue.CompletingComboBox2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CompletingComboBox2.DroppedDown := True;
end;

procedure TFrmDevolucaoAcougue.CompletingComboBox2KeyPress(Sender: TObject;
  var Key: Char);
begin
  CompletingComboBox2.DroppedDown := True;
  If Key = #13 Then
  Begin
    DmPrincipal.TBClientes.IndexName := 'Cli_Apel';
    DmPrincipal.TBClientes.FindKey([CompletingComboBox2.Text]);
    DBRichEdit1.Visible := True;
    DmPrincipal.TbDevolucaoBoi.Insert;
    DmPrincipal.TbDevolucaoBoi.FieldByName('Dev_Nr').AsString   := Edit1.Text;
    DmPrincipal.TbDevolucaoBoi.FieldByName('Codigo').AsInteger  := DmPrincipal.TbClientes.FieldByName('Codigo').AsInteger;
    DmPrincipal.TbDevolucaoBoi.FieldByName('Data').AsString     := MaskEdit1.Text;
    DmPrincipal.TbDevolucaoBoi.Post;
    GroupBox2.Visible := True;
    GroupBox3.Visible := True;
    GroupBox4.Visible := True;
    GroupBox6.Visible := True;
    CompletingComboBox1.SetFocus;
  End;
  if Key = #27 then
    close;
end;

procedure TFrmDevolucaoAcougue.MaskEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #27 then
    close;
end;

procedure TFrmDevolucaoAcougue.CompletingComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CompletingComboBox1.DroppedDown := True;
end;

procedure TFrmDevolucaoAcougue.CompletingComboBox1KeyPress(Sender: TObject;
  var Key: Char);
begin
  CompletingComboBox1.DroppedDown := True;
  If Key = #13 Then
  Begin
    DmPrincipal.TbProdutosBoi.IndexName := 'Pro_DescBoi';
    DmPrincipal.TbProdutosBoi.FindKey([CompletingComboBox1.Text]);
    Application.CreateForm(TfrmConf_Itens_DevBoi, FrmConf_Itens_DevBoi);
    DmPrincipal.TbMov_DevBoi.Insert;
    DmPrincipal.TbMov_DevBoi.FieldByName('Dev_Nr').AsString := Edit1.Text;
    DmPrincipal.TbMov_DevBoi.FieldByName('Cod_Prod').AsString := DmPrincipal.TbProdutosBoi.FieldByName('Codigo').AsString;
    FrmConf_Itens_DevBoi.ShowModal;
    BitBtn1.Enabled := True; // Habilitar o Botao Confirmar do Vale Venda
    FrmConf_Itens_DevBoi.Destroy;
  End;
end;

procedure TFrmDevolucaoAcougue.DBGrid1DblClick(Sender: TObject);
begin
  Application.CreateForm(TfrmConf_Itens_DevBoi, FrmConf_Itens_DevBoi);
  DmPrincipal.TbMov_DevBoi.Insert;
  DmPrincipal.TbMov_DevBoi.FieldByName('Dev_Nr').AsString   := Edit1.Text;
  DmPrincipal.TbMov_DevBoi.FieldByName('Cod_Prod').AsString := DmPrincipal.TbProdutosBoi.FieldByName('Codigo').AsString;
  FrmConf_Itens_DevBoi.ShowModal;
  BitBtn1.Enabled := True; // Habilitar o Botao Confirmar do Vale Venda
  FrmConf_Itens_DevBoi.Destroy;
end;

procedure TFrmDevolucaoAcougue.CadastarProdutos1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmCadProdBoi, FrmCadProdBoi);
  FrmCadProdBoi.ShowModal;
  FrmCadProdBoi.Destroy;
  DmPrincipal.TbProdutosBoi.Active := True;
end;

procedure TFrmDevolucaoAcougue.A1Click(Sender: TObject);
begin
  If DmPrincipal.TbMov_DevBoi.EOF Then
  Begin
    Application.MessageBox('Não há ítens a ser alterado !!! ',' Advertência ',48);
    Exit;
  End;
  Application.CreateForm(TfrmConf_Itens_DevBoi, FrmConf_Itens_DevBoi);
  DmPrincipal.TbMov_DevBoi.Edit;
  FrmConf_Itens_DevBoi.ShowModal;
  FrmConf_Itens_DevBoi.Destroy;
end;

procedure TFrmDevolucaoAcougue.Excluir1Click(Sender: TObject);
begin
  If DmPrincipal.TbMov_DevBoi.IsEmpty Then
    Application.MessageBox('Não há ítens a ser excluído !!! ',' Advertência ',48)
  Else
    If Application.MessageBox('Deseja realmente excluir este ítem ?',' Confirmação de Exclusão ',36) = IDYes Then
      DmPrincipal.TbMov_DevBoi.Delete;
end;

procedure TFrmDevolucaoAcougue.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmConfirmaDevolucaoAcougue, FrmConfirmaDevolucaoAcougue);
  FrmConfirmaDevolucaoAcougue.showModal;
  FrmConfirmaDevolucaoAcougue.destroy;
end;

procedure TFrmDevolucaoAcougue.BitBtn2Click(Sender: TObject);
begin
  If Application.MessageBox('Deseja realmente abandonar a operação ?','Confirmação',36) = idYes Then
  Begin
    DmPrincipal.TbMov_DevBoi.First;
    While not DmPrincipal.TbMov_DevBoi.IsEmpty do
    begin
      DmPrincipal.TbMov_DevBoi.Delete;
    end;
    DmPrincipal.TbDevolucaoBoi.Delete;
    GroupBox2.Visible := False;
    GroupBox3.Visible := False;
    GroupBox4.Visible := False;
    GroupBox6.Visible := False;
    CompletingComboBox2.SetFocus;
    DBRichEdit1.Visible := False;
  End;
end;

procedure TFrmDevolucaoAcougue.FormShow(Sender: TObject);
begin
  DmPrincipal.TbProdutosBoi.IndexFieldNames := 'Descricao';
  DmPrincipal.TbClientes.Active   := True;
  DmPrincipal.TbProdutosBoi.Active   := True;
  DmPrincipal.TbDevolucaoBoi.Active  := True;
  DmPrincipal.TbMov_DevBoi.Active    := True;
  DmPrincipal.TbReceberBoi.Active    := True;
  MaskEdit1.Text := DateToStr(Date());
  DmPrincipal.TbDevolucaoBoi.Last;
  Edit1.Text := IntToStr(DmPrincipal.TbDevolucaoBoi.FieldByName('Dev_Nr').AsInteger + 1);
  DmPrincipal.TBClientes.First;
  While not DmPrincipal.TbClientes.Eof do
  Begin
    CompletingComboBox2.Items.Add(DmPrincipal.TbClientes.FieldByName('Fantasia').AsString);
    DmPrincipal.TbClientes.Next;
  end;
  // Carregar o Completing combo box dos produtos
  DmPrincipal.TbProdutosBoi.First;
  While not DmPrincipal.TbProdutosBoi.Eof do
  Begin
    CompletingComboBox1.Items.Add(DmPrincipal.TbProdutosBoi.FieldByName('Descricao').AsString);
    DmPrincipal.TbProdutosBoi.Next;
  end;
  CompletingComboBox2.SetFocus;
end;

procedure TFrmDevolucaoAcougue.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DmPrincipal.TbProdutosBoi.IndexFieldNames := '';
  DmPrincipal.TbClientes.Active  := False;
  DmPrincipal.TbProdutosBoi.Active  := False;
  DmPrincipal.TbDevolucaoBoi.Active := False;
  DmPrincipal.TbMov_DevBoi.Active   := False;
  DmPrincipal.TbReceberBoi.Active   := False;
end;

end.
