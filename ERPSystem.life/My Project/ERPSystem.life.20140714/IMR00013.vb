﻿Public Class IMR00013
    Dim rs_VNBASINF As DataSet
    Dim rs_IMR00013 As DataSet
    Private Sub IMR00013_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

  
 

        Me.txtYearFm.MaxLength = 2
        Me.txtYearTo.MaxLength = 2
        Me.txtYearFm.Text = Strings.Right(Year(Now), 2)
        Me.txtYearTo.Text = Strings.Right(Year(Now), 2)

        Me.txtMthFm.MaxLength = 2
        Me.txtMthTo.MaxLength = 2
        Me.txtMthFm.Text = Strings.Right("0" & Month(Now), 2)
        Me.txtMthTo.Text = Strings.Right("0" & Month(Now), 2)

        cboReport.Items.Clear()
        cboReport.Items.Add("Summary")
        cboReport.Items.Add("Detail Breakdown by Factory")
        cboReport.Items.Add("List of Item without Image")
        cboReport.Items.Add("List of Ordered Item Without Image")

        cboReport.SelectedIndex = 0

        gspStr = "sp_list_VNBASINF ''"

        rtnLong = execute_SQLStatement(gspStr, rs_VNBASINF, rtnStr)

        If rtnLong <> RC_SUCCESS Then
            MsgBox("Error on loading sp_list_VNBASINF:" & rtnStr)
            Exit Sub
        Else

            Call FillcboVen()
        End If
    End Sub
    Private Sub FillcboVen()
        cboVenFm.Items.Clear()
        cboVenFm.Items.Add("")
        cboVenTo.Items.Clear()
        cboVenTo.Items.Add("")
        If rs_VNBASINF.Tables("RESULT").Rows.Count > 0 Then
            For i As Integer = 0 To rs_VNBASINF.Tables("RESULT").Rows.Count - 1
                cboVenFm.Items.Add(rs_VNBASINF.Tables("RESULT").Rows(i).Item("vbi_venno") & " - " & rs_VNBASINF.Tables("RESULT").Rows(i).Item("vbi_vensna"))
                cboVenTo.Items.Add(rs_VNBASINF.Tables("RESULT").Rows(i).Item("vbi_venno") & " - " & rs_VNBASINF.Tables("RESULT").Rows(i).Item("vbi_vensna"))

            Next
        End If
    End Sub

    Private Sub cboReport_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboReport.SelectedIndexChanged
        If cboReport.SelectedIndex = 3 Then
            frSDate.Visible = True
            Me.txtSDateFM.MaxLength = 10
            Me.txtSDateTO.MaxLength = 10
            Me.txtSDateFM.Text = Format(Now, "MM/dd/yyyy")
            Me.txtSDateTO.Text = Format(Now, "MM/dd/yyyy")
        Else
            Me.txtSDateFM.Text = "__/__/____"
            Me.txtSDateTO.Text = "__/__/____"
            frSDate.Visible = False

        End If
    End Sub

    Private Sub cboVenFm_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboVenFm.KeyUp
        auto_search_combo(cboVenFm)
    End Sub

    Private Sub cboVenFm_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboVenFm.SelectedIndexChanged

    End Sub

    Private Sub cboVenTo_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles cboVenTo.KeyPress

    End Sub

    Private Sub cboVenTo_KeyUp(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles cboVenTo.KeyUp
        auto_search_combo(cboVenTo)
    End Sub

    Private Sub cboVenTo_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboVenTo.SelectedIndexChanged

    End Sub

    Private Sub txtYearFm_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtYearFm.KeyPress
        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If
    End Sub

    Private Sub txtYearFm_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtYearFm.TextChanged
        txtYearTo.Text = txtYearFm.Text
    End Sub

    Private Sub txtMthFm_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtMthFm.KeyPress
        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If
    End Sub

    Private Sub txtMthFm_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtMthFm.TextChanged
        txtMthTo.Text = txtMthFm.Text
    End Sub

    Private Sub txtYearTo_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtYearTo.KeyPress
        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If
    End Sub

    Private Sub txtYearTo_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtYearTo.TextChanged

    End Sub

    Private Sub txtMthTo_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtMthTo.KeyPress
        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If
    End Sub

    Private Sub txtMthTo_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtMthTo.TextChanged

    End Sub

    Private Sub txtSDateFM_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtSDateFM.KeyPress
        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If
    End Sub

    Private Sub txtSDateFM_MaskInputRejected(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MaskInputRejectedEventArgs) Handles txtSDateFM.MaskInputRejected

    End Sub

    Private Sub txtSDateTO_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtSDateTO.KeyPress
        If Not ((Asc(e.KeyChar) >= 48 And Asc(e.KeyChar) <= 57) Or Asc(e.KeyChar) = 8) Then
            e.KeyChar = Chr(0)
            MsgBox("Please input integer value.")
        End If
    End Sub

    Private Sub txtSDateTO_MaskInputRejected(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MaskInputRejectedEventArgs) Handles txtSDateTO.MaskInputRejected

    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
    
        Dim OPTRPT As String
        If Me.cboVenFm.Text = "" And Me.cboVenTo.Text = "" Then
            MsgBox("Please select Vendor No")
            cboVenFm.Focus()
            Exit Sub
        End If

        If Me.cboVenFm.Text = "" And Me.cboVenTo.Text <> "" Then
            Me.cboVenFm.Text = Me.cboVenTo.Text
        End If
        If Me.cboVenFm.Text <> "" And Me.cboVenTo.Text = "" Then
            Me.cboVenTo.Text = Me.cboVenFm.Text
        End If

        Me.txtYearFm.Text = Strings.Right("0" & Me.txtYearFm.Text, 2)
        Me.txtYearTo.Text = Strings.Right("0" & Me.txtYearTo.Text, 2)

        If Me.cboVenFm.Text > Me.cboVenTo.Text Then
            MsgBox("Vendor No : From > To")
            cboVenFm.Focus()
            Exit Sub
        End If

        If Me.txtYearFm.Text = "" And Me.txtYearTo.Text = "" Then
            MsgBox("Please Input Year")
            txtYearFm.Focus()
            Exit Sub
        End If
        If Me.txtYearFm.Text = "" And Me.txtYearTo.Text <> "" Then
            Me.txtYearFm.Text = Me.txtYearTo.Text
        End If
        If Me.txtYearFm.Text <> "" And Me.txtYearTo.Text = "" Then
            Me.txtYearTo.Text = Me.txtYearFm.Text
        End If

        If Me.txtMthFm.Text = "" And Me.txtMthTo.Text = "" Then
            MsgBox("Please Input Month")
            txtMthFm.Focus()
            Exit Sub
        End If
        If Me.txtMthFm.Text = "" And Me.txtMthTo.Text <> "" Then
            Me.txtMthFm.Text = Me.txtMthTo.Text
        End If
        If Me.txtMthTo.Text = "" And Me.txtMthFm.Text <> "" Then
            Me.txtMthTo.Text = Me.txtMthFm.Text
        End If

        Me.txtMthFm.Text = Strings.Right("0" & Me.txtMthFm.Text, 2)
        Me.txtMthTo.Text = Strings.Right("0" & Me.txtMthTo.Text, 2)

        If Me.txtMthFm.Text < "01" Or Me.txtMthFm.Text > "12" Then
            MsgBox("Invalid Year/Month value!")
            txtMthFm.Focus()
            Exit Sub
        End If
        If Me.txtMthTo.Text < "01" Or Me.txtMthTo.Text > "12" Then
            MsgBox("Invalid Year/Month value!")
            txtMthTo.Focus()
            Exit Sub
        End If

        If Me.txtYearFm.Text > Me.txtYearTo.Text Then
            MsgBox("Year/Month : From > To")
            txtYearFm.Focus()
            Exit Sub
        End If
        If Me.txtYearFm.Text = Me.txtYearTo.Text And Me.txtMthFm.Text > Me.txtMthTo.Text Then
            MsgBox("Year/Month : From > To")
            txtYearFm.Focus()
            Exit Sub
        End If

        OPTRPT = "ANL"

        Dim strIssDatFM, strISSTO As String
        strIssDatFM = "01/01/1899 00:00:00"
        strISSTO = "01/01/1899 23:59:59"

        If Me.cboReport.SelectedIndex = 1 Then
            OPTRPT = "DTL"
        ElseIf Me.cboReport.SelectedIndex = 2 Then
            OPTRPT = "LST"
        ElseIf Me.cboReport.SelectedIndex = 3 Then
            If Check_Date(txtSDateFM, txtSDateTO) = True Then
                OPTRPT = "ORD"
                strIssDatFM = CStr(txtSDateFM.Text + " 00:00:00.000")
                strISSTO = CStr(txtSDateTO.Text + " 23:59:59")
            Else
                Exit Sub
            End If
        End If


        gspStr = "SP_SELECT_IMR00013 '','" & Me.txtYearFm.Text & "','" & Me.txtYearTo.Text & _
                         "','" & Me.txtMthFm.Text & "','" & Me.txtMthTo.Text & _
                         "','" & Me.cboVenFm.Text & "','" & Me.cboVenTo.Text & _
                         "','" & OPTRPT & "','" & strIssDatFM & _
                         "','" & strISSTO & "'"

        'S = "㊣IMR00013※S※" & Me.txtYearFm.Text & "※" & Me.txtYearTo.Text & _
        ' "※" & Me.txtMthFm.Text & "※" & Me.txtMthTo.Text & _
        '  "※" & Me.cboVenFm.Text & "※" & Me.cboVenTo.Text & _
        '  "※" & OptRpt



        Me.Cursor = Cursors.WaitCursor
        rtnLong = execute_SQLStatement(gspStr, rs_IMR00013, rtnStr)
        Me.Cursor = Cursors.Default
        If rtnLong <> RC_SUCCESS Then  '*** An error has occured
            MsgBox("Error on loading Button_click SP_SELECT_IMR00013:" & rtnStr)
        Else
            ' rs_IMR00013 = rs(1)
            If rs_IMR00013.Tables("RESULT").Rows.Count <= 0 Then
                MsgBox("No Record Found")
                Exit Sub
            End If


            Dim objRpt As Object
            If OPTRPT = "ANL" Then
                objRpt = New IMR00013aRpt
            ElseIf OPTRPT = "DTL" Then
                objRpt = New IMR00013bRpt
            ElseIf OPTRPT = "LST" Then
                objRpt = New IMR00013cRpt
            ElseIf OPTRPT = "ORD" Then
                'New report type "ORD"
                objRpt = New IMR00013dRpt
            End If

            objRpt.SetDataSource(rs_IMR00013.Tables("RESULT"))

            Dim frmReportView As New frmReport
            frmReportView.CrystalReportViewer.ReportSource = objRpt
            frmReportView.Show()

        End If
    End Sub
    Private Function Check_Date(ByVal dtTempFM As MaskedTextBox, ByVal dtTempTO As MaskedTextBox) As Boolean
        Check_Date = True

        'Check Field Issue Date From whether is empty
        If dtTempFM.Text = "__/__/____" Then
            MsgBox("Item Issue Date From is empty!")
            dtTempFM.Focus()
            'Call HighlightMask(dtTempFM)
            Check_Date = False
            Exit Function
        End If

        'Check Field Issue Date To whether is empty
        If dtTempTO.Text = "__/__/____" Then
            MsgBox("Item Issue Date To is empty!")
            dtTempTO.Focus()
            ' Call HighlightMask(dtTempTO)
            Check_Date = False
            Exit Function
        End If


        'Check the Issue Date From
        If dtTempFM.Text <> "__/__/____" Then
            If IsDate(dtTempFM.Text) = False Then
                MsgBox("Invalid Enter in Issue Date From!")
                dtTempFM.Focus()
                Check_Date = False
                Exit Function
            End If
        End If

        'Check the Issue Date To
        If dtTempTO.Text <> "__/__/____" Then
            If IsDate(dtTempTO.Text) = False Then
                MsgBox("Invalid Enter in Issue Date To!")
                dtTempTO.Focus()
                Check_Date = False
                Exit Function
            End If
        End If

        'Compare Issue Date From with To
        If dtTempFM.Text <> "__/__/____" And dtTempTO.Text <> "__/__/____" Then
            If Mid(dtTempFM.Text, 7) > Mid(dtTempTO.Text, 7) Then
                MsgBox("Issue Date: End Date < Start date ! (YY)")
                dtTempFM.Focus()
                ' Call HighlightMask(dtTempFM)
                Check_Date = False
                Exit Function
            ElseIf Mid(dtTempFM.Text, 7) = Mid(dtTempTO.Text, 7) Then
                If Strings.Left(dtTempFM.Text, 2) > Strings.Left(dtTempTO.Text, 2) Then
                    MsgBox("Issue Date: End Date < Start date ! (MM)")
                    dtTempFM.Focus()
                    '    Call HighlightMask(dtTempFM)
                    Check_Date = False
                    Exit Function
                ElseIf Strings.Left(dtTempFM.Text, 2) = Strings.Left(dtTempTO.Text, 2) Then
                    If Mid(dtTempFM.Text, 4, 2) > Mid(dtTempTO.Text, 4, 2) Then
                        MsgBox("Issue Date: End Date < Start date ! (DD)")
                        dtTempFM.Focus()
                        '    Call HighlightMask(dtTempFM)
                        Check_Date = False
                        Exit Function
                    End If
                End If
            End If
        End If


    End Function

    Private Sub txtSDateFM_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSDateFM.TextChanged
        txtSDateTO.Text = txtSDateFM.Text
    End Sub
End Class