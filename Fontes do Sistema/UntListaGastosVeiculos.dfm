�
 TFRMLISTAGASTOSVEICULOS 0�  TPF0TFrmListaGastosVeiculosFrmListaGastosVeiculosLeft� TophWidthiHeight� BorderIconsbiSystemMenu Caption.Relat�rio de Gastos com Ve�culos (Combust�vel)Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterOnShowFormShowPixelsPerInch`
TextHeight TLabelLabel3LeftToppWidthIHeightCaptionPlaca Ve�culo :  TRadioGroupRadioGroup1LeftTopWidth� HeightYCaption Selecionar por 	ItemIndex Items.StringsVe�culosPostoTotal TabOrder OnClickRadioGroup1Click  	TGroupBox	GroupBox1Left� TopWidth� HeightYCaption	 Per�odo TabOrder TLabelLabel1LeftTopWidth>HeightCaptionData Inicial :   TLabelLabel2LeftTop8Width6HeightCaptionData Final :  	TMaskEdit	MaskEdit1LeftPTopWidthIHeightEditMask!99/99/0000;1; 	MaxLength
TabOrder Text
  /  /      	TMaskEdit	MaskEdit2LeftPTop4WidthIHeightEditMask!99/99/0000;1; 	MaxLength
TabOrderText
  /  /       TEditEdit1LeftVTopnWidthHeightTabOrder  TBitBtnBitBtn1Left*Top� WidthKHeight!Caption	&ImprimirTabOrderOnClickBitBtn1Click
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 0      7wwwwwws�������3333337��������������        wwwwwwww�������333333��������3333377��������������        wwwwwwww30����337���?330� 337�wss330����337��?�330�  337�swws330���3337��73330��3337�3s3330�� 33337��w33330  33337wws333	NumGlyphs  TBitBtnBitBtn2Left� Top� WidthQHeight!Caption&VisualizarTabOrderOnClickBitBtn2Click
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�3�7�33w����s33737�7?33����333���33����337ww333����33s�7�3s33w����s337�737�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TBitBtnBitBtn3Left� Top� WidthQHeight!Caption&FecharTabOrderOnClickBitBtn3Click
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33����33w?33333���33s�3333���337?3333��3333333��3333333��3333333��3333333��3333333��333�333���333w3333��3333333��33?3333���333333���33w��33     33wwwwws3	NumGlyphs  TDataSourceDataSource1DataSetQuery1LeftxTop  TQueryQuery1DatabaseNameatacado2001SQL.StringsSelect * From requisicao Where(  Requisicao.Data >= :MaskEdit1.Text AND(  Requisicao.Data <= :MaskEdit2.Text AND   Requisicao.Placa = :Edit1.Text  Order by Nome_Posto Params.Data
I     MaskEdit1.Text 	 Z�
   MaskEdit2.Text 	 Z�
   
Edit1.Text  0   LeftxTop8   