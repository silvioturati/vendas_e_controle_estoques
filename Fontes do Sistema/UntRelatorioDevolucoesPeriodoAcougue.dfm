?
 TFRMRELATORIODEVOLUCOESPERIODOACOUGUE 0?
  TPF0%TFrmRelatorioDevolucoesPeriodoAcougue$FrmRelatorioDevolucoesPeriodoAcougueLeft
Top Width@Height? Caption$Rel. de Devolu??es da A?. no Per?odoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style PixelsPerInch`
TextHeight TBevelBevel1Left? TopWidthqHeight? ShapebsFrameStylebsRaised  TRadioGroupRadioGroup1Left Top Width? HeightGCaptionClassifica??o do Relat?rio	ItemIndex Items.StringsPor Nome FantasiaPor Raz?o Social TabOrder   	TGroupBox	GroupBox1Left TopHWidth? HeightICaptionPer?odoTabOrder TLabelLabel1LeftTopWidth5HeightCaptionData Inicial  TLabelLabel2LeftTop/Width0HeightCaption
Data Final  	TMaskEdit	MaskEdit2Left_Top*WidthLHeightCtl3DEditMask!99/99/9999;1; 	MaxLength
ParentCtl3DTabOrder Text
  /  /      	TMaskEdit	MaskEdit1Left_TopWidthLHeightCtl3DEditMask!99/99/9999;1; 	MaxLength
ParentCtl3DTabOrderText
  /  /       TBitBtnBitBtn1Left? TopWidthSHeight#Caption&VisualizarTabOrderOnClickBitBtn1Click
Glyph.Data
z  v  BMv      v   (                                    ?  ?   ?? ?   ? ? ??   ???   ?  ?   ?? ?   ? ? ??  ??? 3333333333333?3333330 333333?w333333 33333?ws333330 333333?w333333 333???ws337 ;p333?ws?w333ww ?333w37ws330??p3337?3?7?33w????s33737?7?33????333???33????337ww333????33s?7?3s33w????s337?737?330??p3337??3?3333ww3333w??s33337 333333ws3333	NumGlyphs  TBitBtnBitBtn2Left? Top;WidthSHeight#Caption	&ImprimirTabOrderOnClickBitBtn2Click
Glyph.Data
z  v  BMv      v   (                                    ?  ?   ?? ?   ? ? ??   ???   ?  ?   ?? ?   ? ? ??  ??? 0      ???????????????wwwwwww???????wwwwwww        ???????????????wwwwwww???????wwwwwww???????wwwwww        wwwwwww30????337????330? 337?wss330????337????330?  337?swws330???3337??73330??3337?ss3330?? 33337??w33330  33337wws333	NumGlyphs  TBitBtnBitBtn3Left? TopgWidthSHeight#Caption&FecharTabOrderOnClickBitBtn3ClickKindbkClose  TQuery
QueryPagarDatabaseNameatacado2001SQL.StringsPSelect Clientes.Codigo, Clientes.Fantasia, Clientes.Razao, DevolucaoBoi.Dev_nr, &DevolucaoBoi.Data,  DevolucaoBoi.TotalFrom Clientes, DevolucaoBoi/Where Clientes.Codigo = DevolucaoBoi.Codigo AND)DevolucaoBoi.Data >= :MaskEdit1.Text  AND$DevolucaoBoi.Data <= :MaskEdit2.Text=Group By Clientes.Codigo, Clientes.Fantasia, Clientes.Razao, :DevolucaoBoi.Dev_Nr, DevolucaoBoi.Data, DevolucaoBoi.TotalOrder By Fantasia Params.Data
6     MaskEdit1.Text 	 Z?
   MaskEdit2.Text 	 Z?
   Left? Top1  TDataSourceDsPagarDataSet
QueryPagarLeft? Top   