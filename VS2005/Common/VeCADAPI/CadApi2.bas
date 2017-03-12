Attribute VB_Name = "CadApi2"

Public Declare Sub      CadInsBlockPutY Lib "vecad.dll" (ByVal hEnt As Long, ByVal Y As Double)
Public Declare Function CadInsBlockGetZ Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadInsBlockPutZ Lib "vecad.dll" (ByVal hEnt As Long, ByVal Z As Double)
Public Declare Sub      CadInsBlockGetPoint Lib "vecad.dll" (ByVal hEnt As Long, ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long)
Public Declare Sub      CadInsBlockPutPoint Lib "vecad.dll" (ByVal hEnt As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double)
Public Declare Function CadInsBlockGetScale Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadInsBlockPutScale Lib "vecad.dll" (ByVal hEnt As Long, ByVal Scal As Double)
Public Declare Function CadInsBlockGetScaleX Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadInsBlockPutScaleX Lib "vecad.dll" (ByVal hEnt As Long, ByVal Sx As Double)
Public Declare Function CadInsBlockGetScaleY Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadInsBlockPutScaleY Lib "vecad.dll" (ByVal hEnt As Long, ByVal Sy As Double)
Public Declare Function CadInsBlockGetScaleZ Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadInsBlockPutScaleZ Lib "vecad.dll" (ByVal hEnt As Long, ByVal Sz As Double)
Public Declare Function CadInsBlockGetAngle Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadInsBlockPutAngle Lib "vecad.dll" (ByVal hEnt As Long, ByVal Angle As Double)
Public Declare Function CadInsBlockGetNumRows Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadInsBlockPutNumRows Lib "vecad.dll" (ByVal hEnt As Long, ByVal NumRows As Long)
Public Declare Function CadInsBlockGetNumCols Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadInsBlockPutNumCols Lib "vecad.dll" (ByVal hEnt As Long, ByVal NumCols As Long)
Public Declare Function CadInsBlockGetRowDist Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadInsBlockPutRowDist Lib "vecad.dll" (ByVal hEnt As Long, ByVal RowDist As Double)
Public Declare Function CadInsBlockGetColDist Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadInsBlockPutColDist Lib "vecad.dll" (ByVal hEnt As Long, ByVal ColDist As Double)
Public Declare Function CadInsBlockHasAttribs Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Function CadInsBlockGetFirstAtt Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Function CadInsBlockGetNextAtt Lib "vecad.dll" (ByVal hEnt As Long, ByVal hAtt As Long) As Long
Public Declare Function CadAddAttrib Lib "vecad.dll" (ByVal hDwg As Long, ByVal szTag As String, ByVal szDefValue As String, ByVal X As Double, ByVal Y As Double, ByVal Z As Double) As Long
Public Declare Function CadAttGetStyleID Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadAttPutStyleID Lib "vecad.dll" (ByVal hEnt As Long, ByVal Id As Long)
Public Declare Sub      CadAttGetPoint Lib "vecad.dll" (ByVal hEnt As Long, ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long)
Public Declare Sub      CadAttPutPoint Lib "vecad.dll" (ByVal hEnt As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double)
Public Declare Sub      CadAttGetTag Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As Any, ByVal MaxChars As Long)
Public Declare Sub      CadAttPutTag Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As String)
Public Declare Sub      CadAttGetPrompt Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As Any, ByVal MaxChars As Long)
Public Declare Sub      CadAttPutPrompt Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As String)
Public Declare Sub      CadAttGetDefValue Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As Any, ByVal MaxChars As Long)
Public Declare Sub      CadAttPutDefValue Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As String)
Public Declare Sub      CadAttGetValue Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As Any, ByVal MaxChars As Long)
Public Declare Sub      CadAttPutValue Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As String)
Public Declare Function CadAttGetAngle Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadAttPutAngle Lib "vecad.dll" (ByVal hEnt As Long, ByVal Angle As Double)
Public Declare Function CadAttGetHeight Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadAttPutHeight Lib "vecad.dll" (ByVal hEnt As Long, ByVal Height As Double)
Public Declare Function CadAttGetWidth Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadAttPutWidth Lib "vecad.dll" (ByVal hEnt As Long, ByVal Width As Double)
Public Declare Function CadAttGetOblique Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadAttPutOblique Lib "vecad.dll" (ByVal hEnt As Long, ByVal Angle As Double)
Public Declare Function CadAttGetAlign Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadAttPutAlign Lib "vecad.dll" (ByVal hEnt As Long, ByVal Align As Long)
Public Declare Function CadAttGetBackward Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadAttPutBackward Lib "vecad.dll" (ByVal hEnt As Long, ByVal bBackward As Long)
Public Declare Function CadAttGetUpsideDown Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadAttPutUpsideDown Lib "vecad.dll" (ByVal hEnt As Long, ByVal bUpsideDown As Long)
Public Declare Function CadAttGetMode Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadAttPutMode Lib "vecad.dll" (ByVal hEnt As Long, ByVal Mode As Long)
Public Declare Function CadAddImage Lib "vecad.dll" (ByVal hDwg As Long, ByVal szFileName As String, ByVal X As Double, ByVal Y As Double, ByVal Z As Double, ByVal Scal As Double) As Long
Public Declare Function CadAddImagePlace Lib "vecad.dll" (ByVal hDwg As Long, ByVal Id As Long, ByVal Width As Long, ByVal Height As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double, ByVal Scal As Double) As Long
Public Declare Sub      CadImageGetFile Lib "vecad.dll" (ByVal hEnt As Long, ByVal szFileName As Any)
Public Declare Sub      CadImagePutFile Lib "vecad.dll" (ByVal hEnt As Long, ByVal szFileName As String)
Public Declare Function CadImageGetX Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadImagePutX Lib "vecad.dll" (ByVal hEnt As Long, ByVal X As Double)
Public Declare Function CadImageGetY Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadImagePutY Lib "vecad.dll" (ByVal hEnt As Long, ByVal Y As Double)
Public Declare Function CadImageGetZ Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadImagePutZ Lib "vecad.dll" (ByVal hEnt As Long, ByVal Z As Double)
Public Declare Sub      CadImageGetPoint Lib "vecad.dll" (ByVal hEnt As Long, ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long)
Public Declare Sub      CadImagePutPoint Lib "vecad.dll" (ByVal hEnt As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double)
Public Declare Function CadImageGetScale Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadImagePutScale Lib "vecad.dll" (ByVal hEnt As Long, ByVal Scal As Double)
Public Declare Function CadImageGetScaleX Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadImagePutScaleX Lib "vecad.dll" (ByVal hEnt As Long, ByVal Sx As Double)
Public Declare Function CadImageGetScaleY Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadImagePutScaleY Lib "vecad.dll" (ByVal hEnt As Long, ByVal Sy As Double)
Public Declare Sub      CadImagePutSize Lib "vecad.dll" (ByVal hEnt As Long, ByVal Width As Long, ByVal Height As Long)
Public Declare Function CadAddHatchPoint Lib "vecad.dll" (ByVal hDwg As Long, ByVal X As Double, ByVal Y As Double) As Long
Public Declare Function CadAddHatchPath Lib "vecad.dll" (ByVal hDwg As Long, ByVal hEnt As Long) As Long
Public Declare Function CadAddHatch Lib "vecad.dll" (ByVal hDwg As Long, ByVal szFileName As String, ByVal szPatName As String, ByVal Scal As Double, ByVal Angle As Double) As Long
Public Declare Function CadEngrave Lib "vecad.dll" (ByVal hDwg As Long, ByVal bSelected As Long, ByVal szBlockName As String, ByVal Step As Double, ByVal Angle As Double) As Long
Public Declare Sub      CadHatchPutPattern Lib "vecad.dll" (ByVal hEnt As Long, ByVal szFileName As String, ByVal szPatName As String)
Public Declare Sub      CadHatchGetName Lib "vecad.dll" (ByVal hEnt As Long, ByVal szName As Any)
Public Declare Function CadHatchGetPattern Lib "vecad.dll" (ByVal hEnt As Long, ByVal szPattern As Any) As Long
Public Declare Sub      CadHatchPutScale Lib "vecad.dll" (ByVal hEnt As Long, ByVal Scal As Double)
Public Declare Function CadHatchGetScale Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Sub      CadHatchPutAngle Lib "vecad.dll" (ByVal hEnt As Long, ByVal Angle As Double)
Public Declare Function CadHatchGetAngle Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Function CadHatchGetSize Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Function CadAddDimPoint Lib "vecad.dll" (ByVal Index As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double) As Long
Public Declare Function CadAddDim Lib "vecad.dll" (ByVal hDwg As Long, ByVal DimType As Long) As Long
Public Declare Function CadDimGetStyleID Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadDimPutStyleID Lib "vecad.dll" (ByVal hEnt As Long, ByVal Id As Long)
Public Declare Sub      CadDimPutText Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As String)
Public Declare Sub      CadDimGetText Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As Any)
Public Declare Sub      CadDimGetPoint Lib "vecad.dll" (ByVal hEnt As Long, ByVal Index As Long, ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long)
Public Declare Sub      CadDimPutPoint Lib "vecad.dll" (ByVal hEnt As Long, ByVal Index As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double)
Public Declare Function CadDimGetType Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Function CadDimGetValue Lib "vecad.dll" (ByVal hEnt As Long) As Double
Public Declare Function CadAddLeader Lib "vecad.dll" (ByVal hDwg As Long, ByVal szText As String) As Long
Public Declare Function CadLeaderGetNumVers Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadLeaderPutNumVers Lib "vecad.dll" (ByVal hEnt As Long, ByVal nVers As Long)
Public Declare Sub      CadLeaderGetVer Lib "vecad.dll" (ByVal hEnt As Long, ByVal iVer As Long, ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long)
Public Declare Sub      CadLeaderPutVer Lib "vecad.dll" (ByVal hEnt As Long, ByVal iVer As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double)
Public Declare Function CadLeaderGetSpline Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadLeaderPutSpline Lib "vecad.dll" (ByVal hEnt As Long, ByVal bSpline As Long)
Public Declare Function CadLeaderGetTextLen Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadLeaderGetText Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As Any, ByVal MaxChars As Long)
Public Declare Sub      CadLeaderPutText Lib "vecad.dll" (ByVal hEnt As Long, ByVal szText As String)
Public Declare Function CadAddCustom Lib "vecad.dll" (ByVal hDwg As Long, ByVal CustType As Long, ByVal pData As Any, ByVal nBytes As Long) As Long
Public Declare Sub      CadCustomPutOwner Lib "vecad.dll" (ByVal hEnt As Long, ByVal pObject As Any)
Public Declare Function CadCustomGetOwner Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Function CadCustomGetType Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadCustomPutData Lib "vecad.dll" (ByVal hEnt As Long, ByVal pData As Any, ByVal nBytes As Long)
Public Declare Sub      CadCustomGetData Lib "vecad.dll" (ByVal hEnt As Long, ByVal pData As Any)
Public Declare Function CadCustomGetSize Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Function CadCustomGetDataPtr Lib "vecad.dll" (ByVal hEnt As Long) As Long
Public Declare Sub      CadDrawSet Lib "vecad.dll" (ByVal Mode As Long, ByVal Value As Long)
Public Declare Function CadDrawGetDC Lib "vecad.dll" () As Long
Public Declare Sub      CadDrawAddVertex Lib "vecad.dll" (ByVal X As Double, ByVal Y As Double, ByVal Z As Double)
Public Declare Function CadDrawGenArc Lib "vecad.dll" (ByVal Xcen As Double, ByVal Ycen As Double, ByVal Zcen As Double, ByVal Radius As Double, ByVal AngStart As Double, ByVal AngArc As Double, ByVal nVers As Long) As Long
Public Declare Function CadDrawGenCircle Lib "vecad.dll" (ByVal X As Double, ByVal Y As Double, ByVal Z As Double, ByVal Radius As Double, ByVal nVers As Long) As Long
Public Declare Function CadDrawGenChar Lib "vecad.dll" (ByVal X As Double, ByVal Y As Double, ByVal Z As Double, ByVal Height As Double, ByVal Angle As Double, ByVal ScaleW As Double, ByVal UCode As Long, ByVal szFont As String, ByVal nVers As Long) As Long
Public Declare Sub      CadDrawPolyline Lib "vecad.dll" ()
Public Declare Sub      CadDrawPolygon Lib "vecad.dll" ()
Public Declare Sub      CadDrawPolyPolygon Lib "vecad.dll" (ByVal PlineSize As Long, ByVal nPline As Long)
Public Declare Sub      CadDrawLine Lib "vecad.dll" (ByVal X1 As Double, ByVal Y1 As Double, ByVal Z1 As Double, ByVal X2 As Double, ByVal Y2 As Double, ByVal Z2 As Double)
Public Declare Sub      CadDrawPoint Lib "vecad.dll" (ByVal X As Double, ByVal Y As Double, ByVal Z As Double, ByVal PtMode As Long, ByVal PtSize As Double)
Public Declare Sub      CadDrawText Lib "vecad.dll" (ByVal hDwg As Long, ByVal szText As String, ByVal X As Double, ByVal Y As Double, ByVal Z As Double)
Public Declare Sub      CadDrawBlock Lib "vecad.dll" (ByVal hDwg As Long, ByVal hBlock As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double, ByVal ScaleX As Double, ByVal ScaleY As Double, ByVal ScaleZ As Double, ByVal RotAngle As Double)
Public Declare Function CadAddCustProp Lib "vecad.dll" (ByVal IdProp As Long, ByVal szName As String, ByVal szValue As String, ByVal ValType As Long) As Long
Public Declare Function CadSetCustProp Lib "vecad.dll" (ByVal IdProp As Long, ByVal szValue As String) As Long
Public Declare Function CadSetCustPropMode Lib "vecad.dll" (ByVal IdProp As Long, ByVal bReadOnly As Long) As Long
Public Declare Function CadAddCommand Lib "vecad.dll" (ByVal hDwg As Long, ByVal Id As Long, ByVal szCmdName As String, ByVal szAlias As String, ByVal hCurs As Long, ByVal pFunc1 As Any, ByVal pFunc2 As Any) As Long
Public Declare Sub      CadCmdPutData Lib "vecad.dll" (ByVal hDwg As Long, ByVal pData As Any, ByVal nBytes As Long)
Public Declare Sub      CadCmdGetData Lib "vecad.dll" (ByVal hDwg As Long, ByVal pData As Any)
Public Declare Function CadCmdGetSize Lib "vecad.dll" (ByVal hDwg As Long) As Long
Public Declare Sub      CadCmdPrompt Lib "vecad.dll" (ByVal hDwg As Long, ByVal szText As String, ByVal szDefaultValue As String)
Public Declare Sub      CadCmdPromptAdd Lib "vecad.dll" (ByVal hDwg As Long, ByVal szValue As String)
Public Declare Function CadCmdUserSelect Lib "vecad.dll" (ByVal hDwg As Long) As Long
Public Declare Function CadCmdUserGetEntity Lib "vecad.dll" (ByVal hDwg As Long) As Long
Public Declare Function CadCmdUserInput Lib "vecad.dll" (ByVal hDwg As Long) As Long
Public Declare Sub      CadCmdGetInputPoint Lib "vecad.dll" (ByVal hDwg As Long, ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long)
Public Declare Sub      CadCmdGetInputStr Lib "vecad.dll" (ByVal hDwg As Long, ByVal szText As Any)
Public Declare Function CadCmdStrToPoint Lib "vecad.dll" (ByVal hDwg As Long, ByVal szValue As String, ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long) As Long
Public Declare Sub      CadCmdSetBasePoint Lib "vecad.dll" (ByVal hDwg As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double)
Public Declare Function CadCmdAddPoint Lib "vecad.dll" (ByVal hDwg As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double) As Long
Public Declare Function CadCmdGetPoint Lib "vecad.dll" (ByVal hDwg As Long, ByVal iPoint As Long, ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long) As Long
Public Declare Function CadCmdCountPoints Lib "vecad.dll" (ByVal hDwg As Long) As Long
Public Declare Sub      CadSelClear Lib "vecad.dll" (ByVal hDwg As Long)
Public Declare Sub      CadSelectEntity Lib "vecad.dll" (ByVal hDwg As Long, ByVal hEnt As Long, ByVal bSelect As Long)
Public Declare Function CadSelectByLayer Lib "vecad.dll" (ByVal hDwg As Long, ByVal bSelect As Long) As Long
Public Declare Function CadSelectByPage Lib "vecad.dll" (ByVal hDwg As Long, ByVal bSelect As Long) As Long
Public Declare Function CadSelectByPolyline Lib "vecad.dll" (ByVal hDwg As Long, ByVal hEnt As Long, ByVal bSelect As Long) As Long
Public Declare Function CadSelectByPolygon Lib "vecad.dll" (ByVal hDwg As Long, ByVal hEnt As Long, ByVal bCross As Long, ByVal bSelect As Long) As Long
Public Declare Function CadSelectByDist Lib "vecad.dll" (ByVal hDwg As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double, ByVal Dist As Double, ByVal bCross As Long, ByVal bSelect As Long) As Long
Public Declare Function CadSelCount Lib "vecad.dll" (ByVal hDwg As Long) As Long
Public Declare Function CadSelGetFirstPtr Lib "vecad.dll" (ByVal hDwg As Long) As Long
Public Declare Function CadSelGetNextPtr Lib "vecad.dll" (ByVal hDwg As Long, ByVal hPtr As Long) As Long
Public Declare Sub      CadSelErase Lib "vecad.dll" (ByVal hDwg As Long)
Public Declare Sub      CadSelCopy Lib "vecad.dll" (ByVal hDwg As Long)
Public Declare Sub      CadSelMove Lib "vecad.dll" (ByVal hDwg As Long, ByVal dx As Double, ByVal dy As Double, ByVal dz As Double)
Public Declare Sub      CadSelScale Lib "vecad.dll" (ByVal hDwg As Long, ByVal x0 As Double, ByVal y0 As Double, ByVal z0 As Double, ByVal Scal As Double)
Public Declare Sub      CadSelRotate Lib "vecad.dll" (ByVal hDwg As Long, ByVal x0 As Double, ByVal y0 As Double, ByVal z0 As Double, ByVal Angle As Double)
Public Declare Sub      CadSelMirror Lib "vecad.dll" (ByVal hDwg As Long, ByVal x0 As Double, ByVal y0 As Double, ByVal z0 As Double, ByVal x1 As Double, ByVal y1 As Double, ByVal z1 As Double)
Public Declare Sub      CadSelExplode Lib "vecad.dll" (ByVal hDwg As Long)
Public Declare Function CadSelJoin Lib "vecad.dll" (ByVal hDwg As Long, ByVal Delta As Double) As Long
Public Declare Sub      CadSelColor Lib "vecad.dll" (ByVal hDwg As Long, ByVal Color As Long)
Public Declare Sub      CadSelDraw Lib "vecad.dll" (ByVal hDwg As Long, ByVal hDC As Long, ByVal WinLef As Long, ByVal WinBot As Long, ByVal WinW As Long, ByVal WinH As Long, ByVal ViewLef As Double, ByVal ViewBot As Double, ByVal ViewW As Double, ByVal ViewH As Double, ByVal idPage As Long, ByVal FillColor As Long, ByVal BordColor As Long, ByVal LwScale As Double)
Public Declare Sub      CadSelMakeGrips Lib "vecad.dll" (ByVal hDwg As Long)
Public Declare Function CadCbPaste Lib "vecad.dll" (ByVal hDwg As Long, ByVal hWnd As Long, ByVal dx As Double, ByVal dy As Double, ByVal dz As Double) As Long
Public Declare Function CadCountEntities Lib "vecad.dll" (ByVal hDwg As Long) As Long
Public Declare Sub      CadViewPutPoint Lib "vecad.dll" (ByVal hDwg As Long, ByVal hWin As Long, ByVal X As Double, ByVal Y As Double, ByVal Z As Double)
Public Declare Sub      CadViewGetPoint Lib "vecad.dll" (ByVal hDwg As Long, ByVal hWin As Long, ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long)
Public Declare Function CadViewGetPointX Lib "vecad.dll" (ByVal hDwg As Long) As Double
Public Declare Function CadViewGetPointY Lib "vecad.dll" (ByVal hDwg As Long) As Double
Public Declare Function CadViewGetPointZ Lib "vecad.dll" (ByVal hDwg As Long) As Double
Public Declare Sub      CadViewPutAngles Lib "vecad.dll" (ByVal hDwg As Long, ByVal hWin As Long, ByVal AngHor As Double, ByVal AngVer As Double)
Public Declare Function CadViewGetAngleHor Lib "vecad.dll" (ByVal hDwg As Long) As Double
Public Declare Function CadViewGetAngleVer Lib "vecad.dll" (ByVal hDwg As Long) As Double
Public Declare Sub      CadViewRect Lib "vecad.dll" (ByVal hDwg As Long, ByVal hWin As Long, ByVal Xmin As Double, ByVal Ymin As Double, ByVal Xmax As Double, ByVal Ymax As Double)
Public Declare Sub      CadViewScale Lib "vecad.dll" (ByVal hDwg As Long, ByVal hWin As Long, ByVal Scal As Double, ByVal Xcen As Long, ByVal Ycen As Long)
Public Declare Sub      CadCoordModelToDisp Lib "vecad.dll" (ByVal hDwg As Long, ByVal Xm As Double, ByVal Ym As Double, ByVal Zm As Double, ByVal pXd As Long, ByVal pYd As Long)
Public Declare Sub      CadCoordModelToWin Lib "vecad.dll" (ByVal hDwg As Long, ByVal Xm As Double, ByVal Ym As Double, ByVal Zm As Double, ByVal pXw As Long, ByVal pYw As Long)
Public Declare Sub      CadCoordDispToModel Lib "vecad.dll" (ByVal hDwg As Long, ByVal Xd As Double, ByVal Yd As Double, ByVal pXm As Long, ByVal pYm As Long, ByVal pZm As Long)
Public Declare Sub      CadCoordDispToWin Lib "vecad.dll" (ByVal hDwg As Long, ByVal Xd As Double, ByVal Yd As Double, ByVal pXw As Long, ByVal pYw As Long)
Public Declare Sub      CadCoordWinToModel Lib "vecad.dll" (ByVal hDwg As Long, ByVal Xw As Long, ByVal Yw As Long, ByVal pXm As Long, ByVal pYm As Long, ByVal pZm As Long)
Public Declare Sub      CadCoordWinToDisp Lib "vecad.dll" (ByVal hDwg As Long, ByVal Xw As Long, ByVal Yw As Long, ByVal pXd As Long, ByVal pYd As Long)
Public Declare Function CadDistWinToModel Lib "vecad.dll" (ByVal hDwg As Long, ByVal Dwin As Long) As Double
Public Declare Function CadDistModelToWin Lib "vecad.dll" (ByVal hDwg As Long, ByVal Dmod As Double) As Long
Public Declare Sub      CadPrintGetRect Lib "vecad.dll" (ByVal pLeft As Long, ByVal pBottom As Long, ByVal pRight As Long, ByVal pTop As Long)
Public Declare Sub      CadPrintPutRect Lib "vecad.dll" (ByVal Left As Double, ByVal Bottom As Double, ByVal Right As Double, ByVal Top As Double)
Public Declare Sub      CadPrintPutScale Lib "vecad.dll" (ByVal Scal As Double)
Public Declare Function CadPrintGetScale Lib "vecad.dll" () As Double
Public Declare Sub      CadPrintPutScaleLW Lib "vecad.dll" (ByVal bScaleLW As Long)
Public Declare Function CadPrintGetScaleLW Lib "vecad.dll" () As Long
Public Declare Sub      CadPrintPutOffset Lib "vecad.dll" (ByVal DX As Double, ByVal DY As Double)
Public Declare Sub      CadPrintGetOffset Lib "vecad.dll" (ByVal pDX As Long, ByVal pDY As Long)
Public Declare Sub      CadPrintPutColor Lib "vecad.dll" (ByVal bColor As Long)
Public Declare Function CadPrintGetColor Lib "vecad.dll" () As Long
Public Declare Sub      CadPrintPutCopies Lib "vecad.dll" (ByVal Ncopy As Long)
Public Declare Function CadPrintGetCopies Lib "vecad.dll" () As Long
Public Declare Sub      CadPrintPutOrient Lib "vecad.dll" (ByVal Orient As Long)
Public Declare Function CadPrintGetOrient Lib "vecad.dll" () As Long
Public Declare Sub      CadPrintPutStampPos Lib "vecad.dll" (ByVal Pos As Long)
Public Declare Function CadPrintGetStampPos Lib "vecad.dll" () As Long
Public Declare Sub      CadPrintPutStampSize Lib "vecad.dll" (ByVal TextHeight As Double)
Public Declare Function CadPrintGetStampSize Lib "vecad.dll" () As Double
Public Declare Sub      CadPrintPutStampColor Lib "vecad.dll" (ByVal Color As Long)
Public Declare Function CadPrintGetStampColor Lib "vecad.dll" () As Long
Public Declare Sub      CadPrintPutStampText Lib "vecad.dll" (ByVal szText1 As String, ByVal szText2 As String)
Public Declare Sub      CadPrintGetStampText Lib "vecad.dll" (ByVal szText1 As Any, ByVal szText2 As Any)
Public Declare Function CadPrint Lib "vecad.dll" (ByVal hDwg As Long, ByVal bPrintStamp As Long, ByVal hDC As Long) As Long
Public Declare Function CadPrintSetup Lib "vecad.dll" (ByVal hwParent As Long) As Long
Public Declare Function CadPrintGetPaperW Lib "vecad.dll" () As Double
Public Declare Function CadPrintGetPaperH Lib "vecad.dll" () As Double
Public Declare Sub      CadPrintGetPaperSize Lib "vecad.dll" (ByVal pWidth As Long, ByVal pHeight As Long)
Public Declare Sub      CadRegen Lib "vecad.dll" (ByVal hDwg As Long)
Public Declare Sub      CadUpdate Lib "vecad.dll" (ByVal hDwg As Long)
Public Declare Function CadWndCreate Lib "vecad.dll" (ByVal hDwg As Long, ByVal hWndParent As Long, ByVal CadStyle As Long, ByVal X As Long, ByVal Y As Long, ByVal W As Long, ByVal H As Long) As Long
Public Declare Function CadWndResize Lib "vecad.dll" (ByVal hWin As Long, ByVal X As Long, ByVal Y As Long, ByVal W As Long, ByVal H As Long) As Long
Public Declare Function CadWndRedraw Lib "vecad.dll" (ByVal hWin As Long) As Long
Public Declare Function CadWndSetFocus Lib "vecad.dll" (ByVal hWin As Long) As Long
Public Declare Sub      CadAccelSetKey Lib "vecad.dll" (ByVal Command As Long, ByVal VirtKey As Long, ByVal Flags As Long)
Public Declare Sub      CadAccelSetDefault Lib "vecad.dll" ()
Public Declare Function CadCWCreate Lib "vecad.dll" (ByVal hwParent As Long, ByVal Left As Long, ByVal Top As Long, ByVal Width As Long, ByVal Height As Long) As Long
Public Declare Sub      CadCWDelete Lib "vecad.dll" ()
Public Declare Function CadCWResize Lib "vecad.dll" (ByVal Left As Long, ByVal Top As Long, ByVal Width As Long, ByVal Height As Long) As Long
Public Declare Sub      CadMagPutSize Lib "vecad.dll" (ByVal Size As Long)
Public Declare Function CadMagGetSize Lib "vecad.dll" () As Long
Public Declare Sub      CadMagPutScale Lib "vecad.dll" (ByVal Scal As Long)
Public Declare Function CadMagGetScale Lib "vecad.dll" () As Long
Public Declare Sub      CadMagPutPos Lib "vecad.dll" (ByVal Pos As Long)
Public Declare Function CadMagGetPos Lib "vecad.dll" () As Long
Public Declare Sub      CadMagPutShow Lib "vecad.dll" (ByVal bShow As Long)
Public Declare Function CadMagGetShow Lib "vecad.dll" () As Long
Public Declare Function CadNavCreate Lib "vecad.dll" (ByVal hWndParent As Long, ByVal X As Long, ByVal Y As Long, ByVal W As Long, ByVal H As Long, ByVal Flags As Long) As Long
Public Declare Sub      CadNavResize Lib "vecad.dll" (ByVal X As Long, ByVal Y As Long, ByVal W As Long, ByVal H As Long)
Public Declare Function CadNavGetParam Lib "vecad.dll" (ByVal Prm As Long) As Long
Public Declare Sub      CadNavReturnFocus Lib "vecad.dll" (ByVal bReturn As Long, ByVal hWnd As Long)
Public Declare Sub      CadNavSetLink Lib "vecad.dll" (ByVal hVecWnd As Long)
Public Declare Function CadCboxCreate Lib "vecad.dll" (ByVal CbType As Long, ByVal hwParent As Long, ByVal Left As Long, ByVal Top As Long, ByVal Width As Long, ByVal Height As Long, ByVal Hdown As Long) As Long
Public Declare Sub      CadCboxSetActive Lib "vecad.dll" (ByVal CbType As Long, ByVal hwCbox As Long)
Public Declare Sub      CadMenuClear Lib "vecad.dll" (ByVal MenuId As Long)
Public Declare Sub      CadMenuAdd Lib "vecad.dll" (ByVal MenuId As Long, ByVal szItemText As String, ByVal ItemCmd As Long)
Public Declare Function CadRecentLoad Lib "vecad.dll" (ByVal szFileName As String) As Long
Public Declare Function CadRecentSave Lib "vecad.dll" () As Long
Public Declare Function CadRecentDialog Lib "vecad.dll" (ByVal hWin As Long, ByVal szOutFileName As Any, ByVal pbShowAtStartup As Long) As Long
Public Declare Function CadRecentAdd Lib "vecad.dll" (ByVal szFileName As String) As Long
Public Declare Function CadDialogOpenFile Lib "vecad.dll" (ByVal hwParent As Long, ByVal szOutFileName As Any) As Long
Public Declare Function CadDialogSaveFile Lib "vecad.dll" (ByVal hwParent As Long, ByVal szOutFileName As Any) As Long
Public Declare Sub      CadTipOfTheDay Lib "vecad.dll" (ByVal hwParent As Long, ByVal szFileName As String, ByVal pbShowOnStartup As Long, ByVal pTipIndex As Long)
Public Declare Sub      CadHelp Lib "vecad.dll" (ByVal hWin As Long, ByVal szTopic As String)
Public Declare Sub      CadTTF2VCF Lib "vecad.dll" (ByVal hwParent As Long)
Public Declare Sub      CadSHX2VCF Lib "vecad.dll" (ByVal hwParent As Long)
Public Declare Sub      CadFontsList Lib "vecad.dll" (ByVal hwParent As Long)
Public Declare Sub      CadPluginsDlg Lib "vecad.dll" (ByVal hwParent As Long)
Public Declare Function CadGetError Lib "vecad.dll" () As Long
Public Declare Sub      CadGetErrorStr Lib "vecad.dll" (ByVal ErrCode As Long, ByVal szStr As Any)
Public Declare Sub      CadSetString Lib "vecad.dll" (ByVal IdStr As Long, ByVal szStr As String)
Public Declare Function CadPluginImageRead Lib "vecad.dll" (ByVal szExt As String, ByVal szLibName As String, ByVal szFuncName As String, ByVal Mode As Long) As Long
Public Declare Function CadConvertAcadFile Lib "vecad.dll" (ByVal szInFile As String, ByVal szOutFile As String) As Long
Public Declare Function CadExtractImage Lib "vecad.dll" (ByVal szFileName As String, ByVal Buffer As Any) As Long
Public Declare Sub      CadGetVBString Lib "vecad.dll" (ByVal Val As Long, ByVal szStr As Any)
Public Declare Function vuGetWindowSize Lib "vecad.dll" (ByVal hWin As Long, ByVal pW As Long, ByVal pH As Long) As Long
Public Declare Function CadGetWindowSize Lib "vecad.dll" (ByVal hWin As Long, ByVal pW As Long, ByVal pH As Long) As Long
Public Declare Function vuCompress Lib "vecad.dll" (ByVal Dest As Any, ByVal DestMaxLen As Long, ByVal Source As Any, ByVal SourceLen As Long, ByVal Level As Long) As Long
Public Declare Function vuExpand Lib "vecad.dll" (ByVal Dest As Any, ByVal DestMaxLen As Long, ByVal Source As Any, ByVal SourceLen As Long) As Long
Public Declare Sub      vuRotatePoint Lib "vecad.dll" (ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long, ByVal Xcen As Double, ByVal Ycen As Double, ByVal Zcen As Double, ByVal Angle As Double, ByVal Plane As Long)
Public Declare Sub      vuPolarPoint Lib "vecad.dll" (ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long, ByVal Angle As Double, ByVal Dist As Double, ByVal Plane As Long)
Public Declare Sub      vuScalePoint Lib "vecad.dll" (ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long, ByVal Xcen As Double, ByVal Ycen As Double, ByVal Zcen As Double, ByVal ScaleX As Double, ByVal ScaleY As Double, ByVal ScaleZ As Double)
Public Declare Sub      vuMirrorPoint Lib "vecad.dll" (ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long, ByVal A1 As Double, ByVal B1 As Double, ByVal Plane As Long)
Public Declare Function vuGetAngle Lib "vecad.dll" (ByVal x1 As Double, ByVal y1 As Double, ByVal z1 As Double, ByVal x2 As Double, ByVal y2 As Double, ByVal z2 As Double, ByVal Plane As Long) As Double
Public Declare Function vuGetDist Lib "vecad.dll" (ByVal x1 As Double, ByVal y1 As Double, ByVal z1 As Double, ByVal x2 As Double, ByVal y2 As Double, ByVal z2 As Double, ByVal Plane As Long) As Double
Public Declare Function vuNormalizeAngle Lib "vecad.dll" (ByVal Angle As Double) As Double
Public Declare Sub      vuNumToStr Lib "vecad.dll" (ByVal Val As Double, ByVal szOutStr As Any, ByVal MaxDec As Long, ByVal bTrimZero As Long, ByVal bRemainPoint As Long)
Public Declare Function CadAddRPlan Lib "vecad.dll" (ByVal hDwg As Long) As Long
Public Declare Sub      CadRPlanClear Lib "vecad.dll" (ByVal hRPlan As Long)
Public Declare Sub      CadRPlanSetStart Lib "vecad.dll" (ByVal hRPlan As Long, ByVal X As Double, ByVal Y As Double, ByVal Dist As Double, ByVal DirAngle As Double)
Public Declare Function CadRPlanAddCurve Lib "vecad.dll" (ByVal hRPlan As Long, ByVal Dist As Double, ByVal RotAngle As Double, ByVal Turn As Long, ByVal Rad As Double, ByVal Len1 As Double, ByVal Len2 As Double) As Long
Public Declare Sub      CadRPlanSetEnd Lib "vecad.dll" (ByVal hRPlan As Long, ByVal Dist As Double)
Public Declare Sub      CadRPlanUpdate Lib "vecad.dll" (ByVal hRPlan As Long)
Public Declare Sub      CadRPlanSetScale Lib "vecad.dll" (ByVal hRPlan As Long, ByVal Scal As Double)
Public Declare Function CadRPlanGetNumRec Lib "vecad.dll" (ByVal hRPlan As Long) As Long
Public Declare Function CadRPlanGetCurveVertex Lib "vecad.dll" (ByVal hRPlan As Long, ByVal iRec As Long, ByVal pX As Long, ByVal pY As Long) As Long
Public Declare Function CadRPlanGetCurveCenter Lib "vecad.dll" (ByVal hRPlan As Long, ByVal iRec As Long, ByVal pX As Long, ByVal pY As Long) As Long
Public Declare Function CadRPlanGetCurveStart Lib "vecad.dll" (ByVal hRPlan As Long, ByVal iRec As Long, ByVal pX As Long, ByVal pY As Long, ByVal pDirAngle As Long) As Long
Public Declare Function CadRPlanGetCurveEnd Lib "vecad.dll" (ByVal hRPlan As Long, ByVal iRec As Long, ByVal pX As Long, ByVal pY As Long, ByVal pDirAngle As Long) As Long
Public Declare Function CadRPlanAddGrPoint Lib "vecad.dll" (ByVal hRPlan As Long, ByVal Dist As Double, ByVal Offset As Double, ByVal Z As Double) As Long
Public Declare Function CadRPlanGenLevels Lib "vecad.dll" (ByVal hRPlan As Long, ByVal CellSize As Double, ByVal ZStep As Double, ByVal ZStepBold As Double) As Long
Public Declare Function CadRPlanGetPoint Lib "vecad.dll" (ByVal hRPlan As Long, ByVal Dist As Double, ByVal pX As Long, ByVal pY As Long, ByVal pZ As Long, ByVal pDirAngle As Long) As Long
Public Declare Function CadRPlanGetDist Lib "vecad.dll" (ByVal hRPlan As Long, ByVal X As Double, ByVal Y As Double, ByVal Delta As Double, ByVal pDist As Long, ByVal pOffset As Long) As Long
Public Declare Function CadRPlanGetZ Lib "vecad.dll" (ByVal hRPlan As Long, ByVal X As Double, ByVal Y As Double, ByVal pZ As Long) As Long
