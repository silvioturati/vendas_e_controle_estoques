�
 TFRMRELATORIOPEDIDOPERIODOACOUGUE 0�  TPF0!TFrmRelatorioPedidoPeriodoAcougue FrmRelatorioPedidoPeriodoAcougueLeftTopoWidth�Height� Caption*Relat�rio de Pedidos da A�ougue no Per�odoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterOnClose	FormCloseOnShowFormShowPixelsPerInch`
TextHeight TRadioGroupRadioGroup1Left Top Width� Height� CaptionTipo de PedidoCtl3D	Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 	ItemIndex Items.Strings� Vista� PrazoVarejoTransfer�ncia ParentCtl3D
ParentFontTabOrder   TRadioGroupRadioGroup2Left� Top Width� HeightHCaptionClassifica��o do Relat�rioFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 	ItemIndex Items.StringsPor Nome FantasiaPor Raz�o Social 
ParentFontTabOrder  	TGroupBox	GroupBox1Left� TopIWidth� HeightHCaptionPer�odoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder TLabelLabel1LeftTopWidthJHeightCaptionData �nicial :  TLabelLabel2LeftTop/Width;HeightCaption
Data Final  	TMaskEdit	MaskEdit1Left_TopWidthLHeightCtl3DEditMask!99/99/9999;1; 	MaxLength
ParentCtl3DTabOrder Text
  /  /      	TMaskEdit	MaskEdit2Left_Top,WidthLHeightCtl3DEditMask!99/99/9999;1; 	MaxLength
ParentCtl3DTabOrderText
  /  /       	TGroupBox	GroupBox2Left Top� Width�Height<TabOrder TBitBtnBtnVisualizarLeft
TopWidth_Height#Caption&VisualizarFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrder OnClickBtnVisualizarClick
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�3�7�33w����s33737�7?33����333���33����337ww333����33s�7�3s33w����s337�737�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TBitBtnBtnImprimirLeft� TopWidth_Height#Caption	&ImprimirFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderOnClickBtnImprimirClick
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 0      ?��������������wwwwwww�������wwwwwww        ���������������wwwwwww�������wwwwwww�������wwwwww        wwwwwww30����337���?330� 337�wss330����337��?�330�  337�swws330���3337��73330��3337�ss3330�� 33337��w33330  33337wws333	NumGlyphs  TBitBtn	BtnFecharLeft(TopWidth_Height#Caption&FecharFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderOnClickBtnFecharClickKindbkClose   TDataSource	DsReceberDataSetQueryReceberLeft� Top  TQueryQueryReceberActive	DatabaseNameatacado2001SQL.StringsOSelect Clientes.Codigo, Clientes.Fantasia, Clientes.Razao, VendasBoi.Venda_nr,  VendasBoi.Data,  VendasBoi.TotalFrom Clientes, VendasBoi,Where Clientes.Codigo = VendasBoi.Codigo AND%VendasBoi.Data >= :MaskEdit1.Text AND!VendasBoi.Data <= :MaskEdit2.Text=Group By Clientes.Codigo, Clientes.Fantasia, Clientes.Razao, 3VendasBoi.Venda_Nr, VendasBoi.Data, VendasBoi.TotalOrder By Fantasia  Params.Data
6     MaskEdit1.Text 	 v%  MaskEdit2.Text 	 �%  Left� TopH   