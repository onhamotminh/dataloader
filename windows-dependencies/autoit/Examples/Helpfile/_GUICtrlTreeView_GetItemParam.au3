#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <WindowsConstants.au3>

$Debug_TV = False ; Check ClassName being passed to functions, set to True and use a handle to another control to see it work

; Warning do not use SetItemParam on items created with GUICtrlCreateTreeViewItem
; Param is the controlId for items created with the built-in function

Example_Internal()
Example_External()

Func Example_Internal()

	Local $hItem[10], $hItemChild[30], $iYIndex = 0, $iRand, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	GUICreate("TreeView Get Item Param", 400, 300)

	$hTreeView = GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState()

	_GUICtrlTreeView_BeginUpdate($hTreeView)
	For $x = 0 To 9
		$hItem[$x] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Item", $x), $hTreeView)
		For $y = $iYIndex To $iYIndex + 2
			$hItemChild[$y] = GUICtrlCreateTreeViewItem(StringFormat("[%02d] New Child Item", $y), $hItem[$x])
		Next
		$iYIndex += 3
	Next
	_GUICtrlTreeView_EndUpdate($hTreeView)

	$iRand = Random(0, 9, 1)
	MsgBox(4160, "Information", StringFormat("Item Param/ID for index %d: %s\r\nIsPtr = %d IsHWnd = %d", $iRand, _GUICtrlTreeView_GetItemParam($hTreeView, $hItem[$iRand]), _
			IsPtr(_GUICtrlTreeView_GetItemHandle($hTreeView, $hItem[$iRand])), IsHWnd(_GUICtrlTreeView_GetItemHandle($hTreeView, $hItem[$iRand]))))
	$iRand = Random(0, 29, 1)
	MsgBox(4160, "Information", StringFormat("Item Param/ID for child index %d: %s", $iRand, _GUICtrlTreeView_GetItemParam($hTreeView, $hItemChild[$iRand])))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example_Internal

Func Example_External()

	Local $GUI, $hItem[10], $hItemChild[30], $iYIndex = 0, $iRand, $iParam = 1, $hTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	$GUI = GUICreate("(UDF Created) TreeView Get Item Param", 400, 300)

	$hTreeView = _GUICtrlTreeView_Create($GUI, 2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE)
	GUISetState()

	_GUICtrlTreeView_BeginUpdate($hTreeView)
	For $x = 0 To 9
		$hItem[$x] = _GUICtrlTreeView_Add($hTreeView, 0, StringFormat("[%02d] New Item", $x))
		_GUICtrlTreeView_SetItemParam($hTreeView, $hItem[$x], $iParam)
		$iParam += 1
		For $y = $iYIndex To $iYIndex + 2
			$hItemChild[$y] = _GUICtrlTreeView_AddChild($hTreeView, $hItem[$x], StringFormat("[%02d] New Item", $y))
			_GUICtrlTreeView_SetItemParam($hTreeView, $hItemChild[$y], $iParam)
			$iParam += 1
		Next
		$iYIndex += 3
	Next
	_GUICtrlTreeView_EndUpdate($hTreeView)

	$iRand = Random(0, 9, 1)
	MsgBox(4160, "Information", StringFormat("Item Param/ID for index %d: %s\r\nIsPtr = %d IsHWnd = %d", $iRand, _GUICtrlTreeView_GetItemParam($hTreeView, $hItem[$iRand]), _
			IsPtr(_GUICtrlTreeView_GetItemHandle($hTreeView, $hItem[$iRand])), IsHWnd(_GUICtrlTreeView_GetItemHandle($hTreeView, $hItem[$iRand]))))
	$iRand = Random(0, 29, 1)
	MsgBox(4160, "Information", StringFormat("Item Param for child index %d: %s", $iRand, _GUICtrlTreeView_GetItemParam($hTreeView, $hItemChild[$iRand])))

	; Loop until user exits
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>Example_External
