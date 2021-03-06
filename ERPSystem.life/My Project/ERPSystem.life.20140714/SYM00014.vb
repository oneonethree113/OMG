﻿Public Class SYM00014

    Dim rs_sysmptrm As New DataSet
    Dim bindSrc As New BindingSource
    Dim save_ok As Boolean
    Dim CanModify As Boolean = True
    Dim Enq_right_local As Boolean
    Dim Del_right_local As Boolean

    Private Sub SYM00014_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            Me.Cursor = Windows.Forms.Cursors.WaitCursor

            Call AccessRight(Me.Name)
            Enq_right_local = Enq_right
            Del_right_local = Del_right

            gspStr = "sp_select_SYSMPTRM '" & gsCompany & "'"
            rtnLong = execute_SQLStatement(gspStr, rs_sysmptrm, rtnStr)
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SYM00014 sp_select_SYSMPTRM : " & rtnStr)
            Else
                Call setDataRowAttr()
                Call displayGrid()
                Call setStatus("Init")
            End If
            Call Formstartup(Me.Name)
        Finally
            Me.Cursor = Windows.Forms.Cursors.Default
        End Try
    End Sub

    Private Sub setDataRowAttr()

        Dim dt As DataTable = rs_sysmptrm.Tables("RESULT")

        If Not dt Is Nothing Then
            For Each dc As DataColumn In dt.Columns
                dc.ReadOnly = False
            Next
            For Each dr As DataRow In dt.Rows
                dr.Item("yst_status") = ""
            Next
            rs_sysmptrm.AcceptChanges()
        End If
    End Sub

    Private Sub displayGrid()
        Dim i As Integer
        Dim dv As DataView = rs_sysmptrm.Tables("RESULT").DefaultView
        bindSrc.DataSource = dv

        With DataGrid
            .DataSource = Nothing
            .DataSource = bindSrc
            For i = 0 To .Columns.Count - 1
                Select Case i
                    Case 0
                        .Columns(i).Width = 40
                        .Columns(i).HeaderText = "Del"
                        .Columns(i).ReadOnly = True
                    Case 2
                        .Columns(i).Width = 140
                        .Columns(i).HeaderText = "Term Code"
                    Case 3
                        .Columns(i).Width = 300
                        .Columns(i).HeaderText = "Description"
                        .Columns(i).ReadOnly = False
                    Case 4
                        .Columns(i).Width = 95
                        .Columns(i).HeaderText = "Percent/Qty"
                        .Columns(i).ReadOnly = True
                    Case 5
                        .Columns(i).Width = 95
                        .Columns(i).HeaderText = "Percent/Qty Free"
                        .Columns(i).ReadOnly = False
                    Case Else
                        .Columns(i).Visible = False
                End Select
                .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
            Next i
        End With

        If Not dv.Count = 0 Then
            dv.Sort = "yst_upddat desc"
            Dim drv As DataRowView = dv(0)
            Me.StatusBar.Items("lblRight").Text = Format(drv.Item("yst_credat"), "MM/dd/yyyy") & " " & Format(drv.Item("yst_upddat"), "MM/dd/yyyy") & " " & drv.Item("yst_updusr")

            dv.Sort = Nothing
        End If
    End Sub

    Private Sub setStatus(ByVal mode As String)

        If mode = "Init" Then
            cmdAdd.Enabled = False
            cmdSave.Enabled = False
            cmdDelete.Enabled = False
            cmdCopy.Enabled = False
            cmdFind.Enabled = False
            cmdInsRow.Enabled = Enq_right_local
            cmdDelRow.Enabled = Del_right_local
            cmdExit.Enabled = True
            cmdClear.Enabled = False
            cmdSearch.Enabled = False

            cmdFirst.Enabled = False
            cmdLast.Enabled = False
            cmdNext.Enabled = False
            cmdPrevious.Enabled = False

            Call ResetDefaultDisp()
            Call SetStatusBar(mode)

        ElseIf mode = "InsRow" Then
            cmdCopy.Enabled = False
            cmdFind.Enabled = False
            cmdSave.Enabled = Enq_right_local
            cmdDelRow.Enabled = Del_right_local
            Call SetStatusBar(mode)

        ElseIf mode = "Save" Then
            Call ResetDefaultDisp()
            Call SetStatusBar(mode)
            MsgBox("Record Saved!")
            Call SYM00014_Load(Nothing, Nothing)

        ElseIf mode = "DelRow" Then
            cmdCopy.Enabled = False
            cmdFind.Enabled = False
            cmdSave.Enabled = Enq_right_local
            cmdDelRow.Enabled = Del_right_local
            Call SetStatusBar(mode)

        ElseIf mode = "Clear" Then
            Call ResetDefaultDisp()
            Call SetStatusBar(mode)

        End If

        If Not CanModify Then
            cmdAdd.Enabled = False
            cmdSave.Enabled = False
            cmdDelete.Enabled = False
            cmdInsRow.Enabled = False
            cmdDelRow.Enabled = False

            Call ResetDefaultDisp()
            Call SetStatusBar("ReadOnly")
        End If
    End Sub

    Private Sub SetStatusBar(ByVal mode As String)

        If mode = "Init" Then
            Me.StatusBar.Items("lblLeft").Text = "Init"
        ElseIf mode = "InsRow" Then
            Me.StatusBar.Items("lblLeft").Text = "Insert Row"
        ElseIf mode = "Updating" Then
            Me.StatusBar.Items("lblLeft").Text = "Updating"
        ElseIf mode = "Save" Then
            Me.StatusBar.Items("lblLeft").Text = "Record Saved"
        ElseIf mode = "DelRow" Then
            Me.StatusBar.Items("lblLeft").Text = "Record Row Deleted"
        ElseIf mode = "ReadOnly" Then
            Me.StatusBar.Items("lblLeft").Text = "Read Only"
        ElseIf mode = "Clear" Then
            Me.StatusBar.Items("lblLeft").Text = "Clear Screen"
        End If

    End Sub

    Private Sub ResetDefaultDisp()
        Me.StatusBar.Items("lblLeft").Text = ""
    End Sub

    Private Sub DataGrid_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGrid.CellClick
        Dim row As DataGridViewRow = DataGrid.CurrentRow

        If Not e.RowIndex = -1 Then

            If e.ColumnIndex = 0 Then
                ' Toggle Delete
                If Not row.Cells("yst_trmcde").Value.ToString = "" Then
                    Call cmdDelRow_Click(sender, e)
                End If

                ' Toggle Charge
            ElseIf e.ColumnIndex = 4 Then
                If row.Cells("yst_credat").Value.ToString = "" Then
                    If row.Cells("yst_charge").Value.ToString = "P" Then
                        row.Cells("yst_charge").Value = "Q"
                    Else
                        row.Cells("yst_charge").Value = "P"
                    End If
                    cmdSave.Enabled = Enq_right_local
                End If

                ' Disable term code change of existing record
            ElseIf e.ColumnIndex = 2 Then
                If row.Cells("yst_credat").Value.ToString = "" And row.Cells("yst_status").Value.ToString = "" Then
                    row.Cells(e.ColumnIndex).ReadOnly = False
                    DataGrid.BeginEdit(True)
                    cmdSave.Enabled = Enq_right_local
                Else
                    row.Cells(e.ColumnIndex).ReadOnly = True
                End If

            ElseIf e.ColumnIndex = 3 OrElse e.ColumnIndex = 5 Then
                DataGrid.BeginEdit(True)
                cmdSave.Enabled = Enq_right_local
            End If
        End If
    End Sub

    Private Sub DataGrid_CellValidating(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellValidatingEventArgs) Handles DataGrid.CellValidating
        Dim row As DataGridViewRow = DataGrid.CurrentRow
        Dim strNewVal As String

        strNewVal = row.Cells(e.ColumnIndex).EditedFormattedValue.ToString.Trim

        If row.Cells(e.ColumnIndex).IsInEditMode Then

            If e.ColumnIndex = 2 Then
                If Not chkGrdCellValue(row.Cells("yst_trmcde"), "String", 6) Then
                    e.Cancel = True
                Else
                    For Each drr As DataGridViewRow In DataGrid.Rows
                        If drr.Index <> e.RowIndex Then
                            If drr.Cells("yst_trmcde").Value.ToString = strNewVal Then
                                MsgBox("Duplicated term code!")
                                e.Cancel = True
                                Exit For
                            End If
                        End If
                    Next
                End If
            End If

            If e.ColumnIndex = 3 Then
                If Not chkGrdCellValue(row.Cells("yst_trmdsc"), "String", 200) Then
                    e.Cancel = True
                End If
            End If

            If e.ColumnIndex = 5 Then
                If Not chkGrdCellValue(row.Cells("yst_chgval"), "Z+Integer") Then
                    e.Cancel = True
                ElseIf row.Cells("yst_charge").Value.ToString = "P" And (strNewVal < 0 Or strNewVal > 100) Then
                    MsgBox("Percent free should be between 0 and 100!")
                    e.Cancel = True
                End If
            End If
        End If

    End Sub

    Private Sub cmdInsRow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdInsRow.Click
        Dim dt As DataTable
        Dim dr As DataRow

        dt = rs_sysmptrm.Tables("RESULT")
        For Each dr In dt.Rows
            If dr.Item("yst_trmcde").ToString.Trim = "" Then
                MsgBox("Please input term code.")
                Exit Sub
            End If
        Next

        dr = dt.NewRow
        dr.Item("yst_status") = ""
        dr.Item("yst_charge") = "P"
        dr.Item("yst_chgval") = 0
        dt.Rows.Add(dr)

        For Each drr As DataGridViewRow In DataGrid.Rows
            If IsDBNull(drr.Cells(2).Value) Then
                DataGrid.CurrentCell = drr.Cells(2)
                DataGrid.CurrentCell.ReadOnly = False
                DataGrid.BeginEdit(True)
            End If
        Next
        Call setStatus("InsRow")
    End Sub

    Private Sub cmdDelRow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDelRow.Click
        Dim row As DataGridViewRow = DataGrid.CurrentRow
        Dim cellStyle As New DataGridViewCellStyle

        ' Toggle Delete
        If Not row Is Nothing Then
            If Not row.Cells("yst_trmcde").Value.ToString = "" Then
                If row.Cells("yst_status").Value.ToString = "" Then
                    row.Cells("yst_status").Value = "Y"
                    cellStyle.BackColor = Color.LightBlue
                Else
                    row.Cells("yst_status").Value = ""
                    cellStyle.BackColor = Nothing
                End If
                row.DataGridView.CurrentRow.DefaultCellStyle = cellStyle
            End If
            Call setStatus("DelRow")
        End If

    End Sub

    Private Sub cmdSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSave.Click
        Dim flgErr As Boolean = False

        Try
            Me.Cursor = Windows.Forms.Cursors.WaitCursor

            save_ok = True
            bindSrc.EndEdit()
            For Each row As DataGridViewRow In DataGrid.Rows

                If row.Cells("yst_status").Value.ToString = "" Then

                    If Not chkGrdCellValue(row.Cells("yst_trmcde"), "String", 6) Then
                        save_ok = False

                    ElseIf Not chkGrdCellValue(row.Cells("yst_trmdsc"), "String", 200) Then
                        save_ok = False

                    ElseIf Not chkGrdCellValue(row.Cells("yst_chgval"), "Z+Integer") Then
                        save_ok = False

                    ElseIf row.Cells("yst_charge").Value.ToString = "P" And (row.Cells("yst_chgval").Value < 0 Or row.Cells("yst_chgval").Value > 100) Then
                        MsgBox("Percent/qty free should be between 0 and 100!")
                        save_ok = False
                        row.DataGridView.CurrentCell = row.Cells("yst_charge")

                    Else
                        If row.Cells("yst_credat").Value.ToString = "" Then
                            For Each drr As DataGridViewRow In DataGrid.Rows
                                If drr.Index <> row.Index Then
                                    If drr.Cells("yst_trmcde").Value.ToString = row.Cells("yst_trmcde").Value.ToString And _
                                       drr.Cells("yst_status").Value.ToString = "" Then

                                        MsgBox("Duplicated term code " & drr.Cells("yst_trmcde").Value.ToString & "!")
                                        save_ok = False
                                        row.DataGridView.CurrentCell = row.Cells("yst_trmcde")
                                    End If
                                End If
                            Next
                        End If
                    End If
                End If

                If Not save_ok Then
                    Exit For
                End If
            Next

            If Not save_ok Then
                DataGrid.BeginEdit(True)
                Exit Sub
            Else
                gspStr = ""
                For Each dr As DataRow In rs_sysmptrm.Tables("RESULT").Rows

                    If dr.RowState = DataRowState.Modified Then
                        If dr.Item("yst_status") = "Y" Then
                            gspStr = "sp_physical_delete_SYSMPTRM '" & gsCompany & "','" & _
                                        dr.Item("yst_trmcde").ToString.Replace("'", "''").Trim & "'"
                        Else
                            gspStr = "sp_update_SYSMPTRM '" & gsCompany & "','" & _
                                        dr.Item("yst_trmcde").ToString.ToUpper.Replace("'", "''").Trim & "','" & _
                                        dr.Item("yst_trmdsc").ToString.Replace("'", "''").Trim & "','" & _
                                        dr.Item("yst_charge").ToString.Replace("'", "''").Trim & "'," & _
                                        dr.Item("yst_chgval").ToString.Replace("'", "''").Trim & ",'" & _
                                        gsUsrID & "'"
                        End If
                    ElseIf dr.RowState = DataRowState.Added And Not dr.Item("yst_status") = "Y" Then

                        If dr.Item("yst_credat").ToString.Trim = "" Then
                            gspStr = "sp_insert_SYSMPTRM '" & gsCompany & "','" & _
                                        dr.Item("yst_trmcde").ToString.ToUpper.Replace("'", "''").Trim & "','" & _
                                        dr.Item("yst_trmdsc").ToString.Replace("'", "''").Trim & "','" & _
                                        dr.Item("yst_charge").ToString.Replace("'", "''").Trim & "'," & _
                                        dr.Item("yst_chgval").ToString.Replace("'", "''").Trim & ",'" & _
                                        gsUsrID & "'"
                        End If
                    End If

                    If gspStr <> "" Then
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                        If rtnLong <> RC_SUCCESS Then
                            MsgBox("Error on loading SYM00014 sp_update_SYSMPTRM : " & rtnStr)
                            flgErr = True
                            Exit For
                        End If
                        gspStr = ""
                    End If
                Next

                If Not flgErr Then
                    rs_sysmptrm.AcceptChanges()
                    Call setStatus("Save")
                Else
                    save_ok = False
                    rs_sysmptrm.RejectChanges()
                    MsgBox("Record Not Updated!")
                End If
            End If

        Finally
            Me.Cursor = Windows.Forms.Cursors.Default
        End Try
    End Sub

    Private Sub SYM00014_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Dim YNC As Integer
        Dim flgMod As Boolean = False

        bindSrc.EndEdit()
        For Each dr As DataRow In rs_sysmptrm.Tables("RESULT").Rows
            If dr.RowState = DataRowState.Modified Or dr.RowState = DataRowState.Added Then
                flgMod = True
            End If
        Next

        If flgMod Then
            YNC = MessageBox.Show("Record has been modified. Do you want to save before exit?", "Question", MessageBoxButtons.YesNoCancel)

            If YNC = Windows.Forms.DialogResult.Yes Then
                If Enq_right_local Then
                    Call cmdSave_Click(sender, e)

                    If save_ok Then
                        e.Cancel = False
                    Else
                        e.Cancel = True
                    End If
                Else
                    MsgBox("Sorry! You have not right to save!")
                End If
            ElseIf YNC = Windows.Forms.DialogResult.No Then
                e.Cancel = False
            ElseIf YNC = Windows.Forms.DialogResult.Cancel Then
                e.Cancel = True
            End If
        Else
            e.Cancel = False
        End If

    End Sub

    Private Sub CmdExit_Click() Handles cmdExit.Click
        Me.Close()
    End Sub

End Class