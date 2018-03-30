Attribute VB_Name = "workstatus_comments_working"
Dim statusWB As Workbook
Dim wStatSht As Worksheet, comDraftSht As Worksheet, wStatDraftSht As Worksheet
Dim msfoTableSht As Worksheet, usrTableSht As Worksheet
Dim workRange As Range
Dim cellsCol As Collection
Dim disableChecks As Boolean

Sub changeStatus()
    '@todo add user check to filter out status selection options
    'show only appropriate for particular user
    Call computeCmBxOptions
    bulkStatusChangeUF.Show

End Sub

Sub changeStatusDisableChecks()
    disableChecks = True
    Set helperSht = Worksheets("Helper")
    bulkStatusChangeUF.statusValCmBx.AddItem helperSht.Range("B1").Value
    bulkStatusChangeUF.statusValCmBx.AddItem helperSht.Range("B2").Value
    bulkStatusChangeUF.statusValCmBx.AddItem helperSht.Range("B3").Value
    bulkStatusChangeUF.statusValCmBx.AddItem helperSht.Range("B4").Value
    bulkStatusChangeUF.statusValCmBx.AddItem helperSht.Range("B5").Value

    Call computeCollectionFromSelection
    bulkStatusChangeUF.Show
    disableChecks = False
End Sub

Private Sub computeCmBxOptions()

    'returns cmbx rowsource for particular user and cell
    'B2 - Ввод начат
'    В3 - Данные внесены
'    В4 - Данные содержат ошибки
'    В5 -Принято
    '@todo replace isAuthorized by something like this
    
    Dim changer As Collection
    Dim helperSht As Worksheet
    Dim tmpCellVal As String

    '@todo rewrite to support multiple area selection
    If Selection.Columns.Count > 1 Then
        MsgBox "Можно выбирать ячейки в одной колонке"
        Exit Sub
    End If
    
    Call initialize_WS_variables
    Call unhide_everything


    Set changer = UsrInfo.usr_init
    Set helperSht = Worksheets("Helper")
    
    Call computeCollectionFromSelection

    
    If isExistInCol("msfo", changer("type")) Then
       bulkStatusChangeUF.statusValCmBx.AddItem helperSht.Range("B4").Value
       bulkStatusChangeUF.statusValCmBx.AddItem helperSht.Range("B5").Value
    End If
    
    If isExistInCol("user", changer("type")) Then
        'checks only first cell from selected range
        tmpCellVal = wStatSht.Range(cellsCol(1)).Value
        If tmpCellVal = "По умолчанию" Or tmpCellVal = "Данные внесены" Then
            'started
            bulkStatusChangeUF.statusValCmBx.AddItem helperSht.Range("B2").Value
        Else
            'submitted
            bulkStatusChangeUF.statusValCmBx.AddItem helperSht.Range("B3").Value
        End If
    End If
    
    Call hide_everything
End Sub

Private Sub computeCollectionFromSelection()

    Dim selectedAreas As Collection

    Set cellsCol = New Collection
    Set selectedAreas = New Collection
    
    For i = 1 To Selection.Areas.Count
        selectedAreas.Add Selection.Areas(i).Address(False, False)
    Next i
    
    For Each rangeAddrToExam In selectedAreas
        Call populateCollection(CStr(rangeAddrToExam), cellsCol)
    Next rangeAddrToExam
End Sub

