﻿Public Class SYM00003
    Inherits System.Windows.Forms.Form

    Dim rs_sycolinf As New DataSet
    Dim bindSrc As New BindingSource
    Dim save_ok As Boolean
    Dim CanModify As Boolean = True
    Dim Enq_right_local As Boolean
    Dim Del_right_local As Boolean

    Private Sub SYM00003_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            Me.Cursor = Windows.Forms.Cursors.WaitCursor

            Call AccessRight(Me.Name)
            Enq_right_local = Enq_right
            Del_right_local = Del_right

            gspStr = "sp_select_SYCOLINF '" & gsCompany & "'"
            rtnLong = execute_SQLStatement(gspStr, rs_sycolinf, rtnStr)
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SYM00003 sp_select_SYCOLINF : " & rtnStr)
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
        Dim dt As DataTable = rs_sycolinf.Tables("RESULT")

        If Not dt Is Nothing Then
            For Each dc As DataColumn In dt.Columns
                dc.ReadOnly = False
            Next
            For Each dr As DataRow In dt.Rows
                dr.Item("yci_status") = ""
            Next
            rs_sycolinf.AcceptChanges()
        End If
    End Sub

    Private Sub displayGrid()
        Dim i As Integer
        Dim dv As DataView = rs_sycolinf.Tables("RESULT").DefaultView
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
                        .Columns(i).Width = 200
                        .Columns(i).HeaderText = "Color Code"
                    Case 3
                        .Columns(i).Width = 632
                        .Columns(i).HeaderText = "Color Description"
                        .Columns(i).ReadOnly = False
                    Case Else
                        .Columns(i).Visible = False
                End Select
                .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
            Next i
            .ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing
            .ColumnHeadersHeight = 28
        End With

        If Not dv.Count = 0 Then
            dv.Sort = "yci_upddat desc"
            Dim drv As DataRowView = dv(0)
            Me.StatusBar.Items("lblRight").Text = Format(drv.Item("yci_credat"), "MM/dd/yyyy") & " " & Format(drv.Item("yci_upddat"), "MM/dd/yyyy") & " " & drv.Item("yci_updusr")

            dv.Sort = Nothing
        End If
    End Sub

    Private Sub setStatus(ByVal mode As String)

        If mode = "Init" Then
            'cmdAdd.Enabled = False
            'cmdSave.Enabled = False
            'cmdDelete.Enabled = False
            'cmdCopy.Enabled = False
            'cmdFind.Enabled = False
            'cmdInsRow.Enabled = Enq_right_local
            'cmdDelRow.Enabled = Del_right_local
            'cmdExit.Enabled = True
            'cmdClear.Enabled = False
            'cmdSearch.Enabled = False

            mmdAdd.Enabled = False
            mmdSave.Enabled = False
            mmdDelete.Enabled = False
            mmdCopy.Enabled = False
            mmdFind.Enabled = False
            mmdInsRow.Enabled = Enq_right_local
            mmdDelRow.Enabled = Del_right_local
            mmdExit.Enabled = True
            mmdClear.Enabled = False
            mmdSearch.Enabled = False

            'cmdFirst.Enabled = False
            'cmdLast.Enabled = False
            'cmdNext.Enabled = False
            'cmdPrevious.Enabled = False

            mmdPrint.Enabled = False
            mmdAttach.Enabled = False
            mmdFunction.Enabled = False
            mmdLink.Enabled = False
            Call ResetDefaultDisp()
            Call SetStatusBar(mode)

        ElseIf mode = "InsRow" Then
            'cmdCopy.Enabled = False
            'cmdFind.Enabled = False
            'cmdSave.Enabled = Enq_right_local
            'cmdDelRow.Enabled = Del_right_local

            mmdCopy.Enabled = False
            mmdFind.Enabled = False
            mmdSave.Enabled = Enq_right_local
            mmdDelRow.Enabled = Del_right_local

            mmdPrint.Enabled = False
            mmdAttach.Enabled = False
            mmdFunction.Enabled = False
            mmdLink.Enabled = False
            Call SetStatusBar(mode)

        ElseIf mode = "Save" Then
            Call ResetDefaultDisp()
            Call SetStatusBar(mode)
            MsgBox("Record Saved!")
            Call SYM00003_Load(Nothing, Nothing)

        ElseIf mode = "DelRow" Then
            'cmdCopy.Enabled = False
            'cmdFind.Enabled = False
            'cmdSave.Enabled = Enq_right_local
            'cmdDelRow.Enabled = Del_right_local

            mmdCopy.Enabled = False
            mmdFind.Enabled = False
            mmdSave.Enabled = Enq_right_local
            mmdDelRow.Enabled = Del_right_local

            mmdPrint.Enabled = False
            mmdAttach.Enabled = False
            mmdFunction.Enabled = False
            mmdLink.Enabled = False
            Call SetStatusBar(mode)

        ElseIf mode = "Clear" Then
            Call ResetDefaultDisp()
            Call SetStatusBar(mode)

        End If

        If Not CanModify Then
            'cmdAdd.Enabled = False
            'cmdSave.Enabled = False
            'cmdDelete.Enabled = False
            'cmdInsRow.Enabled = False
            'cmdDelRow.Enabled = False

            mmdAdd.Enabled = False
            mmdSave.Enabled = False
            mmdDelete.Enabled = False
            mmdInsRow.Enabled = False
            mmdDelRow.Enabled = False

            mmdPrint.Enabled = False
            mmdAttach.Enabled = False
            mmdFunction.Enabled = False
            mmdLink.Enabled = False
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

            ' Toggle Delete
            If e.ColumnIndex = 0 Then
                If Not row.Cells("yci_colcde").Value.ToString = "" Then
                    Call mmdDelRow_Click(sender, e)
                End If

                ' Disable color code change of existing record
            ElseIf e.ColumnIndex = 2 Then
                If row.Cells("yci_credat").Value.ToString = "" And row.Cells("yci_status").Value.ToString = "" Then
                    row.Cells(e.ColumnIndex).ReadOnly = False
                    DataGrid.BeginEdit(True)
                    'cmdSave.Enabled = Enq_right_local
                    mmdSave.Enabled = Enq_right_local
                Else
                    row.Cells(e.ColumnIndex).ReadOnly = True
                End If

            ElseIf e.ColumnIndex = 3 Then
                DataGrid.BeginEdit(True)
                'cmdSave.Enabled = Enq_right_local
                mmdSave.Enabled = Enq_right_local
            End If
        End If
    End Sub

    Private Sub DataGrid_CellValidating(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellValidatingEventArgs) Handles DataGrid.CellValidating
        Dim row As DataGridViewRow = DataGrid.CurrentRow
        Dim strNewVal As String

        strNewVal = row.Cells(e.ColumnIndex).EditedFormattedValue.ToString.Trim

        If row.Cells(e.ColumnIndex).IsInEditMode Then

            If e.ColumnIndex = 2 Then
                If Not chkGrdCellValue(row.Cells("yci_colcde"), "String", 30) Then
                    e.Cancel = True
                Else
                    For Each drr As DataGridViewRow In DataGrid.Rows
                        If drr.Index <> e.RowIndex Then
                            If drr.Cells("yci_colcde").Value.ToString = strNewVal Then
                                MsgBox("Duplicated color code!")
                                e.Cancel = True
                                Exit For
                            End If
                        End If
                    Next
                End If
            End If

            If e.ColumnIndex = 3 Then
                If Not chkGrdCellValue(row.Cells("yci_coldsc"), "String", 200) Then
                    e.Cancel = True
                End If
            End If
        End If
    End Sub

    Private Sub mmdInsRow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdInsRow.Click

        Dim dt As DataTable
        Dim dr As DataRow

        dt = rs_sycolinf.Tables("RESULT")
        For Each dr In dt.Rows
            If dr.Item("yci_colcde").ToString.Trim = "" Then
                MsgBox("Please input color code.")
                Exit Sub
            End If
        Next

        dr = dt.NewRow
        dr.Item("yci_status") = ""
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

    Private Sub mmdDelRow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdDelRow.Click
        Dim row As DataGridViewRow = DataGrid.CurrentRow
        Dim cellStyle As New DataGridViewCellStyle

        ' Toggle Delete
        If Not row Is Nothing Then
            If Not row.Cells("yci_colcde").Value.ToString = "" Then
                If row.Cells("yci_status").Value.ToString = "" Then
                    row.Cells("yci_status").Value = "Y"
                    cellStyle.BackColor = Color.LightBlue
                Else
                    row.Cells("yci_status").Value = ""
                    cellStyle.BackColor = Nothing
                End If
                row.DataGridView.CurrentRow.DefaultCellStyle = cellStyle
            End If
            Call setStatus("DelRow")
        End If

    End Sub

    Private Sub mmdSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles mmdSave.Click
        If checkFocus(Me) Then Exit Sub
        Dim flgErr As Boolean = False

        Try
            Me.Cursor = Windows.Forms.Cursors.WaitCursor

            save_ok = True
            bindSrc.EndEdit()
            For Each row As DataGridViewRow In DataGrid.Rows

                If row.Cells("yci_status").Value.ToString = "" Then

                    If Not chkGrdCellValue(row.Cells("yci_colcde"), "String", 30) Then
                        save_ok = False

                    ElseIf Not chkGrdCellValue(row.Cells("yci_coldsc"), "String", 200) Then
                        save_ok = False
                    Else
                        If row.Cells("yci_credat").Value.ToString = "" Then
                            For Each drr As DataGridViewRow In DataGrid.Rows
                                If drr.Index <> row.Index Then
                                    If drr.Cells("yci_colcde").Value.ToString = row.Cells("yci_colcde").Value.ToString And _
                                       drr.Cells("yci_status").Value.ToString = "" Then

                                        MsgBox("Duplicated color code " & drr.Cells("yci_colcde").Value.ToString & "!")
                                        save_ok = False
                                        row.DataGridView.CurrentCell = row.Cells("yci_colcde")
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
                For Each dr As DataRow In rs_sycolinf.Tables("RESULT").Rows

                    If dr.RowState = DataRowState.Modified Then
                        If dr.Item("yci_status") = "Y" Then
                            gspStr = "sp_physical_delete_SYCOLINF '" & gsCompany & "','" & _
                                        dr.Item("yci_colcde").ToString.Replace("'", "''").Trim & "','" & _
                                        gsUsrID & "'"
                        Else
                            gspStr = "sp_update_SYCOLINF '" & gsCompany & "','" & _
                                        dr.Item("yci_colcde").ToString.ToUpper.Replace("'", "''").Trim & "','" & _
                                        dr.Item("yci_coldsc").ToString.Replace("'", "''").Trim & "','" & _
                                        gsUsrID & "'"
                        End If
                    ElseIf dr.RowState = DataRowState.Added And Not dr.Item("yci_status") = "Y" Then

                        If dr.Item("yci_credat").ToString.Trim = "" Then
                            gspStr = "sp_insert_SYCOLINF '" & gsCompany & "','" & _
                                        dr.Item("yci_colcde").ToString.ToUpper.Replace("'", "''").Trim & "','" & _
                                        dr.Item("yci_coldsc").ToString.Replace("'", "''").Trim & "','" & _
                                        gsUsrID & "'"
                        End If
                    End If

                    If gspStr <> "" Then
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                        If rtnLong <> RC_SUCCESS Then
                            MsgBox("Error on loading SYM00003 sp_update_SYDOCCTL : " & rtnStr)
                            flgErr = True
                            Exit For
                        End If
                        gspStr = ""
                    End If
                Next

                If Not flgErr Then
                    rs_sycolinf.AcceptChanges()
                    Call setStatus("Save")
                Else
                    save_ok = False
                    rs_sycolinf.RejectChanges()
                    MsgBox("Record Not Updated!")
                End If
            End If

        Finally
            Me.Cursor = Windows.Forms.Cursors.Default
        End Try
    End Sub

    Private Sub SYM00003_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Dim YNC As Integer
        Dim flgMod As Boolean = False

        bindSrc.EndEdit()

        If Enq_right_local = False Then
            Exit Sub
        End If

        For Each dr As DataRow In rs_sycolinf.Tables("RESULT").Rows
            If dr.RowState = DataRowState.Modified Or dr.RowState = DataRowState.Added Then
                flgMod = True
            End If
        Next

        If flgMod Then
            YNC = MessageBox.Show("Record has been modified. Do you want to save before exit?", "Question", MessageBoxButtons.YesNoCancel)

            If YNC = Windows.Forms.DialogResult.Yes Then
                If Enq_right_local Then
                    Call mmdSave_Click(sender, e)

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

    Private Sub mmdExit_Click() Handles mmdExit.Click
        If checkFocus(Me) Then Exit Sub
        Me.Close()
    End Sub

    Private Sub mmdExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles mmdExit.Click

    End Sub

   
End Class