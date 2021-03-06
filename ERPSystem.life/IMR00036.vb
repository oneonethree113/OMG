﻿Imports Microsoft.Office.Interop

Public Class IMR00036

    'Dim frmCrtSel_GB As frmCrtSel_GB

    Dim rs_EXCEL As DataSet

    Private Sub IMR00036_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Formstartup(Me.Name)

        Dim rs_load As DataSet
        Dim strCocde As String = ""

        gspStr = "sp_select_SYMUSRCO '" & gsCompany & "','" & gsUsrID & "'"

        Me.Cursor = Windows.Forms.Cursors.WaitCursor
        rs_load = Nothing
        rtnLong = execute_SQLStatement(gspStr, rs_load, rtnStr)
        gspStr = ""
        Me.Cursor = Windows.Forms.Cursors.Default

        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading IMR00036 #001 sp_select_SYMUSRCO : " & rtnStr)
            Exit Sub
        Else
            If rs_load.Tables("RESULT").Rows.Count > 0 Then
                For i As Integer = 0 To rs_load.Tables("RESULT").Rows.Count - 1
                    If rs_load.Tables("RESULT").Rows(i)("yuc_cocde") <> "MS" Then
                        strCocde = strCocde & IIf(strCocde.Length > 0, ", ", "") & rs_load.Tables("RESULT").Rows(i)("yuc_cocde")
                        If gsCompany = "" Then
                            gsCompany = rs_load.Tables("RESULT").Rows(i)("yuc_cocde")
                        End If
                    ElseIf gsDefaultCompany = "MS" Then
                        strCocde = "MS"
                    End If
                Next
            End If
        End If

        If gsDefaultCompany = "MS" Then
            txt_S_CoCde.Text = "MS"
            gsCompany = "MS"
        Else
            txt_S_CoCde.Text = strCocde
        End If

        cboSortBy.Items.Add("Customer")
        cboSortBy.SelectedIndex = 0

        Dim grp As String = Split(gsUsrGrp, "-")(0)
        Select Case grp
            Case "CED", "MIS", "MGT", "EDP"
                optRptSC_init()
                'optRptMB.Enabled = True
                'optRptAD.Enabled = True
                'optRptCheck.Enabled = True
                'optRptCheck.Checked = True
            Case "SHP"
                optRptSC_init()
                'optRptMB.Enabled = False
                'optRptAD.Enabled = True
                'optRptCheck.Enabled = False
                'optRptCheck.Checked = True
            Case Else
                optRptSC_init()
                'optRptMB.Enabled = True
                'optRptAD.Enabled = False
                'optRptCheck.Enabled = False
                'optRptCheck.Checked = True
        End Select

        'If gsUsrRank <= 4 Then
        '    optPrintAmtY.Enabled = True
        '    optPrintAmtN.Enabled = True
        '    optPrintAmtY.Checked = True
        'Else
        '    optPrintAmtY.Enabled = False
        '    optPrintAmtN.Enabled = True
        '    optPrintAmtN.Checked = True
        'End If


        txtIssDatFm.Text = Format(DateAdd(DateInterval.Month, -1, Date.Now), "MM/dd/yyyy")
        txtIssDatTo.Text = Format(Date.Now, "MM/dd/yyyy")
    End Sub

    Private Sub cmdtlCocde_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdtlCocde.Click

        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = txt_S_CoCde.Name
        frmComSearch.callFmString = txt_S_CoCde.Text

        frmComSearch.show_frmS(Me.cmdtlCocde)
    End Sub

    Private Sub cmdtlCus1no_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdtlCus1no.Click


        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = txt_S_PriCustAll.Name
        frmComSearch.callFmString = txt_S_PriCustAll.Text

        frmComSearch.show_frmS(Me.cmdtlCus1no)
    End Sub

    Private Sub cmdtlCus2no_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdtlCus2no.Click

        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = txt_S_SecCustAll.Name
        frmComSearch.callFmString = txt_S_SecCustAll.Text

        frmComSearch.show_frmS(Me.cmdtlCus2no)
    End Sub

    Private Sub cmdtlCusPONo_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdtlCusPONo.Click
        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = txt_S_CustPONo.Name
        frmComSearch.callFmString = txt_S_CustPONo.Text

        frmComSearch.show_frmS(Me.cmdtlCusPONo)
    End Sub

    Private Sub cmdtlSCNo_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdtlSCNo.Click
        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = txt_S_SCNo.Name
        frmComSearch.callFmString = txt_S_SCNo.Text

        frmComSearch.show_frmS(Me.cmdtlSCNo)
    End Sub

    Private Sub cmdtlitmno_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdtlitmno.Click
        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = txt_S_ItmNo.Name
        frmComSearch.callFmString = txt_S_ItmNo.Text

        frmComSearch.show_frmS(Me.cmdtlitmno)
    End Sub

    Private Sub cmdtlCV_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdtlCV.Click
        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = txt_S_CV.Name
        frmComSearch.callFmString = txt_S_CV.Text

        frmComSearch.show_frmS(Me.cmdtlCV)
    End Sub

    Private Sub cmdtlDV_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdtlDV.Click
        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = txt_S_DV.Name
        frmComSearch.callFmString = txt_S_DV.Text

        frmComSearch.show_frmS(Me.cmdtlDV)
    End Sub

    Private Sub cmdtlPV_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdtlPV.Click
        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = txt_S_PV.Name
        frmComSearch.callFmString = txt_S_PV.Text

        frmComSearch.show_frmS(Me.cmdtlPV)
    End Sub

    Private Sub cndtlSalesTeam_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cndtlSalesTeam.Click
        Dim frmComSearch As New frmComSearch

        frmComSearch.callFmForm = Me.Name
        frmComSearch.callFmCriteria = txt_S_SalTem.Name
        frmComSearch.callFmString = txt_S_SalTem.Text

        frmComSearch.show_frmS(Me.cndtlSalesTeam)
    End Sub

    Private Sub cmdShow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdShow.Click
        'Dim S As String
        'Dim rs() As ADOR.Recordset

        Dim COCDELIST As String
        Dim CUS1NOLIST As String
        Dim CUS2NOLIST As String
        Dim CUSPONOLIST As String
        Dim SCNOLIST As String
        Dim ITMNOLIST As String
        Dim CVLIST As String
        Dim DVLIST As String
        Dim PVLIST As String
        Dim SALESTEAMLIST As String
        Dim SCISSDATFM As String
        Dim SCISSDATTO As String
        Dim SHPDATFM As String
        Dim SHPDATTO As String
        Dim CUSPODATFM As String
        Dim CUSPODATTO As String
        Dim PRINTAMT As String
        Dim SCTYPE As String
        Dim RptType As String
        Dim SORTBY As String



        If Trim(txt_S_CoCde.Text) = "" Then
            MsgBox("The Company Code List is empty!")
            Exit Sub
        Else
            If Len(txt_S_CoCde.Text) > 1000 Then
                MsgBox("The Company Code List Is Too Long")
                txt_S_CoCde.Focus()
                txt_S_CoCde.SelectAll()
                Exit Sub
            End If
            COCDELIST = removeDuplicateItem(Trim(txt_S_CoCde.Text))
            COCDELIST = Replace(COCDELIST, "'", "''")
        End If

        If Trim(txt_S_PriCustAll.Text) = "" Then
            CUS1NOLIST = ""
        Else
            If Len(txt_S_PriCustAll.Text) > 1000 Then
                MsgBox("The Primary Customer List Is Too Long!")
                txt_S_PriCustAll.Focus()
                txt_S_PriCustAll.SelectAll()
                Exit Sub
            End If
            CUS1NOLIST = removeDuplicateItem(Trim(txt_S_PriCustAll.Text))
            CUS1NOLIST = Replace(CUS1NOLIST, "'", "''")
        End If

        If Trim(txt_S_SecCustAll.Text) = "" Then
            CUS2NOLIST = ""
        Else
            If Len(txt_S_SecCustAll.Text) > 1000 Then
                MsgBox("The Secondary Customer List Is Too Long!")
                txt_S_SecCustAll.Focus()
                txt_S_SecCustAll.SelectAll()
                Exit Sub
            End If
            CUS2NOLIST = removeDuplicateItem(Trim(txt_S_SecCustAll.Text))
            CUS2NOLIST = Replace(CUS2NOLIST, "'", "''")
        End If

        If Trim(txt_S_CustPONo.Text) = "" Then
            CUSPONOLIST = ""
        Else
            If Len(txt_S_CustPONo.Text) > 1000 Then
                MsgBox("The Customer PO Number List Is Too Long!")
                txt_S_CustPONo.Focus()
                txt_S_CustPONo.SelectAll()
                Exit Sub
            End If
            CUSPONOLIST = removeDuplicateItem(Trim(txt_S_CustPONo.Text))
            CUSPONOLIST = Replace(CUSPONOLIST, "'", "''")
        End If

        If Trim(txt_S_SCNo.Text) = "" Then
            SCNOLIST = ""
        Else
            If Len(txt_S_SCNo.Text) > 1000 Then
                MsgBox("The SC Number List Is Too Long!")
                txt_S_SCNo.Focus()
                txt_S_SCNo.SelectAll()
                Exit Sub
            End If
            SCNOLIST = removeDuplicateItem(Trim(txt_S_SCNo.Text))
            SCNOLIST = Replace(SCNOLIST, "'", "''")
        End If

        If Trim(txt_S_ItmNo.Text) = "" Then
            ITMNOLIST = ""
        Else
            If Len(txt_S_ItmNo.Text) > 1000 Then
                MsgBox("The Item Number List Is Too Long!")
                txt_S_ItmNo.Focus()
                txt_S_ItmNo.SelectAll()
                Exit Sub
            End If
            ITMNOLIST = removeDuplicateItem(Trim(txt_S_ItmNo.Text))
            ITMNOLIST = Replace(ITMNOLIST, "'", "''")
        End If

        If Trim(txt_S_CV.Text) = "" Then
            CVLIST = ""
        Else
            If Len(Me.txt_S_CV.Text) > 1000 Then
                MsgBox("The Custom Vendor List Is Too Long!")
                txt_S_CV.Focus()
                txt_S_CV.SelectAll()
                Exit Sub
            End If
            CVLIST = removeDuplicateItem(Trim(txt_S_CV.Text))
            CVLIST = Replace(CVLIST, "'", "''")
        End If

        If Trim(txt_S_DV.Text) = "" Then
            DVLIST = ""
        Else
            If Len(Me.txt_S_DV.Text) > 1000 Then
                MsgBox("The Design Vendor List Is Too Long!")
                txt_S_DV.Focus()
                txt_S_DV.SelectAll()
                Exit Sub
            End If
            DVLIST = removeDuplicateItem(Trim(txt_S_DV.Text))
            DVLIST = Replace(DVLIST, "'", "''")
        End If

        If Trim(txt_S_PV.Text) = "" Then
            PVLIST = ""
        Else
            If Len(txt_S_PV.Text) > 1000 Then
                MsgBox("The Production Vendor List Is Too Long!")
                txt_S_PV.Focus()
                txt_S_PV.SelectAll()
                Exit Sub
            End If
            PVLIST = removeDuplicateItem(Trim(txt_S_PV.Text))
            PVLIST = Replace(PVLIST, "'", "''")
        End If

        If Trim(txt_S_SalTem.Text) = "" Then
            SALESTEAMLIST = ""
        Else
            If Len(txt_S_SalTem.Text) > 1000 Then
                MsgBox("The Sales Team List Is Too Long!")
                txt_S_SalTem.Focus()
                txt_S_SalTem.SelectAll()
                Exit Sub
            End If
            SALESTEAMLIST = removeDuplicateItem(Trim(txt_S_SalTem.Text))
            SALESTEAMLIST = Replace(SALESTEAMLIST, "'", "''")
        End If


        If Mid(txtIssDatFm.Text, 7) > Mid(txtIssDatTo.Text, 7) Then
            MsgBox("Issue Date: End Date < Start date ! (YY)")
            txtIssDatFm.Focus()
            txtIssDatFm.SelectAll()
            Exit Sub
        ElseIf Mid(txtIssDatFm.Text, 7) = Mid(txtIssDatTo.Text, 7) Then
            If txtIssDatFm.Text.Substring(0, 2) > txtIssDatTo.Text.Substring(0, 2) Then
                'If Left(txtIssDatFm.Text, 2) > Left(txtIssDatTo.Text, 2) Then
                MsgBox("Issue Date: End Date < Start date ! (MM)")
                txtIssDatFm.Focus()
                txtIssDatFm.SelectAll()
                Exit Sub
            ElseIf txtIssDatFm.Text.Substring(0, 2) = txtIssDatTo.Text.Substring(0, 2) Then
                If Mid(txtIssDatFm.Text, 4, 2) > Mid(txtIssDatTo.Text, 4, 2) Then
                    MsgBox("Issue Date: End Date < Start date ! (DD)")
                    txtIssDatFm.Focus()
                    txtIssDatFm.SelectAll()
                    Exit Sub
                End If
            End If
        End If

        If txtIssDatFm.Text <> "  /  /" Then
            If IsDate(txtIssDatFm.Text) = False Then
                MsgBox("Invalid Enter in Issue Date!")
                txtIssDatFm.Focus()
                txtIssDatFm.SelectAll()
                Exit Sub
            End If
        End If

        If txtIssDatTo.Text <> "  /  /" Then
            If IsDate(txtIssDatTo.Text) = False Then
                MsgBox("Invalid Enter in Issue Date!")
                txtIssDatTo.Focus()
                txtIssDatTo.SelectAll()
                Exit Sub
            End If
        End If

        If txtIssDatFm.Text = "  /  /" Then
            SCISSDATFM = "1900-01-01"
        Else
            SCISSDATFM = Format(CDate(txtIssDatFm.Text), "yyyy-MM-dd")
        End If

        If txtIssDatTo.Text = "  /  /" Then
            SCISSDATTO = "1900-01-01"
        Else
            SCISSDATTO = Format(CDate(txtIssDatTo.Text), "yyyy-MM-dd")
        End If


        If Mid(txtShpDatFm.Text, 7) > Mid(txtShpDatTo.Text, 7) Then
            MsgBox("Ship Date: End Date < Start date ! (YY)")
            txtShpDatFm.Focus()
            txtShpDatFm.SelectAll()
            Exit Sub
        ElseIf Mid(txtShpDatFm.Text, 7) = Mid(txtShpDatTo.Text, 7) Then
            If txtShpDatFm.Text.Substring(0, 2) > txtShpDatTo.Text.Substring(0, 2) Then
                'If Left(txtShpDatFm.Text, 2) > Left(txtShpDatTo.Text, 2) Then
                MsgBox("Ship Date: End Date < Start date ! (MM)")
                txtShpDatFm.Focus()
                txtShpDatFm.SelectAll()
                Exit Sub
            ElseIf txtShpDatFm.Text.Substring(0, 2) = txtShpDatTo.Text.Substring(0, 2) Then
                If Mid(txtShpDatFm.Text, 4, 2) > Mid(txtShpDatTo.Text, 4, 2) Then
                    MsgBox("Ship Date: End Date < Start date ! (DD)")
                    txtShpDatFm.Focus()
                    txtShpDatFm.SelectAll()
                    Exit Sub
                End If
            End If
        End If

        If txtShpDatFm.Text <> "  /  /" Then
            If IsDate(txtShpDatFm.Text) = False Then
                MsgBox("Invalid Enter in Ship Date!")
                txtShpDatFm.Focus()
                txtShpDatFm.SelectAll()
                Exit Sub
            End If
        End If

        If txtShpDatTo.Text <> "  /  /" Then
            If IsDate(txtShpDatTo.Text) = False Then
                MsgBox("Invalid Enter in Ship Date!")
                txtShpDatTo.Focus()
                txtShpDatTo.SelectAll()
                Exit Sub
            End If
        End If

        If txtShpDatFm.Text = "  /  /" Then
            SHPDATFM = "1900-01-01"
        Else
            SHPDATFM = Format(CDate(txtShpDatFm.Text), "yyyy-MM-dd")
        End If

        If txtShpDatTo.Text = "  /  /" Then
            SHPDATTO = "1900-01-01"
        Else
            SHPDATTO = Format(CDate(txtShpDatTo.Text), "yyyy-MM-dd")
        End If


        If txtCusPODatFm.Text <> "  /  /" Then
            If IsDate(txtCusPODatFm.Text) = False Then
                MsgBox("Invalid Enter in Cust PO Date!")
                txtCusPODatFm.Focus()
                txtCusPODatFm.SelectAll()
                Exit Sub
            End If
        End If

        If txtCusPODatTo.Text <> "  /  /" Then
            If IsDate(txtCusPODatTo.Text) = False Then
                MsgBox("Invalid Enter in Cust PO Date!")
                txtCusPODatTo.Focus()
                txtCusPODatTo.SelectAll()
                Exit Sub
            End If
        End If


        If txtCusPODatFm.Text = "  /  /" Then
            CUSPODATFM = "1900-01-01"
        Else
            CUSPODATFM = Format(CDate(txtCusPODatFm.Text), "yyyy-MM-dd")
        End If

        If txtCusPODatTo.Text = "  /  /" Then
            CUSPODATTO = "1900-01-01"
        Else
            CUSPODATTO = Format(CDate(txtCusPODatTo.Text), "yyyy-MM-dd")
        End If

        If SCISSDATFM = "1900-01-01" And SHPDATFM = "1900-01-01" And CUSPODATFM = "1900-01-01" Then
            MsgBox("At least enter one of Date SCIssue/Ship/CusPO")
            txtIssDatFm.Focus()
            Exit Sub
        End If


        If optPrintAmtY.Checked = True Then
            PRINTAMT = "Y"
        Else
            PRINTAMT = "N"
        End If

        If optOSOS.Checked = True Then
            SCTYPE = "O"
        Else
            SCTYPE = "A"
        End If

        If optRptAD.Checked = True Then
            RptType = "AD"
        ElseIf optRptCheck.Checked = True Then
            RptType = "CH"
        ElseIf optRptMB.Checked = True Then
            RptType = "MB"
        ElseIf optmulShdate.Checked = True Then
            RptType = "MS"
        End If

        If cboSortBy.Text = "Customer" Then
            SORTBY = "C"
        Else
            SORTBY = "C"
        End If


        gspStr = "sp_list_IMR00036 '" & gsCompany & "','" & COCDELIST & "','" & CUS1NOLIST & "','" & CUS2NOLIST & "','" & _
             CUSPONOLIST & "','" & SCNOLIST & "','" & ITMNOLIST & "','" & CVLIST & "','" & DVLIST & "','" & PVLIST & _
             "','" & SALESTEAMLIST & "','" & SCISSDATFM & "','" & SCISSDATTO & "','" & SHPDATFM & "','" & SHPDATTO & _
             "','" & CUSPODATFM & "','" & CUSPODATTO & "','" & PRINTAMT & "','" & SCTYPE & "','" & RptType & "','" & _
             SORTBY & "','" & gsUsrID & "'"

        'Me.Cursor = Windows.Forms.Cursors.WaitCursor
        'rs_EXCEL = Nothing

        'rtnLong = execute_SQLStatement(gspStr, rs_EXCEL, rtnStr)
        'gspStr = ""
        'Me.Cursor = Windows.Forms.Cursors.Default

        'If rtnLong <> RC_SUCCESS Then
        '    MsgBox("Error on loading IMR00036 #001 sp_list_IMR00036 : " & rtnStr)
        '    Exit Sub
        'End If

        'If rs_EXCEL.Tables("RESULT").Rows.Count = 0 Then
        '    MsgBox("No Records Found!")
        '    Exit Sub
        'End If
        'ExportToExcel()

        Me.Cursor = Cursors.WaitCursor

        Dim rs As New ADODB.Recordset
        rtnLong = execute_SQLStatement_ADO(gspStr, rs, rtnStr)
        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading DYR00009 #002 sp_list_DYR00009 : " & rtnStr)
        Else
            If rs.RecordCount = 0 Then
                MsgBox("No record found!")
            Else
                Call ExportToExcel(rs)
            End If
        End If

        Me.Cursor = Cursors.Default


    End Sub



    'Private Sub optRptSCSH_init()
    '    'Me.optRptSCSH.Value = True

    '    optRptMB.Enabled = False
    '    optRptAD.Enabled = False
    '    optRptCheck.Enabled = False

    '    txt_S_CoCde.Enabled = False
    '    cmdtlCocde.Enabled = True

    '    txt_S_PriCust.Enabled = False
    '    cmdtlCus1no.Enabled = True

    '    txt_S_SecCust.Enabled = False
    '    cmdtlCus2no.Enabled = True

    '    txt_S_CustPONo.Enabled = True
    '    cmdtlCusPONo.Enabled = True

    '    txt_S_SCNo.Enabled = True
    '    cmdtlSCNo.Enabled = True

    '    txt_S_ItmNo.Enabled = True
    '    cmdtlitmno.Enabled = True

    '    txt_S_CV.Enabled = False
    '    cmdtlCV.Enabled = True

    '    txt_S_DV.Enabled = False
    '    cmdtlDV.Enabled = True

    '    txt_S_PV.Enabled = True
    '    cmdtlPV.Enabled = True

    '    txt_S_SalTem.Enabled = False
    '    cndtlSalesTeam.Enabled = True

    '    txtIssDatFm.Enabled = True
    '    txtIssDatTo.Enabled = True

    '    txtShpDatFm.Enabled = False
    '    txtShpDatTo.Enabled = False

    '    txtCusPODatFm.Enabled = False
    '    txtCusPODatTo.Enabled = False

    '    optOSOS.Enabled = False
    '    optOSAll.Enabled = False

    '    optPrintAmtY.Enabled = False
    '    optPrintAmtN.Enabled = False

    'End Sub

    Private Sub optRptSC_init()
        '    Me.optRptSC.Value = True

        optRptMB.Enabled = True
        optRptAD.Enabled = True
        optRptCheck.Enabled = True

        txt_S_CoCde.Enabled = False
        cmdtlCocde.Enabled = True

        txt_S_PriCustAll.Enabled = False
        cmdtlCus1no.Enabled = True

        txt_S_SecCustAll.Enabled = False
        cmdtlCus2no.Enabled = True

        txt_S_CustPONo.Enabled = True
        cmdtlCusPONo.Enabled = True

        txt_S_SCNo.Enabled = True
        cmdtlSCNo.Enabled = True

        txt_S_ItmNo.Enabled = True
        cmdtlitmno.Enabled = True

        txt_S_CV.Enabled = False
        cmdtlCV.Enabled = True

        txt_S_DV.Enabled = False
        cmdtlDV.Enabled = True

        txt_S_PV.Enabled = False
        cmdtlPV.Enabled = True

        txt_S_SalTem.Enabled = True
        cndtlSalesTeam.Enabled = True

        txtIssDatFm.Enabled = True
        txtIssDatTo.Enabled = True

        txtShpDatFm.Enabled = False
        txtShpDatTo.Enabled = False

        txtCusPODatFm.Enabled = False
        txtCusPODatTo.Enabled = False

        optOSOS.Enabled = False
        optOSAll.Enabled = False

        optPrintAmtY.Enabled = False
        optPrintAmtN.Enabled = False

        cboSortBy.Enabled = False

    End Sub

    Private Sub reportTypeChange(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles optRptMB.CheckedChanged, optRptAD.CheckedChanged, optRptCheck.CheckedChanged
        'Dim grp As String = Split(gsUsrGrp, "-")(0)
        'If optRptMB.Checked Then
        '    optRptSC_init()
        '    Select Case grp
        '        Case "CED", "MIS", "MGT", "EDP"
        '            optRptMB.Enabled = True
        '            optRptAD.Enabled = True
        '            optRptCheck.Enabled = True
        '        Case Else
        '            optRptMB.Enabled = True
        '            optRptAD.Enabled = False
        '            optRptCheck.Enabled = False
        '    End Select
        '    optRptMB.Checked = True
        'ElseIf optRptAD.Checked Then
        '    optRptSCSH_init()
        '    Select Case grp
        '        Case "CED", "MIS", "MGT", "EDP"
        '            optRptMB.Enabled = True
        '            optRptAD.Enabled = True
        '            optRptCheck.Enabled = True
        '        Case Else
        '            optRptMB.Enabled = False
        '            optRptAD.Enabled = True
        '            optRptCheck.Enabled = False
        '    End Select
        '    optRptAD.Checked = True
        'ElseIf optRptCheck.Checked Then
        '    optRptSC_init()
        '    Select Case grp
        '        Case "CED", "MIS", "MGT", "EDP"
        '            optRptMB.Enabled = True
        '            optRptAD.Enabled = True
        '            optRptCheck.Enabled = True
        '        Case Else
        '            optRptMB.Enabled = False
        '            optRptAD.Enabled = False
        '            optRptCheck.Enabled = True
        '    End Select
        '    optRptCheck.Checked = True
        'End If
        optRptSC_init()
    End Sub

    Private Sub txtIssDatFm_GotFocus(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtIssDatFm.GotFocus, txtIssDatTo.GotFocus, txtCusPODatFm.GotFocus, txtCusPODatTo.GotFocus, txtShpDatFm.GotFocus, txtShpDatTo.GotFocus
        sender.SelectAll()
    End Sub

    Private Function removeDuplicateItem(ByVal strInput As String) As String

        Dim intCount As Integer
        Dim strResult As String
        Dim strTemp As String
        Dim strArray() As String

        strResult = strInput
        intCount = UBound(Split(strInput, ","))
        If intCount > 0 Then
            ReDim strArray(intCount)
            For i As Integer = 0 To intCount
                strArray(i) = Split(strInput, ",")(i)
            Next i
            For i As Integer = 0 To UBound(strArray)
                strTemp = strArray(i)
                If strTemp <> "" Then
                    For j As Integer = 0 To UBound(strArray)
                        If (i <> j And strArray(j) <> "" And strTemp = strArray(j)) Then
                            strArray(j) = ""
                        End If
                    Next j
                End If
            Next i
            strResult = ""
            For i As Integer = 0 To UBound(strArray)
                strResult = strResult & IIf(strArray(i) = "", "", IIf(strResult = "", strArray(i), "," & strArray(i)))
            Next i
        End If

        Return strResult
    End Function


    Private Sub ExportToExcel(ByVal rs_EXCEL As ADODB.Recordset)
        Dim xlsApp As New Excel.ApplicationClass
        Dim xlsWB As Excel.Workbook = Nothing
        Dim xlsWS As Excel.Worksheet = Nothing
        Dim iRow As Integer
        Dim iCol As Integer
        Dim strCocde As String = String.Empty

        If rs_EXCEL.RecordCount >= 65535 Then
            MsgBox("There are more than 65535 records!")
            Exit Sub
        End If


        Me.Cursor = Cursors.WaitCursor

        xlsApp = New Excel.Application
        xlsApp.Visible = True
        xlsApp.UserControl = True

        Dim oldCI As System.Globalization.CultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture
        System.Threading.Thread.CurrentThread.CurrentCulture = New System.Globalization.CultureInfo("en-US")

        xlsWB = xlsApp.Workbooks.Add()
        xlsWS = xlsWB.ActiveSheet

        Dim i As Integer
        For i = 0 To rs_EXCEL.Fields.Count - 1
            xlsApp.Cells(1, i + 1) = rs_EXCEL.Fields(i).Name
        Next
        xlsWS.Rows(1).Font.Bold = True
        xlsWS.Rows(1).Font.Size = 12

        Dim headerRow As Integer = 1
        Dim headerCol As Integer = 1

        With xlsApp

            'For i = 0 To rs_EXCEL.Tables("RESULT").Columns.Count - 1
            '    headerCol += 1
            '    .Cells(headerRow, headerCol) = rs_EXCEL.Tables("RESULT").Columns(i).ColumnName.ToString

            '    If optRptSC.Checked = True Then 'Report Type = SC
            '        If i = 3 Or i = 4 Or i = 13 Or i = 14 Then
            '            .Columns(i + 1).NumberFormat = "MM/dd/yyyy"
            '        ElseIf i = 10 Or i = 11 Or i = 16 Or i = 18 Or i = 19 Or i = 20 Or i = 32 Or i = 34 Or i = 36 Then
            '            .Columns(i + 1).NumberFormat = "@"
            '        End If
            '    ElseIf optRptCheck.Checked = True Then
            '        Select Case i
            '            Case 7, 49, 50, 51, 52, 53, 54
            '                .Columns(i + 1).NumberFormat = "MM/dd/yyyy"
            '            Case 8
            '                .Columns(i + 1).NumberFormat = "@"
            '        End Select
            '    End If
            'Next

            .Cells(2, 1).copyfromrecordset(rs_EXCEL)

            If optRptCheck.Checked Then
                '.Rows(headerRow + 1 & ":" & headerRow + rs_EXCEL.Tables("RESULT").Rows.Count).EntireRow.AutoFit()
                .Rows(headerRow).RowHeight = 50

                .Range("A1:BU1").WrapText = True
                .Range("A1").ColumnWidth = 9
                .Range("B1").ColumnWidth = 12
                .Range("C1").ColumnWidth = 6
                .Range("D1").ColumnWidth = 25
                .Range("E1").ColumnWidth = 30
                .Range("F1").ColumnWidth = 30
                .Range("G1").ColumnWidth = 7
                .Range("H1").ColumnWidth = 11

                .Range("I1").ColumnWidth = 20

                .Range("J1").ColumnWidth = 20
                .Range("K1").ColumnWidth = 20
                .Range("L1").ColumnWidth = 20
                .Range("M1").ColumnWidth = 20
                .Range("N1").ColumnWidth = 5
                .Range("O1").ColumnWidth = 18

                .Range("P1").ColumnWidth = 20
                .Range("Q1").ColumnWidth = 20
                .Range("R1").ColumnWidth = 20
                .Range("S1").ColumnWidth = 20
                .Range("T1").ColumnWidth = 20
                .Range("U1").ColumnWidth = 20
                .Range("V1").ColumnWidth = 60
                .Range("W1").ColumnWidth = 20
                .Range("X1").ColumnWidth = 20
                .Range("Y1").ColumnWidth = 20
                .Range("Z1").ColumnWidth = 7

                .Range("AA1").ColumnWidth = 8
                .Range("AB1").ColumnWidth = 8
                .Range("AC1").ColumnWidth = 8
                .Range("AD1").ColumnWidth = 8
                .Range("AE1").ColumnWidth = 8
                .Range("AF1").ColumnWidth = 8
                .Range("AG1").ColumnWidth = 8
                .Range("AH1").ColumnWidth = 45
                .Range("AI1").ColumnWidth = 7
                .Range("AJ1").ColumnWidth = 5
                .Range("AK1").ColumnWidth = 12
                .Range("AL1").ColumnWidth = 14
                .Range("AM1").ColumnWidth = 7
                .Range("AN1").ColumnWidth = 7
                .Range("AO1").ColumnWidth = 18
                .Range("AP1").ColumnWidth = 18
                .Range("AQ1").ColumnWidth = 18
                .Range("AR1").ColumnWidth = 7
                .Range("AS1").ColumnWidth = 9
                .Range("AT1").ColumnWidth = 7
                .Range("AU1").ColumnWidth = 9
                .Range("AV1").ColumnWidth = 7
                .Range("AW1").ColumnWidth = 7
                .Range("AX1").ColumnWidth = 7
                .Range("AY1").ColumnWidth = 11
                .Range("AZ1").ColumnWidth = 11

                .Range("BA1").ColumnWidth = 11
                .Range("BB1").ColumnWidth = 11
                .Range("BC1").ColumnWidth = 11
                .Range("BD1").ColumnWidth = 11
                .Range("BE1").ColumnWidth = 22
                .Range("BF1").ColumnWidth = 22
                .Range("BG1").ColumnWidth = 22
                .Range("BH1").ColumnWidth = 22
                .Range("BI1").ColumnWidth = 22
                .Range("BJ1").ColumnWidth = 7
                .Range("BK1").ColumnWidth = 12
                .Range("BL1").ColumnWidth = 7
                .Range("BM1").ColumnWidth = 12
                .Range("BN1").ColumnWidth = 30
                .Range("BO1").ColumnWidth = 30
                .Range("BP1").ColumnWidth = 15
                .Range("BQ1").ColumnWidth = 30
                .Range("BR1").ColumnWidth = 60
                .Range("BS1").ColumnWidth = 30
                .Range("BT1").ColumnWidth = 60
                .Range("BU1").ColumnWidth = 30
                .Range("BV1").ColumnWidth = 60

                .Range("BW1").ColumnWidth = 60
                .Range("BX1").ColumnWidth = 60
                .Range("BY1").ColumnWidth = 60
                .Range("BZ1").ColumnWidth = 60
                .Range("CA1").ColumnWidth = 60
                .Range("CB1").ColumnWidth = 60
                .Range("CC1").ColumnWidth = 60

                .Range("CD1").ColumnWidth = 60
                .Range("CE1").ColumnWidth = 30
                .Range("CF1").ColumnWidth = 20
                .Range("CG1").ColumnWidth = 20
                .Range("CH1").ColumnWidth = 20

                .Range("CI1").ColumnWidth = 10
                .Range("CJ1").ColumnWidth = 30

                xlsApp.Selection.CurrentRegion.rows.AutoFit()

                For i = 2 To rs_EXCEL.RecordCount + 1
                    .Rows(i).RowHeight = 16.5
                    .Rows(i).Font.Size = 12
                Next

            Else
                '.Rows(headerRow + 1 & ":" & headerRow + rs_EXCEL.Tables("RESULT").Rows.Count).EntireRow.AutoFit()
                .Rows(headerRow).RowHeight = 33
                xlsApp.Selection.CurrentRegion.Columns.AutoFit()
                xlsApp.Selection.CurrentRegion.rows.AutoFit()
            End If

            'xlsApp.Selection.CurrentRegion.Columns.AutoFit()
            'xlsApp.Selection.CurrentRegion.rows.AutoFit()



        End With
    End Sub

    Private Sub ExportToExcel()
        Dim xlsApp As New Excel.ApplicationClass
        Dim xlsWB As Excel.Workbook = Nothing
        Dim xlsWS As Excel.Worksheet = Nothing
        Dim strCocde As String = String.Empty

        If rs_EXCEL.Tables("RESULT").Rows.Count >= 65535 Then
            MsgBox("There are more than 65535 records!")
            Exit Sub
        End If

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

        Try
            With xlsApp
                headerCol = 0
                For i As Integer = 0 To rs_EXCEL.Tables("RESULT").Columns.Count - 1
                    headerCol += 1
                    .Cells(headerRow, headerCol) = rs_EXCEL.Tables("RESULT").Columns(i).ColumnName.ToString

                    If optRptMB.Checked = True Then 'Report Type = SC
                        If i = 3 Or i = 4 Or i = 13 Or i = 14 Then
                            .Columns(i + 1).NumberFormat = "MM/dd/yyyy"
                        ElseIf i = 10 Or i = 11 Or i = 16 Or i = 18 Or i = 19 Or i = 20 Or i = 32 Or i = 34 Or i = 36 Then
                            .Columns(i + 1).NumberFormat = "@"
                        End If
                    ElseIf optRptCheck.Checked = True Then
                        Select Case i
                            Case 7, 49, 50, 51, 52, 53, 54
                                .Columns(i + 1).NumberFormat = "MM/dd/yyyy"
                            Case 8
                                .Columns(i + 1).NumberFormat = "@"
                        End Select
                    End If
                Next
                .Range(.Cells(headerRow, 1), .Cells(headerRow, headerCol)).Font.Bold = True
                .Range(.Cells(headerRow, 1), .Cells(headerRow, headerCol)).Font.Size = 10

                If optRptCheck.Checked = False Then
                    Dim entry(rs_EXCEL.Tables("RESULT").Columns.Count - 1) As Object
                    For i As Integer = 0 To rs_EXCEL.Tables("RESULT").Rows.Count - 1
                        For j As Integer = 0 To rs_EXCEL.Tables("RESULT").Columns.Count - 1
                            entry(j) = IIf(IsDBNull(rs_EXCEL.Tables("RESULT").Rows(i)(j)), "", rs_EXCEL.Tables("RESULT").Rows(i)(j))
                        Next
                        .Range(.Cells(headerRow + i + 1, 1), .Cells(headerRow + i + 1, headerCol)).Value = entry
                        If optRptCheck.Checked = True Then
                            .Rows(i + 2).RowHeight = 14
                        End If
                    Next
                Else
                    .Cells(2, 1).copyfromrecordset(rs_EXCEL)
                End If

                'Styling

                For i As Integer = 1 To rs_EXCEL.Tables("RESULT").Columns.Count
                    If optRptCheck.Checked = False Then
                        If i = 18 Then
                            .Columns(i).WrapText = False
                            .Columns(i).EntireColumn.AutoFit()
                            .Columns(i).WrapText = True
                            .Columns(i).EntireColumn.AutoFit()
                        Else
                            .Columns(i).EntireColumn.AutoFit()
                        End If
                    Else
                        Select Case i
                            Case 65
                                '.Columns(i).WrapText = False
                            Case Else
                                '.Columns(i).WrapText = True
                                '.Columns(i).EntireColumn.AutoFit()
                        End Select
                    End If
                Next

                If optRptCheck.Checked Then
                    '.Rows(headerRow + 1 & ":" & headerRow + rs_EXCEL.Tables("RESULT").Rows.Count).EntireRow.AutoFit()
                    .Rows(headerRow).RowHeight = 27

                    .Range("A1:BU1").WrapText = True
                    .Range("A1").ColumnWidth = 6.75
                    .Range("B1").ColumnWidth = 10
                    .Range("C1").ColumnWidth = 4.5
                    .Range("D1").ColumnWidth = 25
                    .Range("E1").ColumnWidth = 20
                    .Range("F1").ColumnWidth = 7
                    .Range("G1").ColumnWidth = 4
                    .Range("H1").ColumnWidth = 9
                    .Range("I1").ColumnWidth = 11
                    .Range("J1").ColumnWidth = 11
                    .Range("K1").ColumnWidth = 11
                    .Range("L1").ColumnWidth = 11
                    .Range("M1").ColumnWidth = 3
                    .Range("N1").ColumnWidth = 14

                    .Range("O1").ColumnWidth = 1
                    .Range("P1").ColumnWidth = 1
                    .Range("Q1").ColumnWidth = 1
                    .Range("R1").ColumnWidth = 1
                    .Range("S1").ColumnWidth = 1
                    .Range("T1").ColumnWidth = 1
                    .Range("U1").ColumnWidth = 1
                    .Range("V1").ColumnWidth = 1
                    .Range("W1").ColumnWidth = 1
                    .Range("X1").ColumnWidth = 1
                    .Range("Y1").ColumnWidth = 1
                    .Range("Z1").ColumnWidth = 1

                    .Range("AA1").ColumnWidth = 1
                    .Range("AB1").ColumnWidth = 1
                    .Range("AC1").ColumnWidth = 1
                    .Range("AD1").ColumnWidth = 1
                    .Range("AE1").ColumnWidth = 1
                    .Range("AF1").ColumnWidth = 1
                    .Range("AG1").ColumnWidth = 1
                    .Range("AH1").ColumnWidth = 1
                    .Range("AI1").ColumnWidth = 1
                    .Range("AJ1").ColumnWidth = 1
                    .Range("AK1").ColumnWidth = 1
                    .Range("AL1").ColumnWidth = 1
                    .Range("AM1").ColumnWidth = 1
                    .Range("AN1").ColumnWidth = 1
                    .Range("AO1").ColumnWidth = 1
                    .Range("AP1").ColumnWidth = 1
                    .Range("AQ1").ColumnWidth = 1
                    .Range("AR1").ColumnWidth = 1
                    .Range("AS1").ColumnWidth = 1
                    .Range("AT1").ColumnWidth = 1
                    .Range("AU1").ColumnWidth = 1
                    .Range("AV1").ColumnWidth = 1
                    .Range("AW1").ColumnWidth = 1
                    .Range("AX1").ColumnWidth = 1
                    .Range("AY1").ColumnWidth = 1
                    .Range("AZ1").ColumnWidth = 1

                    .Range("BA1").ColumnWidth = 1
                    .Range("BB1").ColumnWidth = 1
                    .Range("BC1").ColumnWidth = 1
                    .Range("BD1").ColumnWidth = 1
                    .Range("BE1").ColumnWidth = 1
                    .Range("BF1").ColumnWidth = 1
                    .Range("BG1").ColumnWidth = 1
                    .Range("BH1").ColumnWidth = 1
                    .Range("BI1").ColumnWidth = 1
                    .Range("BJ1").ColumnWidth = 1
                    .Range("BK1").ColumnWidth = 1
                    .Range("BL1").ColumnWidth = 1
                    .Range("BM1").ColumnWidth = 1
                    .Range("BN1").ColumnWidth = 1
                    .Range("BO1").ColumnWidth = 1
                    .Range("BP1").ColumnWidth = 1
                    .Range("BQ1").ColumnWidth = 1
                    .Range("BR1").ColumnWidth = 1
                    .Range("BS1").ColumnWidth = 1
                    .Range("BT1").ColumnWidth = 1
                    .Range("BU1").ColumnWidth = 1

                Else
                    .Rows(headerRow + 1 & ":" & headerRow + rs_EXCEL.Tables("RESULT").Rows.Count).EntireRow.AutoFit()
                    .Rows(headerRow).RowHeight = 24
                End If

            End With
        Catch ex As Exception
            If ex.Message = "Exception from HRESULT: 0x800AC472" Or ex.Message = "Exception from HRESULT: 0x800A03EC" Then
                If (MsgBox("User has interrupted Data Extraction Process. An error has occured" & Environment.NewLine & "Please close Excel application and click ""Retry""", MsgBoxStyle.RetryCancel, "Excel Error")) = MsgBoxResult.Retry Then
                    xlsWS = Nothing
                    xlsWB = Nothing
                    xlsApp = Nothing
                    ExportToExcel()
                End If
            Else
                MsgBox(ex.ToString, MsgBoxStyle.Critical, Me.Name.ToString & " - Excel Error")
            End If
        End Try

        ' Release reference
        rs_EXCEL = Nothing
        xlsWS = Nothing
        xlsWB = Nothing
        xlsApp = Nothing

        Me.Cursor = Windows.Forms.Cursors.Default
    End Sub

    
End Class