?
 TFRMPEDIDOACOUGUE 0?  TPF0TFrmPedidoAcougueFrmPedidoAcougueLeft?TopuWidth?Height?BorderIcons CaptionEmiss?o de Pedidos do A?ougueFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterOnClose	FormClose
OnKeyPressFormKeyPressOnShowFormShowPixelsPerInch`
TextHeight 	TGroupBox	GroupBox1Left Top Width|HeightQTabOrder  TLabelLabel1LeftTopWidth&HeightCaption	Cliente :  TLabelLabel2Left?TopWidth.HeightCaptionN? Venda  TLabelLabel3LeftTopWidthHeightCaptionData  TCompletingComboBoxCompletingComboBox2Left5TopWidth[HeightHint^Para realizar uma venda escolha aqui o nome do cliente e tecle <enter>. Para sair tecle <esc>.
ItemHeightParentShowHintShowHint	TabOrder 	OnKeyDownCompletingComboBox2KeyDown
OnKeyPressCompletingComboBox2KeyPressTextCompletion  TEditEdit1Left?Top	WidthAHeightCtl3DParentCtl3DTabOrder  	TMaskEdit	MaskEdit1Left/Top	WidthAHeightCtl3DEditMask!99/99/9999;1; 	MaxLength
ParentCtl3DTabOrderText
  /  /      TDBRichEditDBRichEdit1LeftTop"WidthkHeight*HintObserva??es sobre o clienteTabStopAutoDisplayCtl3D	DataFieldObs
DataSourceDmPrincipal.DSClientesEnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style ParentCtl3D
ParentFontParentShowHintShowHint	TabOrderVisible   	TGroupBox	GroupBox2Left TopRWidth|Height{CaptionMercadorias CadastradasFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderVisible TLabelLabel4LeftTopWidthOHeightCaptionDigite o Produto:Color??? Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height?	Font.NameMS Sans Serif
Font.Style ParentColor
ParentFont  TCompletingComboBoxCompletingComboBox1Left\TopWidthHeightHint+Digite aqui o nome do produto e tecle enter
ItemHeightParentShowHintShowHint	TabOrder Visible	OnKeyDownCompletingComboBox1KeyDown
OnKeyPressCompletingComboBox1KeyPressTextCompletion  TDBGridDBGrid1LeftTop*WidthlHeightITabStopCtl3D
DataSourceDmPrincipal.DsProdutosBoiFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.StylefsBold OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgConfirmDeletedgCancelOnExit ParentCtl3D
ParentFont	PopupMenu
PopupMenu2TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height?TitleFont.NameMS Sans SerifTitleFont.StylefsBold 
OnDblClickDBGrid1DblClickColumns	FieldName	DescricaoReadOnly	Title.Caption	Descri??oTitle.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height?Title.Font.NameMS Sans SerifTitle.Font.Style Width, 	FieldNameUnidadeReadOnly	Title.CaptionUnTitle.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height?Title.Font.NameMS Sans SerifTitle.Font.Style Width 	FieldNameValor_AVReadOnly	Title.CaptionValor ? VistaTitle.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height?Title.Font.NameMS Sans SerifTitle.Font.Style WidthF 	FieldNameValor_APReadOnly	Title.CaptionValor ? PrazoTitle.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height?Title.Font.NameMS Sans SerifTitle.Font.Style WidthF 	FieldNameValor_BAReadOnly	Title.CaptionValor VarejoTitle.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height?Title.Font.NameMS Sans SerifTitle.Font.Style WidthF 	FieldNameValor_TRReadOnly	Title.CaptionTransfer?nciaTitle.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height?Title.Font.NameMS Sans SerifTitle.Font.Style WidthF     	TGroupBox	GroupBox3Left Top? Width?Height? Caption?tens SelecionadosFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderVisible TDBGridDBGrid2LeftTopWidth?Height? TabStopCtl3D
DataSourceDmPrincipal.DsMov_VendasBoiFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.StylefsBold OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgConfirmDeletedgCancelOnExit ParentCtl3D
ParentFont	PopupMenu
PopupMenu1TabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height?TitleFont.NameMS Sans SerifTitleFont.StylefsBold 	OnColExitDBGrid2ColExit
OnDblClickDBGrid2DblClickColumns	FieldName	DescricaoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style Title.CaptionDescri??o da MercadoriaTitle.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height?Title.Font.NameMS Sans SerifTitle.Font.Style Width?  	FieldNameQtdeFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style Title.AlignmenttaCenterTitle.Caption
QuantidadeTitle.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height?Title.Font.NameMS Sans SerifTitle.Font.Style WidthA 	FieldNameUnitarioFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style Title.AlignmenttaCenterTitle.CaptionPre?o Unit?rioTitle.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height?Title.Font.NameMS Sans SerifTitle.Font.Style WidthQ 	FieldNameTotalFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style Title.AlignmenttaCenterTitle.Font.CharsetDEFAULT_CHARSETTitle.Font.ColorclWindowTextTitle.Font.Height?Title.Font.NameMS Sans SerifTitle.Font.Style WidthZ     	TGroupBox	GroupBox4Left?Top? Width? Height? TabOrderVisible TBitBtnBtnConfirmarPedidoAcougueLeft/TopWidthdHeight)Caption	ConfirmarEnabledTabOrder OnClickBtnConfirmarPedidoAcougueClick
Glyph.Data
?  ?  BM?      v   (   $            |                       ?  ?   ?? ?   ? ? ??  ??? ???   ?  ?   ?? ?   ? ? ??  ??? 334C33333338?33333  33B$3333333?8?3333  34""C33333833?3333  3B""$33333?338?333  4"*""C3338??33?333  2"??"C3338???3?333  :*"*"$3338?3?38?33  4?""?"C338?33?3?33  B"?"*"$33?3?3?38?3  "*:"$?"C3?88?8?3?3  ??3?"J"$3??3?3?38?  :33:"$?"C8338?8?3?  3333?"J"C3333?3?3?  3333:"$?#33338?8?3  33333?"J333333?3?3  33333:"$3333338?8?  333333?$3333333?8?  333333:"33333338??  3333333?33333333?3  	NumGlyphs  TBitBtnBtnCancelarPedidoAcougueLeft/TopWWidthdHeight)CaptionCancelarTabOrderOnClickBtnCancelarPedidoAcougueClickKindbkCancel   	TGroupBox	GroupBox6Left?Top? Width? Height)Caption	Sub TotalFont.CharsetDEFAULT_CHARSET
Font.ColorclRedFont.Height?	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderVisible TEditEdit2Left(TopWidthqHeightCtl3DEnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclRedFont.Height?	Font.NameMS Sans Serif
Font.StylefsBold ParentCtl3D
ParentFontTabOrder Text0   
TPopupMenu
PopupMenu1Left0TopP 	TMenuItem#PMenuAlterarMov_VendasPedidoAcougueCaptionAlterarOnClick(PMenuAlterarMov_VendasPedidoAcougueClick  	TMenuItemN1Caption-  	TMenuItem*PMenuExcluirProdutoMov_VendasPedidoAcougueCaptionExcluirOnClick/PMenuExcluirProdutoMov_VendasPedidoAcougueClick   
TPopupMenu
PopupMenu2LeftHTop?  	TMenuItem"PMenuCadastrarProdutoPedidoAcougueCaptionCadastrar Produto NovoOnClick'PMenuCadastrarProdutoPedidoAcougueClick    