Sub bulkStatusChange(statusVal)

    'Procedure for bulk status change
    
    Dim authCellsCol As Collection
    Dim changer As Collection
    Dim mailSndr As New MailSender
    Dim isAauthString As String
    Dim confirmMsg As String
    Dim selectedColsCount As Integer
    Dim recordChangeSuccess As Boolean
    

    Call initialize_WS_variables
    Call unhide_everything
    Set changer = usr_init()
    Debug.Assert Not changer Is Nothing
    wStatSht.Activate
    
    'Populate collection by cell addresses which user has selected
    Set authCellsCol = New Collection
    

    'Create collection with cell addresses to process. Clean from
    'non authorized cells
    If Not disableChecks Then
        For Each cell_addr In cellsCol
            isAauthString = isAuthorized(wStatSht.Range(cell_addr), CStr(statusVal))
            If isAauthString = "ok" Then
                authCellsCol.Add cell_addr
                Call mailSndr.collectVarMsg(CStr(cell_addr), wStatSht.Range(cell_addr).Value, CStr(statusVal))
                'Call addToMsg()
            Else
                MsgBox "Статус не может быть изменен, потому что " & isAauthString
                Call hide_everything
                Exit Sub
            End If
        Next cell_addr
        'collect message and send it
        'adds to message permanent info about user that changed status
        Call mailSndr.addPermanentMsg(changer("name"))
        If mailSndr.sendMsg Then
        
            'call record_change for each cell in collection
            'Debug.Assert False
            recordChangeSuccess = False
            For Each cell_addr In authCellsCol
                'change to
                If record_change(CStr(cell_addr), CStr(statusVal)) Then
                'If record_change(CStr(cell_addr), CStr(statusVal), True) Then
                    confirmMsg = confirmMsg + "Статус для ячейки " + cell_addr + _
                    " был изменен" + vbCrLf
                    recordChangeSuccess = True 'if at least one status changed outlook message will be sent
                Else
                    confirmMsg = confirmMsg + "Статус для ячейки " + cell_addr + _
                    " не может быть изменен, потому что у вас не хватает полномочий (check record_change)" + vbCrLf
                End If
            Next cell_addr
            
            'проверка установлен ли оутлук
            If recordChangeSuccess Then
                If mailSndr.completeSendMsg = "ok" Then
                    confirmMsg = confirmMsg + _
                    "Уведомление для успешно изменненых статусов отправлено" + _
                    " (если отправка сообщения предусмотрена)" + vbCrLf
                Else
                    confirmMsg = confirmMsg + "Уведомление не отправлено (Outlook не установлен или недоступен)" + _
                    vbCrLf
                End If
            End If
        Else 'If mailSndr.sendMsg Then
            'Debug.Assert False
            MsgBox "Статус не был изменен, сообщение не отправлено"
        End If
        
    Else 'If Not disableChecks Then
        For Each cell_addr In cellsCol
            If record_change(CStr(cell_addr), CStr(statusVal)) Then
            'If record_change(CStr(cell_addr), CStr(statusVal), True) Then
                confirmMsg = confirmMsg + "Статус для ячейки " + cell_addr + _
                " был изменен" + vbCrLf
            Else
                confirmMsg = confirmMsg + "Статус для ячейки " + cell_addr + _
                " не может быть изменен, потому что у вас не хватает полномочий (check record_change)" + vbCrLf
            End If
        Next cell_addr
        
    End If

    Call hide_everything
    If confirmMsg <> "" Then MsgBox confirmMsg
End Sub


Function record_change(changeCellAddr As String, inStatVal As String, Optional debugFlag As Boolean) As Boolean
    Dim srcWSht As Worksheet ', destWSht As Worksheet
    Dim srcCellFormula As String ', destCellFormula As String
    Dim compVal As String, dsVal As String, timeVal As String, statusVal As String
    Dim compValAddr As String
    Dim tmpArray As Variant
    
If Not debugFlag Then
    'Call unhide_everything
    Set srcWSht = Sheets("WorkStatusDraft")
    srcWSht.Select
    'Set destWSht = Sheets("Changed1")
    srcCellFormula = srcWSht.Range(changeCellAddr).Formula
    'destWSht.Activate
    'Range(changeCellAddr).Formula = srcCellFormula
    
    tmpArray = Split(srcCellFormula, ",")
    compValAddr = Left(tmpArray(4), Len(tmpArray(4)) - 1)
    timeVal = Range(tmpArray(2)).Value
    dsVal = Range(tmpArray(3)).Value
    compVal = Range(compValAddr).Value
    Sheets("WorkStatus").Activate
    statusVal = inStatVal
    Debug.Assert compVal <> "" Or dsVal <> "" Or timeVal <> "" Or statusVal <> ""
    Call wsChangePrep(compVal, dsVal, timeVal, statusVal)
    'Call hide_everything
    If ws_change_module.statusChanged Then
        record_change = True
        Sheets("WorkStatus").Range(changeCellAddr).Value = inStatVal
    End If
