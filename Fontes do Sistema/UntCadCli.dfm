?
 TFRMCADCLI 0?4  TPF0
TFrmCadCli	FrmCadCliLeft? Top|Width?Height?BorderIcons
biMinimize
biMaximize CaptionCadastro de ClientesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterOnClose	FormCloseOnShowFormShowPixelsPerInch`
TextHeight TPageControlPageControl1LeftTop0Width|HeightW
ActivePage	TabSheet1TabOrder  	TTabSheet	TabSheet1CaptionDados da Empresa 	TGroupBox	GroupBox1LeftTopWidthnHeight2EnabledTabOrder  TLabelLabel3Left.TopWidth!HeightCaptionC?digo  TLabelLabel4LeftTop-Width?HeightCaptionRaz?o Social  TLabelLabel5LeftTopJWidthGHeightCaptionNome Fantasia  TLabelLabel6Left? TopWidthHeightCaptionData  TLabelLabel7Left TopkWidth.HeightCaptionEndere?o  TLabelLabel8Left2Top? WidthHeightCaptionBairro  TLabelLabel9Left,Top? Width!HeightCaptionCidade  TLabelLabel10Left/Top? Width!HeightCaptionEstado  TLabelLabel11Left<Top? WidthHeightCaptionCep  TLabelLabel12Left?Top? Width*HeightCaptionTelefone  TLabelLabel13Left?Top? WidthHeightCaptionFax  TLabelLabel14LeftTop? Width:HeightCaption
Observa??o  TBevelBevel1Left?Top:Width? HeightBShapebsFrame  TLabelLabel16Left?TopIWidthHeightCaptionC.G.C.  TLabelLabel17Left?Top`WidthHeightCaptionI.E.  TLabelLabel15Left?Top3WidthYHeightCaption Dados Cadastrais   	TMaskEdit	MaskEdit1LeftSTopWidth9HeightEnabledEditMask
999999;1; 	MaxLengthTabOrder Text        TDBEditDBEdit1LeftSTop*WidthDHeightColorclNone	DataFieldRazao
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit1EnterOnExitDBEdit1Exit  TDBEditDBEdit2LeftSTopHWidthEHeight	DataFieldFantasia
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit2EnterOnExitDBEdit2Exit  TDBRadioGroupDBRadioGroup1Left?Top
Width? Height&Caption Tipo Columns	DataFieldTipo
DataSourceDmPrincipal.DSClientesFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style Items.StringsJur?dicaF?sica 
ParentFontTabOrderValues.StringsJF OnChangeDBRadioGroup1Change  	TMaskEdit	MaskEdit2Left? TopWidthAHeightEditMask!99/99/9999;1; 	MaxLength
TabOrderText
  /  /    OnEnterMaskEdit2EnterOnExitMaskEdit2Exit  TDBEditDBEdit3LeftSTopgWidthFHeight	DataFieldEndereco
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit3EnterOnExitDBEdit3Exit  TDBEditDBEdit4LeftSTop? Width? Height	DataFieldBairro
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit4EnterOnExitDBEdit4Exit  TDBEditDBEdit5LeftRTop? Width? Height	DataFieldCidade
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit5EnterOnExitDBEdit5Exit  	TMaskEdit	MaskEdit3Left?Top? WidthyHeightEditMask(##) #999-9999;1; 	MaxLengthTabOrder
Text(  )     -    OnEnterMaskEdit3EnterOnExitMaskEdit3Exit  	TMaskEdit	MaskEdit4Left?Top? WidthyHeightEditMask(##) #999-9999;1; 	MaxLengthTabOrder	Text(  )     -    OnEnterMaskEdit4EnterOnExitMaskEdit4Exit  TDBComboBoxDBComboBox1LeftVTop? Width9Height	DataFieldEstado
DataSourceDmPrincipal.DSClientes
ItemHeightItems.StringsACAMBACEDFESFNGOMAMGMSMTPAPIPRRJRNRORRRSSCSESPTO Sorted	TabOrderOnEnterDBComboBox1EnterOnExitDBComboBox1Exit  	TMaskEdit	MaskEdit5LeftVTop? WidthAHeightEditMask99.999-999;1; 	MaxLength
TabOrderText
  .   -   OnEnterMaskEdit5EnterOnExitMaskEdit5Exit  TDBRichEditDBRichEdit1LeftQTop? Width?Height^	DataFieldObs
DataSourceDmPrincipal.DSClientes
ScrollBars
ssVerticalTabOrderOnEnterDBRichEdit1EnterOnExitDBRichEdit1Exit  	TMaskEdit	MaskEdit6Left?TopEWidthyHeightEditMask99.999.999/9999-99;1; 	MaxLengthTabOrderText  .   .   /    -    	TMaskEdit	MaskEdit7Left?Top_WidthyHeightEditMask999.999.999.999;1; 	MaxLengthTabOrderText   .   .   .       	TTabSheet	TabSheet2CaptionDados do Propriet?rio 	TGroupBox	GroupBox3LeftTopWidthnHeight8EnabledTabOrder  TLabelLabel22Left	Top? Width.HeightCaptionEndere?o  TLabelLabel23LeftTop? WidthHeightCaptionBairro  TLabelLabel24LeftTop? Width!HeightCaptionCidade  TLabelLabel25LeftTop? Width!HeightCaptionEstado  TLabelLabel26LeftTop? WidthHeightCaptionCep  TLabelLabel27LeftTop? Width*HeightCaptionTelefone  TLabelLabel28Left? Top? WidthHeightCaptionFax  TLabelLabel35LeftGTop? WidthHeightCaptione-mail  TDBEditDBEdit8Left=Top? Width?Height	DataFieldEndProp
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit8EnterOnExitDBEdit8Exit  TDBEditDBEdit9Left=Top? Width? Height	DataField
BairroProp
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit9EnterOnExitDBEdit9Exit  TDBEditDBEdit10LeftBTop? Width? Height	DataFieldCidProp
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit10EnterOnExitDBEdit10Exit  	TMaskEdit
MaskEdit10Left<Top? WidthyHeightEditMask(##) #999-9999;1; 	MaxLengthTabOrderText(  )     -    OnEnterMaskEdit10EnterOnExitMaskEdit10Exit  	TMaskEdit
MaskEdit11Left? Top? WidthnHeightEditMask(##) #999-9999;1; 	MaxLengthTabOrderText(  )     -    OnEnterMaskEdit11EnterOnExitMaskEdit11Exit  TDBComboBoxDBComboBox2Left:Top? Width-Height	DataFieldEstProp
DataSourceDmPrincipal.DSClientes
ItemHeightItems.StringsACAMBACEDFESFNGOMAMGMSMTPAPIPRRJRNRORRRSSCSESPTO Sorted	TabOrderOnEnterDBComboBox2EnterOnExitDBComboBox2Exit  	TMaskEdit
MaskEdit12Left&Top? WidthAHeightEditMask99.999-999;1; 	MaxLength
TabOrderText
  .   -   OnEnterMaskEdit12EnterOnExitMaskEdit12Exit  	TGroupBox	GroupBox4LeftTop
WidthbHeightDCaptionDados PessoaisTabOrder  TLabelLabel20Left	TopWidthcHeightCaptionNome do Propriet?rio  TLabelLabel18LeftTop*WidthRHeightCaptionData Nascimento  TLabelLabel30LeftTop*WidthHeightCaptionR.G.  TLabelLabel31Left?Top*WidthHeightCaptionC.I.C.  TDBEditDBEdit7LeftrTopWidth?Height	DataFieldNomeProp
DataSourceDmPrincipal.DSClientesTabOrder OnEnterDBEdit7EnterOnExitDBEdit7Exit  	TMaskEdit
MaskEdit13Left.Top&WidthyHeightEditMask99.999.999-aa;1; 	MaxLengthTabOrderText  .   .   -  OnEnterMaskEdit13EnterOnExitMaskEdit13Exit  	TMaskEdit
MaskEdit14Left?Top&WidthyHeightEditMask999.999.999-99;1; 	MaxLengthTabOrderText   .   .   -  OnEnterMaskEdit14EnterOnExitMaskEdit14Exit  	TMaskEdit	MaskEdit8LeftpTop&WidthyHeightEditMask!99/99/9999;1; 	MaxLength
TabOrderText
  /  /    OnEnterMaskEdit8EnterOnExitMaskEdit8Exit   	TGroupBox	GroupBox5LeftTopNWidthjHeightICaptionFilia??oTabOrder TLabelLabel19LeftTopWidthHeightCaptionPai  TLabelLabel21LeftTop/WidthHeightCaptionM?e  TDBEditDBEdit11Left"TopWidth<Height	DataFieldPai
DataSourceDmPrincipal.DSClientesTabOrder OnEnterDBEdit11EnterOnExitDBEdit11Exit  TDBEditDBEdit12Left"Top,Width:Height	DataFieldMae
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit12EnterOnExitDBEdit12Exit   	TGroupBox	GroupBox6LeftTop? Width`HeightGCaptionInforma??es FinanceirasTabOrder
 TLabelLabel33Left
Top0WidthHeightCaptionLoja  TLabelLabel34Left
TopWidthHeightCaptionLoja  TLabelLabel29LeftoTopWidthHeightCaptionBanco  TLabelLabel32LeftnTop.WidthHeightCaptionBanco  TDBEditDBEdit14Left%Top-Width,Height	DataFieldloja2
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit14EnterOnExitDBEdit14Exit  TDBEditDBEdit15Left%TopWidth.Height	DataFieldloja1
DataSourceDmPrincipal.DSClientesTabOrder OnEnterDBEdit15EnterOnExitDBEdit15Exit  TDBEditDBEdit16Left?TopWidth? Height	DataFieldBanco1
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit16EnterOnExitDBEdit16Exit  TDBEditDBEdit17Left?Top*Width? Height	DataFieldBanco2
DataSourceDmPrincipal.DSClientesTabOrderOnEnterDBEdit17EnterOnExitDBEdit17Exit   	TGroupBox	GroupBox7Left?TopNWidth? HeightICaption
Observa??oTabOrder TDBRichEditDBRichEdit2LeftTopWidth? Height1	DataFieldObs
DataSourceDmPrincipal.DSClientesTabOrder    TDBEditDBEdit13LeftmTop? Width? Height	DataFieldemail
DataSourceDmPrincipal.DSClientesTabOrder	OnEnterDBEdit13EnterOnExitDBEdit13Exit     TPanelPanel1Left Top Width~Height/CaptionPanel1TabOrder TBevelBevel2LeftTopWidthLHeight&ShapebsFrameStylebsRaised  TLabelLabel1LeftTopWidth@HeightCaptionCadastroFont.CharsetANSI_CHARSET
Font.ColorclNavyFont.Height?	Font.NameArial
Font.StylefsBold 
ParentFont  TLabelLabel2LeftTopWidth;HeightCaptionClientesFont.CharsetANSI_CHARSET
Font.ColorclNavyFont.Height?	Font.NameArial
Font.StylefsBold 
ParentFont  TBitBtn
BtnIncluirLeftZTop
WidthLHeightCaption&IncluirTabOrder OnClickBtnIncluirClick
Glyph.Data
z  v  BMv      v   (                                    ?  ?   ?? ?   ? ? ??   ???   ?  ?   ?? ?   ? ? ??  ??? 3333333333?3333?39?3330 373337w39?3330 3??337w9???33337ww333?9???333 7wws333w39?3333 373333w39?3333337s3333?3333333 3333?33w333<333 3337?33w333<?3333??????<????Ù37wwwww?<????Ù37wwwwsw3333<?3333337s33?333<330 3337337w3333330 3333337w3333333333333333	NumGlyphs  TBitBtn
BtnAlterarLeft? Top
WidthKHeightCaption&AlterarTabOrderOnClickBtnAlterarClick
Glyph.Data
z  v  BMv      v   (                                    ?  ?   ?? ?   ? ? ??   ???   ?  ?   ?? ?   ? ? ??  ??? 333     333wwwww333??????????? 0  ? ?w?ww?sw7??????ws3?33?࿿ ???w?3ws??7???????w?3???7࿿  ?w?3wwss7????????w?????37??   ??w?wwws?? ? ?? ?ws?w73w730 ???37wss3??330???  33773?ww33??33s7s730???37?33s3	?? 33ws??w3303   3373wwws3	NumGlyphs  TBitBtn
BtnExcluirLeft? Top
WidthKHeightCaption&ExcluirTabOrderOnClickBtnExcluirClick
Glyph.Data
z  v  BMv      v   (                                    ?  ?   ?? ?   ? ? ??   ???   ?  ?   ?? ?   ? ? ??  ??? UUUUUUUU_???_U??wwwuuY?WwwwuuWw?UUUUUP0UUUUU?W??UUUP[?UUUUWu?w?UUU?  UUUUuWww?UUP???UUUWUuWW?UU???UUUUUuW?UU??? UUUUWUw?UP????UUWUUW??U?? ?UUuu?Uw??P?࿰??UW?W_WW?? ????Uw?u????  ??  ?Uww?Www??  UP?UwwuUWWUP  UUUUWwwUUUUU UUUUUwuUUUuU	NumGlyphs  TBitBtn	BtnSalvarLeft;Top
WidthKHeightCaption&SalvarEnabledTabOrderOnClickBtnSalvarClick
Glyph.Data
z  v  BMv      v   (                                    ?  ?   ?? ?   ? ? ??   ???   ?  ?   ?? ?   ? ? ??  ??? 333333333???????0 www 37wwwwww?  ??? 37??7?  ?? 37?7?  ?? 37???  ??? 37www3       ??????       wwwww ???? 3333 ???? 3333 ???? 3333 ???? 3333 ???? 3333 ????3333w ???? s????s0	???? 37wwwwww3	NumGlyphs  TBitBtnBtnCancelarLeft?Top
WidthKHeightCancel	Caption	&CancelarEnabledTabOrderOnClickBtnCancelarClick
Glyph.Data
?  ?  BM?      v   (   $            h                       ?  ?   ?? ?   ? ? ??  ??? ???   ?  ?   ?? ?   ? ? ??  ??? 333333333333333333  33?33333333?333333  39?33?3333??33?33  3939?338??3???3  39??338?8??3?3  33?338?3??38?  339?333?3833?3  333?33338?33??3  3331?33333?33833  3339?333338?3?33  333??33333833?33  33933333?33?33  33????333838?8?3  33?39333?3??3?3  33933?333??38?8?  33333393338?33???  3333333333333338?3  333333333333333333  	NumGlyphs  TBitBtnBtnPesquisarLeft?Top
WidthOHeightCaption
&PesquisarTabOrderOnClickBtnPesquisarClick
Glyph.Data
z  v  BMv      v   (                                    ?  ?   ?? ?   ? ? ??   ???   ?  ?   ?? ?   ? ? ??  ??? 333333333333?333333<333333?w?3333<???33337w73333?3333ssw?33< ????33?w3773<????37w?33sw???????ss?377 ?????w37?33sw??????s?3s?3770??????7?37?3?s3??? 33s?3s?w330??? 3337?37w3333?33333s?s333330 3333337w333333333333333333333333333333333333	NumGlyphs  TBitBtnBtnSairLeft Top
WidthGHeightCaptionSai&rTabOrderOnClickBtnSairClick
Glyph.Data
z  v  BMv      v   (                                    ?  ?   ?? ?   ? ? ??   ???   ?  ?   ?? ?   ? ? ??  ??? 3     33wwwww33????33w?33333???33s?3333???337?3333??3333333??3333333??3333333??3333333??3333333??333?333???333w3333??3333333??33?3333???333333???33w??33     33wwwwws3	NumGlyphs   	TGroupBox	GroupBox2LeftTop?WidthzHeight+TabOrder TDBNavigatorDBNavigator1Left? TopWidth? Height
DataSourceDmPrincipal.DSClientesVisibleButtonsnbFirstnbPriornbNextnbLast TabOrder OnClickDBNavigator1Click    