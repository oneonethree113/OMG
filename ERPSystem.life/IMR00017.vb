﻿Imports System.IO.File
Imports System.Data
Imports System.Data.SqlClient
Imports Excel = Microsoft.Office.Interop.Excel

Public Class IMR00017
    Dim rs_SYCATCDE_level4 As DataSet
    Dim rs_VNBASINF As DataSet
    Dim rs_EXCEL As DataSet

    Const xls_itmno As Integer = 0
    Const xls_itmsts As Integer = 1
    Const xls_engdsc As Integer = 2
    Const xls_prdlne As Integer = 3
    Const xls_catlvl4 As Integer = 4
    Const xls_colcde As Integer = 5
    Const xls_pckunt As Integer = 6
    Const xls_inrqty As Integer = 7
    Const xls_mtrqty As Integer = 8
    Const xls_cft As Integer = 9
    Const xls_ftyprctrm As Integer = 10
    Const xls_hkprctrm As Integer = 11
    Const xls_trantrm As Integer = 12
    Const xls_period As Integer = 13
    Const xls_pckitr As Integer = 14
    Const xls_pricusno As Integer = 15
    Const xls_pricusnam As Integer = 16
    Const xls_seccusno As Integer = 17
    Const xls_seccusnam As Integer = 18
    Const xls_ftycst As Integer = 19
    Const xls_itmcst As Integer = 20
    Const xls_fmlopt As Integer = 21
    Const xls_bomitm As Integer = 22
    Const xls_bomdsc As Integer = 23
    Const xls_bomcst As Integer = 24
    Const xls_bomqty As Integer = 25
    Const xls_bomprc As Integer = 26
    Const xls_basprc As Integer = 27
    Const xls_negprc As Integer = 28
    Const xls_prdven As Integer = 29
    Const xls_alsitmno As Integer = 30
    Const xls_rmk As Integer = 31
    Const xls_expdat As Integer = 32
    Const xls_cstrmk As Integer = 33

    Dim textboxlist As New Collection() 'a dictionary storing the index and the textbox object


    Private Sub IMR00017_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Formstartup(Me.Name)

        loadComboBox()
        display_combo("A", cboDsgFm)
        display_combo("A", cboDsgTo)
        display_combo("A", cboPrdVFm)
        display_combo("A", cboPrdVTo)
        Call AddSearchBtnHandler()
    End Sub

    Private Sub loadComboBox()
        gspStr = "sp_select_SYCATCDE_level '',4"
        rtnLong = execute_SQLStatement(gspStr, rs_SYCATCDE_level4, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading IMR00017_Load #001 sp_select_SYCATCDE_level :" & rtnStr)
            Exit Sub
        End If

        gspStr = "sp_list_VNBASINF ''"
        rtnLong = execute_SQLStatement(gspStr, rs_VNBASINF, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading IMR00017_Load #002 sp_list_VNBASINF_vensna :" & rtnStr)
        End If

        format_CatLvl4()
        format_cboDV_cboPV()
        format_cboStatus()

    End Sub

    Private Sub cmdShow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdShow.Click
        Dim opt As String
        Dim itmFm As String
        Dim itmTo As String
        Dim itmLST As String
        Dim dateFm As String
        Dim dateTo As String

        opt = ""
        itmFm = ""
        itmTo = ""
        itmLST = ""
        dateFm = ""
        dateTo = ""

        rs_EXCEL = Nothing

        If optITM.Checked = True Then
            opt = "ITM"
        ElseIf optLST.Checked = True Then
            opt = "LST"
        ElseIf optDAA.Checked = True Then
            opt = "DAA"
        ElseIf optDAC.Checked = True Then
            opt = "DAC"
        Else
            opt = ""
        End If

        If opt = "ITM" Then
            If Trim(txtFromItmNo.Text) = "" Then
                MsgBox("Please input Item No From!")
                txtFromItmNo.Focus()
                txtFromItmNo.SelectAll()
                Exit Sub
            End If

            If Trim(txtToItmNo.Text) = "" Then
                MsgBox("Please input Item No To!")
                txtToItmNo.Focus()
                txtToItmNo.SelectAll()
                Exit Sub
            End If

            If Trim(txtFromItmNo.Text) > Trim(txtToItmNo.Text) Then
                MsgBox("Item Number From cannot smaller than Item Number To!")
                txtFromItmNo.Focus()
                txtFromItmNo.SelectAll()
                Exit Sub
            End If

            itmFm = UCase(Trim(txtFromItmNo.Text))
            itmTo = UCase(Trim(txtToItmNo.Text))
        ElseIf opt = "LST" Then
            If Trim(txtItmLst.Text) = "" Then
                MsgBox("Please input Item No List!")
                txtItmLst.Focus()
                txtItmLst.SelectAll()
                Exit Sub
            End If

            itmLST = UCase(Trim(txtItmLst.Text))
        Else
            If txtUpddatFm.Text <> "  /  /" Or txtUpddatTo.Text <> "  /  /" Then
                If Not IsDate(txtUpddatFm.Text) Then
                    MsgBox("Invalid Update Date From value!")
                    txtUpddatFm.Focus()
                    txtUpddatFm.SelectAll()
                    Exit Sub
                End If
                If Not IsDate(txtUpddatTo.Text) Then
                    MsgBox("Invalid Update Date To value!")
                    txtUpddatTo.Focus()
                    txtUpddatTo.SelectAll()
                    Exit Sub
                End If

                If CDate(txtUpddatFm.Text) > CDate(txtUpddatTo.Text) Then
                    MsgBox("Update Date From > Update Date To!")
                    txtUpddatFm.Focus()
                    txtUpddatFm.SelectAll()
                    Exit Sub
                End If
            End If

            dateFm = IIf(txtUpddatFm.Text = "  /  /", "01/01/1900", txtUpddatFm.Text)
            dateTo = IIf(txtUpddatTo.Text = "  /  /", "01/01/1900", txtUpddatTo.Text)
        End If

        Dim catFm As String
        Dim catTo As String
        Dim dvFm As String
        Dim dvTo As String
        Dim pvFm As String
        Dim pvTo As String
        Dim sts As String
        Dim period As String

        If cboFromCatLvl4.Text > cboToCatLvl4.Text Then
            MsgBox("Category Code From > To!")
            cboToCatLvl4.Focus()
            cboToCatLvl4.SelectAll()
            Exit Sub
        End If

        If txt_S_Period.Text <> "    -" Then
            If Not DateTime.TryParse(txt_S_Period.Text.Replace("   ", " "), "9999-12") Then
                MsgBox("Item Update Date: Invalid End Date", MsgBoxStyle.Information, "Invalid Input")
                highlight_date(txt_S_Period, Nothing)
                Exit Sub
            End If
        End If

        If cboFromCatLvl4.Text <> "" Then
            If cboToCatLvl4.Text = "" Then
                MsgBox("Category Code From not empty but Category Code To is empty!")
                cboToCatLvl4.Focus()
                cboToCatLvl4.SelectAll()
                Exit Sub
            End If
            catFm = Trim(Split(cboFromCatLvl4.Text, " - ")(0))
            catTo = Trim(Split(cboToCatLvl4.Text, " - ")(0))
        Else
            catFm = ""
            catTo = ""
        End If


        If cboDsgFm.Text > cboDsgTo.Text Then
            MsgBox("Design Vendor: To < From!")
            cboDsgTo.Focus()
            cboDsgTo.SelectAll()
            Exit Sub
        End If

        If cboDsgFm.Text <> "" Then
            If cboDsgTo.Text = "" Then
                MsgBox("Design Vendor From not empty but Design Vendor To is empty!")
                cboDsgTo.Focus()
                cboDsgTo.SelectAll()
                Exit Sub
            End If
            dvFm = Trim(Split(cboDsgFm.Text, " - ")(0))
            dvTo = Trim(Split(cboDsgTo.Text, " - ")(0))
        Else
            dvFm = ""
            dvTo = ""
        End If


        If cboPrdVFm.Text > cboPrdVTo.Text Then
            MsgBox("Production Vendor: To < From!")
            cboPrdVTo.Focus()
            cboPrdVTo.SelectAll()
            Exit Sub
        End If

        If cboPrdVFm.Text <> "" Then
            If cboPrdVTo.Text = "" Then
                MsgBox("Production Vendor From not empty but Production Vendor To is empty!")
                cboPrdVTo.Focus()
                cboPrdVTo.SelectAll()
                Exit Sub
            End If
            pvFm = Trim(Split(cboPrdVFm.Text, " - ")(0))
            pvTo = Trim(Split(cboPrdVTo.Text, " - ")(0))
        Else
            pvFm = ""
            pvTo = ""
        End If

        If cboStatus.Text <> "" Then
            sts = Trim(Split(cboStatus.Text, " - ")(0))
        Else
            sts = ""
        End If

        If txt_S_Period.Text <> "    -" Then
            If Not DateTime.TryParse(txt_S_Period.Text.Replace("   ", " "), "9999-12") Then
                MsgBox("Item Update Date: Invalid End Date", MsgBoxStyle.Information, "Invalid Input")
                highlight_date(txt_S_Period, Nothing)
                Exit Sub
            End If
        End If

        If Len(Trim(txt_S_PriCustAll.Text)) > 1000 Then
            MsgBox("Primary Customer list exceeds maximum allowable length (1000 Characters).", MsgBoxStyle.Exclamation, "Invalid Input")
            txt_S_PriCustAll.Focus()
            Exit Sub
        End If

        If Len(Trim(txt_S_SecCustAll.Text)) > 1000 Then
            MsgBox("Secondary Customer list exceeds maximum allowable length (1000 Characters).", MsgBoxStyle.Exclamation, "Invalid Input")
            txt_S_PriCustAll.Focus()
            Exit Sub
        End If

        If (Trim(txtItmLst.Text).Length = 0) Then
            txtItmLst.Text = ""
            'MsgBox("Please Enter " & IIf(optBOMItm.Checked = True, "BOM ", "") & "Item No.", MsgBoxStyle.Information, "Missing Input Parameter")
            'txtItmNo.Focus()
            'txtItmNo.SelectAll()
            'Exit Sub
        End If


        If txt_S_Period.Text = "    -" Then
            period = "1900/01"
        Else
            period = txt_S_Period.Text.Replace("-", "/")
        End If

        Dim cus1no As String
        Dim cus2no As String
        Dim venno As String

        cus1no = txt_S_PriCustAll.Text
        cus1no = cus1no.Replace("'", "''")
        cus2no = txt_S_SecCustAll.Text
        cus2no = cus2no.Replace("'", "''")
        venno = txt_S_DV.Text
        venno = venno.Replace("'", "''")

        gspStr = "sp_select_IMR00017 'UCPP','" & itmLST & "','" & catFm & "','" & catTo & "','" & itmFm & "','" & itmTo & "','" & _
                 dvFm & "','" & dvTo & "','" & pvFm & "','" & pvTo & "','" & period & "','" & cus1no & "','" & cus2no & "','" & venno & "','" & dateFm & "','" & dateTo & "','" & sts & "','" & opt & "'"

        Me.Cursor = Windows.Forms.Cursors.WaitCursor

        rtnLong = execute_SQLStatement(gspStr, rs_EXCEL, rtnStr)

        Me.Cursor = Windows.Forms.Cursors.Default

        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading IMR00017 #003 sp_select_IMR00017 :" & rtnStr)
            Exit Sub
        End If

        If rs_EXCEL.Tables("RESULT").Rows.Count = 0 Then
            MsgBox("No Record Found!")
            Exit Sub
        ElseIf rs_EXCEL.Tables("RESULT").Rows.Count > 65535 Then
            MsgBox("Result has over 65535 entries. Result cannot be exported to Excel!")
            Exit Sub
        Else
            ExportExcel()
        End If
    End Sub

    Private Sub ExportExcel()
        Dim xlsApp As New Excel.ApplicationClass
        Dim xlsWB As Excel.Workbook = Nothing
        Dim xlsWS As Excel.Worksheet = Nothing

        Me.Cursor = Windows.Forms.Cursors.WaitCursor

        xlsApp = New Excel.Application
        xlsApp.Visible = True
        xlsApp.UserControl = True

        Dim oldCI As System.Globalization.CultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture
        System.Threading.Thread.CurrentThread.CurrentCulture = New System.Globalization.CultureInfo("en-US")

        xlsWB = xlsApp.Workbooks.Add()
        xlsWS = xlsWB.ActiveSheet

        Dim headerRow As Integer = 1
        Dim headerCol As Integer = 1

        xlsApp.Visible = False

        ' Row Header Initializing
        With xlsApp
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Item No."
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Item Status"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "English Description"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Product Line"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Category"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Color Code"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "UM"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Inner"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Master"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "CFT"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "FTY Prc Trm"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "HK Prc Trm"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Tran Trm"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Period"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Packing Instruction"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Pri. Cus. No."
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Pri. Cus. Name"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Sec. Cus. No."
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Sec. Cus. Name"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "FTY Cost"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Item Cost"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Formula"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "BOM Item No."
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Item Description"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "BOM Cost"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Qty of BOM Per Item"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "BOM Price"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Basic Price"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Negociated"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "PV"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Alias No."
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Item Remark"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Cost Expiry Date"
            headerCol += 1
            .Rows(headerRow).HorizontalAlignment = Excel.Constants.xlLeft
            .Cells(headerRow, headerCol) = "Cost Remark"
        End With

        'Populate with Data
        'With xlsApp
        '    For i As Integer = 0 To rs_EXCEL.Tables("RESULT").Rows.Count - 1
        '        For j As Integer = 0 To rs_EXCEL.Tables("RESULT").Columns.Count - 2
        '            .Cells(headerRow + 1 + i, j + 1) = rs_EXCEL.Tables("RESULT").Rows(i)(j)
        '        Next
        '    Next
        'End With

        Dim entry(rs_EXCEL.Tables("RESULT").Columns.Count - 1) As Object
        'Dim entry(42) As Object
        For i As Integer = 0 To rs_EXCEL.Tables("RESULT").Rows.Count - 1
            entry(xls_itmno) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_itmno)
            entry(xls_itmsts) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_itmsts)
            entry(xls_engdsc) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_engdsc)
            entry(xls_prdlne) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_prdlne)
            entry(xls_catlvl4) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_catlvl4)
            entry(xls_colcde) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_colcde)
            entry(xls_pckunt) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_pckunt)
            entry(xls_inrqty) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_inrqty)
            entry(xls_mtrqty) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_mtrqty)
            entry(xls_cft) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_cft)
            entry(xls_ftyprctrm) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_ftyprctrm)
            entry(xls_hkprctrm) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_hkprctrm)
            entry(xls_trantrm) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_trantrm)
            entry(xls_period) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_period)
            entry(xls_pckitr) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_pckitr)
            entry(xls_pricusno) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_pricusno)
            entry(xls_pricusnam) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_pricusnam)
            entry(xls_seccusno) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_seccusno)
            entry(xls_seccusnam) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_seccusnam)
            entry(xls_ftycst) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_ftycst)
            entry(xls_itmcst) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_itmcst)
            entry(xls_fmlopt) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_fmlopt)
            entry(xls_bomitm) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_bomitm)
            entry(xls_bomdsc) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_bomdsc)
            entry(xls_bomcst) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_bomcst)
            entry(xls_bomqty) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_bomqty)
            entry(xls_bomprc) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_bomprc)
            entry(xls_basprc) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_basprc)
            entry(xls_negprc) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_negprc)
            entry(xls_prdven) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_prdven)
            entry(xls_alsitmno) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_alsitmno)
            entry(xls_rmk) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_rmk)
            entry(xls_expdat) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_expdat)
            entry(xls_cstrmk) = rs_EXCEL.Tables("RESULT").Rows(i)(xls_cstrmk)

            xlsApp.Range(xlsApp.Cells(headerRow + 1 + i, 1), xlsApp.Cells(headerRow + 1 + i, rs_EXCEL.Tables("RESULT").Columns.Count)).Value = entry
        Next

        ' Styling EXCEL
        With xlsApp
            .Rows("1:1").Font.Bold = True
            .Range(.Cells(headerRow, 1), .Cells(headerRow, rs_EXCEL.Tables("RESULT").Columns.Count - 1)).Borders(Excel.XlBordersIndex.xlEdgeBottom).LineStyle = 1
            .Rows(1).rowheight = 24.75
            .Columns(xls_cstrmk + 1).columnwidth = 50
            .Columns("A:AF").EntireColumn.AutoFit()
            .Rows(CStr(headerRow + 1) & ":" & CStr(headerRow + rs_EXCEL.Tables("RESULT").Rows.Count)).EntireRow.AutoFit()

            .Columns(xls_expdat + 1).NumberFormatLocal = "yyyy-MM-dd "
        End With

        xlsApp.Visible = True

        ' Release reference
        rs_EXCEL = Nothing
        xlsWS = Nothing
        xlsWB = Nothing
        xlsApp = Nothing

        Me.Cursor = Windows.Forms.Cursors.Default
    End Sub

    Private Sub format_CatLvl4()
        cboFromCatLvl4.Items.Clear()
        cboToCatLvl4.Items.Clear()

        cboFromCatLvl4.Items.Add("")
        cboToCatLvl4.Items.Add("")

        For i As Integer = 0 To rs_SYCATCDE_level4.Tables("RESULT").Rows.Count - 1
            cboFromCatLvl4.Items.Add(rs_SYCATCDE_level4.Tables("RESULT").Rows(i)("ycc_catcde") & " - " & rs_SYCATCDE_level4.Tables("RESULT").Rows(i)("ycc_catdsc"))
            cboToCatLvl4.Items.Add(rs_SYCATCDE_level4.Tables("RESULT").Rows(i)("ycc_catcde") & " - " & rs_SYCATCDE_level4.Tables("RESULT").Rows(i)("ycc_catdsc"))
        Next
    End Sub

    Private Sub format_cboDV_cboPV()
        cboDsgFm.Items.Clear()
        cboDsgTo.Items.Clear()
        cboPrdVFm.Items.Clear()
        cboPrdVTo.Items.Clear()

        cboDsgFm.Items.Add("")
        cboDsgTo.Items.Add("")
        cboPrdVFm.Items.Add("")
        cboPrdVTo.Items.Add("")

        For i As Integer = 0 To rs_VNBASINF.Tables("RESULT").Rows.Count - 1
            cboDsgFm.Items.Add(rs_VNBASINF.Tables("RESULT").Rows(i)("vbi_venno") & " - " & rs_VNBASINF.Tables("RESULT").Rows(i)("vbi_vensna"))
            cboDsgTo.Items.Add(rs_VNBASINF.Tables("RESULT").Rows(i)("vbi_venno") & " - " & rs_VNBASINF.Tables("RESULT").Rows(i)("vbi_vensna"))
            cboPrdVFm.Items.Add(rs_VNBASINF.Tables("RESULT").Rows(i)("vbi_venno") & " - " & rs_VNBASINF.Tables("RESULT").Rows(i)("vbi_vensna"))
            cboPrdVTo.Items.Add(rs_VNBASINF.Tables("RESULT").Rows(i)("vbi_venno") & " - " & rs_VNBASINF.Tables("RESULT").Rows(i)("vbi_vensna"))
        Next
    End Sub

    Private Sub format_cboStatus()
        cboStatus.Items.Clear()
        cboStatus.Items.Add("")
        cboStatus.Items.Add("CMP - Complete Item")
        cboStatus.Items.Add("INC - Incomplete Item")
        cboStatus.Items.Add("HLD - Item on Hold")
        cboStatus.Items.Add("DIS - Discontinue Item")
        cboStatus.Items.Add("TBC - To Be Confirmed")
        cboStatus.Items.Add("INA - Inactive Item")
        cboStatus.Items.Add("CLO - Closed Item")
        cboStatus.Items.Add("OLD - Old Item")
    End Sub

    Private Sub optITM_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles optITM.CheckedChanged
        grpITM.Visible = True
        grpLST.Visible = False
        grpDAT.Visible = False

        txtFromItmNo.MaxLength = 20
        txtToItmNo.MaxLength = 20

        txtFromItmNo.Text = ""
        txtToItmNo.Text = ""
    End Sub

    Private Sub optLST_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles optLST.CheckedChanged
        grpITM.Visible = False
        grpLST.Visible = True
        grpDAT.Visible = False

        txtItmLst.MaxLength = 650

        txtItmLst.Text = ""
    End Sub

    Private Sub optDAC_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles optDAC.CheckedChanged
        grpDAT.Visible = True
        grpITM.Visible = False
        grpLST.Visible = False

        txtUpddatFm.Text = "  /  /"
        txtUpddatTo.Text = "  /  /"
    End Sub

    Private Sub optDAA_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles optDAA.CheckedChanged
        grpDAT.Visible = True
        grpITM.Visible = False
        grpLST.Visible = False

        txtUpddatFm.Text = "  /  /"
        txtUpddatTo.Text = "  /  /"
    End Sub

    Private Sub highlight_date(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtUpddatFm.GotFocus, txtUpddatTo.GotFocus
        sender.SelectAll()
    End Sub

    Private Sub CopyTo(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtFromItmNo.TextChanged
        txtToItmNo.Text = sender.Text
    End Sub

    Private Sub cmd_S_ItmNo_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmd_S_ItmNo.Click
        frmItemList.strItem = txtItmLst.Text
        'frmItemList.Show(vbModal)
        Call frmItemList.getform("IMR00017")
        frmItemList.ShowDialog()
        txtItmLst.Text = frmItemList.strSel
    End Sub

    Private Sub AddSearchBtnHandler()
        textboxlist.Add(txt_S_PriCustAll, "cmd_S_PriCustAll")
        textboxlist.Add(txt_S_SecCustAll, "cmd_S_SecCustAll")
        textboxlist.Add(txt_S_DV, "cmd_S_DV")
        'textboxlist.Add(txt_S_CV, "cmd_S_CV")
        'textboxlist.Add(txt_S_FA, "cmd_S_FA")
        'textboxlist.Add(txt_S_SCNo, "cmd_S_SCNo")
        'textboxlist.Add(txt_S_PONo, "cmd_S_PONo")
        'textboxlist.Add(txt_S_CustPONo, "cmd_S_CustPONo")
        'textboxlist.Add(txtItmNo, "cmd_S_ItmNo")

        AddHandler cmd_S_PriCustAll.Click, AddressOf cmd_S_Click
        AddHandler cmd_S_SecCustAll.Click, AddressOf cmd_S_Click
        AddHandler cmd_S_DV.Click, AddressOf cmd_S_Click
        'AddHandler cmd_S_CV.Click, AddressOf cmd_S_Click
        'AddHandler cmd_S_FA.Click, AddressOf cmd_S_Click
        'AddHandler cmd_S_SCNo.Click, AddressOf cmd_S_Click
        'AddHandler cmd_S_PONo.Click, AddressOf cmd_S_Click
        'AddHandler cmd_S_CustPONo.Click, AddressOf cmd_S_Click
        'AddHandler cmd_S_ItmNo.Click, AddressOf cmd_S_Click


    End Sub

    Private Sub cmd_S_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim trigger_btn As Button = CType(sender, Button)
        Dim btn_name As String = trigger_btn.Name
        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = textboxlist(btn_name).Name
        frmComSearch.callFmString = textboxlist(btn_name).Text
        frmComSearch.show_frmS(trigger_btn)
    End Sub

End Class