End If
    'record_change = True
End Function


Sub refreshSht()

    Application.Run "MNU_eSUBMIT_REFSCHEDULE_SHEET_REFRESH"

End Sub


Sub refresh()

    Application.Run "MNU_eTOOLS_REFRESH"

End Sub

Sub readComments()
    
    Dim tmpCell As Range
    Dim clw As New CellWorker
    Dim endRow As Integer, endCol As Integer
    Dim i As Integer, j As Integer
    
    Call initialize_WS_variables
    
    'Application.ScreenUpdating = False
    Application.EnableEvents = False
    comDraftSht.Activate
    
    endRow = workRange.Row + workRange.Rows.Count
    endCol = workRange.Column + workRange.Columns.Count
       
    For i = Range("N11").Row To endRow - 1
    
        For j = Range("N11").Column To endCol - 1
            Set tmpCell = Cells(i, j)
            tmpCell.Select 'test line
            If tmpCell.Value <> "" Then
                'Debug.Print tmpCell.Value
                
                wStatSht.Activate
                If Range(tmpCell.Address).Comment Is Nothing Then
                    Range(tmpCell.Address).AddComment
                End If
                Range(tmpCell.Address).Comment.text text:=tmpCell.Value
                comDraftSht.Activate
                
            End If
        Next j
    
    Next i
    
    wStatSht.Activate
    Application.EnableEvents = True
    'Application.ScreenUpdating = True
End Sub

Sub writeComments()

    Dim tmpCell As Range
    Dim clw As New CellWorker
    Dim endRow As Integer, endCol As Integer
    Dim i As Integer, j As Integer
    Dim tmpStr As String
    
    Call initialize_WS_variables
    
    'Application.ScreenUpdating = False
    Application.EnableEvents = False
    
    wStatSht.Activate
    
    endRow = workRange.Row + workRange.Rows.Count
    endCol = workRange.Column + workRange.Columns.Count
       
    For i = Range("N11").Row To endRow - 1
    
        For j = Range("N11").Column To endCol - 1
            Set tmpCell = Cells(i, j)
            tmpCell.Select 'test line
            If Not tmpCell.Comment Is Nothing Then
                'Debug.Print tmpCell.Value
                
                tmpStr = Range(tmpCell.Address).Comment.text
                comDraftSht.Activate
                Cells(tmpCell.Row, (tmpCell.Column + workRange.Columns.Count)).Value = tmpStr
                Cells(tmpCell.Row, (tmpCell.Column + workRange.Columns.Count)).Select
                wStatSht.Activate
                tmpStr = ""
                
            End If
        Next j
    
    Next i
    Application.EnableEvents = True
   'Application.ScreenUpdating = True
End Sub



Sub initialize_WS_variables()
Attribute initialize_WS_variables.VB_ProcData.VB_Invoke_Func = " \n14"
'
' test Макрос
'
'    Dim clw As New CellWorker
'
    Set statusWB = ActiveWorkbook
    
    Set wStatSht = statusWB.Sheets("WorkStatus")
    Set wStatDraftSht = statusWB.Sheets("WorkStatusDraft")
    Set comDraftSht = statusWB.Sheets("CommentsDraft")
    Set usrTableSht = statusWB.Sheets("user_table")
    Set msfoTableSht = statusWB.Sheets("msfo_table")
    'range address of statuses
    Set workRange = calcWorkRange
    'workRange.Select
    
End Sub

Function calcWorkRange() As Range

    Dim colKeyRange As String
    Dim rowKeyRange As String
    Dim tmpArr As Variant
    Dim tmpString As String
    Dim tmpRange As Range
    Dim upLeftAddr As String
    Dim downRightAddr As String
    
    wStatSht.Activate
    colKeyRange = Range("B34").Value
    tmpArr = Split(colKeyRange, "$")
    upLeftAddr = tmpArr(1) & "11"
    tmpString = tmpArr(3)
    rowKeyRange = Range("B35").Value
    tmpArr = Split(rowKeyRange, "$")
    downRightAddr = tmpString & tmpArr(4)
    
    Set calcWorkRange = Range(upLeftAddr & ":" & downRightAddr)
End Function

