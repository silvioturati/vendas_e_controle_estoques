�
 TFRMRELATORIOSINTESEDEVOLUCAOAVICOLA 0u  TPF0$TFrmRelatorioSinteseDevolucaoAvicola#FrmRelatorioSinteseDevolucaoAvicolaLeft�Top� Width�Height$Caption8Relat�rio de Devolu��es da Av�cola - Produtos x ClientesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OnClose	FormCloseOnShowFormShowPixelsPerInch`
TextHeight 	TGroupBox	GroupBox1Left TopWidth� HeightYCaptionPer�odoTabOrder  TLabelLabel1LeftTopWidth5HeightCaptionData Inicial  TLabelLabel2LeftTop9Width0HeightCaption
Data Final  	TMaskEdit	MaskEdit1Left`TopWidthEHeightEditMask99/99/9999;1; 	MaxLength
TabOrder Text
  /  /      	TMaskEdit	MaskEdit2Left`Top5WidthEHeightEditMask99/99/9999;1; 	MaxLength
TabOrderText
  /  /       TRadioGroupRadioGroup1LeftTopWidth� HeightXCaptionExibir por:	ItemIndex Items.StringsNome da FantasiaRaz�o Social TabOrderOnClickRadioGroup1Click  TDBGridDBGrid1Left TophWidth�Heightv
DataSourceDmPrincipal.DSClientesTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style Columns	FieldNameFantasia 	FieldNameRazao    TBitBtnBitBtn1Left Top� WidthUHeightCaption	&ImprimirTabOrderOnClickBitBtn1Click
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 0      ?��������������wwwwwww�������wwwwwww        ���������������wwwwwww�������wwwwwww�������wwwwww        wwwwwww30����337���?330� 337�wss330����337��?�330�  337�swws330���3337��73330��3337�ss3330�� 33337��w33330  33337wws333	NumGlyphs  TBitBtnBitBtn2LeftVTop� WidthUHeightCaption&VisualizarTabOrderOnClickBitBtn2Click
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�3�7�33w����s33737�7?33����333���33����337ww333����33s�7�3s33w����s337�737�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TBitBtnBitBtn3Left� Top� WidthqHeightCaptionPesquisar ClienteTabOrderOnClickBitBtn3Click
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 333333333333�333333<333333�w�3333<���33337w73333�3333ssw�33< ����33�w3773<����37w?33sw�������ss�377 �����w37?33sw������s�3s�3770������7?37?3?s3��� 33s�3s�w330��� 3337?37w3333�33333s�s333330 3333337w333333333333333333333333333333333333	NumGlyphs  TBitBtnBitBtn4Left4Top� WidthUHeightCaption&FecharTabOrderOnClickBitBtn4ClickKindbkClose  
TPopupMenu
PopupMenu1Left� Top  	TMenuItem
Pesquisar1Caption	Pesquisar   TTable
TbAux_TempDatabaseNameatacado2001IndexFieldNamesCod_Prod	TableNameAux_Temp.DBLeft� Topp  TTableTbMov_DevFraDatabaseNameatacado2001IndexFieldNamesDev_Nr;Cod_Prod;Qtde	TableNameMov_DevFra.DBLeft� Topp  TTableTbDevolucaoFraDatabaseNameatacado2001	IndexNameCodigo_DevFra	TableNameDevolucaoFra.DBLeft� Topp  TTableTbProdutosFraDatabaseNameatacado2001IndexFieldNamesCodigo	TableNameProdutosFra.DBLeftTopp  TDataSource
Ds_AuxTempDataSet
TbAux_TempLeft� Top�   TDataSourceDsMov_DevFraDataSetTbMov_DevFraLeft� Top�   TDataSourceDsDevolucaoFraDataSetTbDevolucaoFraLeft� Top�   TDataSourceDsProdutosFraDataSetTbProdutosFraLeftTop�    