Sub prepareWorkspace()
    Dim colorColl As New Collection
    Dim keyColl As New Collection
    Call initialize_WS_variables
    Call unhide_everything
    
    wStatSht.Activate
    Range("N11").Select
    Call copyStatuses
    
    workRange.Select
    'Call create_comboBxs
    Selection.Locked = True
    
    Call readComments
    Call hide_everything


End Sub

Private Function Pass(sh)
'
' Прочитать пароль на листе
'
    ' Поиск ячейки-маркера
    Set f = sh.Cells.find("PasswordBPC", LookIn:=xlFormulas, LookAt:=xlWhole, MatchCase:=False)
    If Not f Is Nothing Then
        Set f = sh.Cells(f.Row + 1, f.Column)
        Pass = f.Value
        If sh.ProtectContents = False Then
            f.NumberFormat = ";;;"
            'f.Locked = True
            f.FormulaHidden = True
            Set r = Range(sh.Cells(f.Row - 1, f.Column), f)
            r.Interior.ThemeColor = xlThemeColorAccent1
            r.Interior.TintAndShade = 0.4
        End If
    End If
End Function


Sub unhide_everything()
    Call initialize_WS_variables
    
    Application.ScreenUpdating = False
    Application.EnableEvents = False
    wStatSht.Unprotect Pass(wStatSht)
    comDraftSht.Visible = xlSheetVisible
    Sheets("Helper").Visible = xlSheetVisible
    wStatDraftSht.Visible = xlSheetVisible
    usrTableSht.Visible = xlSheetVisible
    msfoTableSht.Visible = xlSheetVisible

End Sub

Sub hide_everything()
    Call initialize_WS_variables
    comDraftSht.Visible = xlSheetVeryHidden
    Sheets("Helper").Visible = xlSheetVeryHidden
    wStatDraftSht.Visible = xlSheetVeryHidden
    'usrTableSht.Visible = xlSheetVeryHidden
    'msfoTableSht.Visible = xlSheetVeryHidden
    wStatSht.Protect Pass(wStatSht)
    Application.ScreenUpdating = True
    Application.EnableEvents = True

End Sub

Sub sendComments()
    Call initialize_WS_variables
    Call unhide_everything
    
    Call writeComments
    
    Call hide_everything
    'wStatSht.Select
    'workRange.Select
    'Call clearComboBxs
    Application.Run "MNU_eSUBMIT_REFSCHEDULE_BOOK_NOACTION_SHOWRESULT"
    'workRange.Select
    'Call create_comboBxs
End Sub

Sub clearComboBxs()
    With Selection.Validation
        .Delete
        .Add Type:=xlValidateInputOnly, AlertStyle:=xlValidAlertStop, Operator _
        :=xlBetween
        .IgnoreBlank = True
        .InCellDropdown = True
        .InputTitle = ""
        .ErrorTitle = ""
        .InputMessage = ""
        .ErrorMessage = ""
        .ShowInput = True
        .ShowError = True
    End With
End Sub

Sub copyStatuses()
    
    'copy status' filling from draft to clean copy
    Dim clw As New CellWorker
    Dim eng_rus_dict As Collection
    Dim firstCellInRow As Range
    Dim tmpRng As Range
    Dim convVal As String
    
    
    Set eng_rus_dict = ws_change_module.make_dictionary()
    wStatDraftSht.Select
    Set firstCellInRow = Range("N11")
    
    Do While firstCellInRow.Value <> ""
        Set tmpRng = firstCellInRow
        Do While tmpRng.Value <> "" And tmpRng.Value <> "#ERR"
            'translates values
            wStatSht.Range(tmpRng.Address(False, False)).Value = eng_rus_dict(wStatDraftSht.Range(tmpRng.Address(False, False)).Value)
            Set tmpRng = clw.move_right(tmpRng)
        Loop
        Set firstCellInRow = clw.move_down(firstCellInRow)
    Loop
    'Selection.Copy
    'workRange.Copy
    wStatSht.Select
    

End Sub




Function isAuthorized(changedCell As Range, statVal As String) As String
    Dim compName As String
    Dim periodVal As String
    Dim cashSht As Worksheet
    
    Set cashSht = ActiveSheet
    wStatSht.Activate
    compName = Cells(10, changedCell.Column).Value
    periodVal = Range("N3")
    
'    If Not isCompanyInUsrCompColl(compName) Then
'        Exit Function
'    End If
'    If Not isUsrHasApprType(changedCell.Value) Then
'        Exit Function
'    End If
    If Not isCompanyInUsrCompColl(compName) Then
        isAuthorized = "у Вас недостаточно прав для изменения статуса по компании " & compName
        Exit Function
    ElseIf Not isUsrHasApprType(statVal) Then
        isAuthorized = "у Вас недостаточно прав, чтобы поставить статус " & statVal
        Exit Function
    ElseIf Not isValidPeriod(periodVal) Then
        isAuthorized = "необходимо выбрать месяц в поле период"
        Exit Function
    End If
    
    isAuthorized = "ok"
    cashSht.Activate
End Function
Function isValidPeriod(periodVal As String) As Boolean

    Dim monthCol As New Collection
    Dim monthArg As String
    Dim tmpArray As Variant
    
    'this used because of language issues (month naming)
    monthCol.Add "Январь"
    monthCol.Add "Февраль"
    monthCol.Add "Март"
    monthCol.Add "Апрель"
    monthCol.Add "Май"
    monthCol.Add "Июнь"
    monthCol.Add "Июль"
    monthCol.Add "Август"
    monthCol.Add "Сентябрь"
    monthCol.Add "Октябрь"
    monthCol.Add "Ноябрь"
    monthCol.Add "Декабрь"

    tmpArray = Split(periodVal, " ")
    monthArg = tmpArray(0)
    
    isValidPeriod = isExistInCol(monthArg, monthCol)
End Function

Function isExistInCol(itemVal As String, colForSearch As Collection) As Boolean
    'loop through given collection and if meet given value return true
    Dim resBool As Boolean
    resBool = False
    itemVal = LCase(Trim(itemVal))
    For Each Item In colForSearch
        If itemVal = LCase(Trim(Item)) Then
            resBool = True
            Exit For
        End If
    Next Item
    isExistInCol = resBool
End Function

Private Sub populateCollection(rangeAddrToExam As String, cellsCol As Collection)
    'Populate cellsCol with addresses of cells from rangeAddrToExam
    Dim cellToExam As Range
    Dim upLeftCell As Range
    Dim clw As New CellWorker
    Dim tmpAddr As String
    Dim tmpArray As Variant
    
    On Error Resume Next
    tmpArray = Split(rangeAddrToExam, ":")
    If Err.Number = 0 Then
        tmpAddr = tmpArray(0)
    End If
    On Error GoTo 0
    
    If tmpAddr = "" Then
        Set cellToExam = Range(rangeAddrToExam)
    Else
        Set cellToExam = Range(tmpAddr)
    End If
    
    Set upLeftCell = cellToExam
    Do While isInRange(rangeAddrToExam, cellToExam)
        Do While isInRange(rangeAddrToExam, cellToExam)
            cellsCol.Add cellToExam.Address(False, False)
            Set cellToExam = clw.move_down(cellToExam)
        Loop
        Set upLeftCell = clw.move_right(upLeftCell)
        Set cellToExam = upLeftCell
    Loop

End Sub

Function isInRange(rangeAddrToExam As String, cellToExam As Range) As Boolean

    Dim workRangeAddr As String
    Dim upLeftCell As Range, downRightCell As Range
    Dim tmpArray As Variant
    
    isInRange = False
    'Check if user selects one cell
    If InStr(1, rangeAddrToExam, ":") = 0 Then
        If rangeAddrToExam = cellToExam.Address(False, False) Then
            isInRange = True
            Exit Function
        Else
            Exit Function
        End If
    End If
    
    workRangeAddr = rangeAddrToExam
    tmpArray = Split(workRangeAddr, ":")
    Set upLeftCell = Range(tmpArray(0))
    Set downRightCell = Range(tmpArray(1))
    
    If cellToExam.Row <= downRightCell.Row And cellToExam.Column <= downRightCell.Column And cellToExam.Row >= upLeftCell.Row And cellToExam.Column >= upLeftCell.Column Then
        isInRange = True
    End If

End Function

