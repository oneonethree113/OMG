﻿Public Class SYM00015
    Inherits System.Windows.Forms.Form

    Dim rs_syvenfml As New DataSet
    Dim rs_fmlInf As New DataSet
    Dim bindSrc As New BindingSource
    Dim save_ok As Boolean
    Dim CanModify As Boolean = True
    Dim Enq_right_local As Boolean
    Dim Del_right_local As Boolean

    Private Sub SYM00015_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            Me.Cursor = Windows.Forms.Cursors.WaitCursor

            Call AccessRight(Me.Name)
            Enq_right_local = Enq_right
            Del_right_local = Del_right

            Call FillComboVenno()
            Call FillComboMatCde()

            If Not rs_syvenfml Is Nothing Then
                rs_syvenfml = Nothing
            End If

            gspStr = "sp_select_SYVENFML '" & gsCompany & "','','',''"
            rtnLong = execute_SQLStatement(gspStr, rs_syvenfml, rtnStr)
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SYM00015 sp_select_SYVENFML : " & rtnStr)
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
        Dim dt As DataTable = rs_syvenfml.Tables("RESULT")

        If Not dt Is Nothing Then
            For Each dc As DataColumn In dt.Columns
                dc.ReadOnly = False
            Next
            For Each dr As DataRow In dt.Rows
                dr.Item("yvf_status") = ""
            Next
            rs_syvenfml.AcceptChanges()
        End If
    End Sub

    Private Sub FillComboVenno()
        Dim rs_venno As New DataSet

        Try
            gspStr = "sp_list_SYSVNFOR '" & gsCompany & "'"
            rtnLong = execute_SQLStatement(gspStr, rs_venno, rtnStr)
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SYM00015 sp_list_SYSVNFOR : " & rtnStr)
            Else
                Me.cboVenno.Items.Clear()
                For Each dr As DataRow In rs_venno.Tables("RESULT").Rows
                    Me.cboVenno.Items.Add(dr.Item("vbi_venno").ToString & " - " & dr.Item("vbi_vensna").ToString)
                Next
            End If
        Finally
            rs_venno = Nothing
            Me.Cursor = Windows.Forms.Cursors.Default
        End Try
    End Sub

    Private Sub FillComboMatCde()
        Dim rs_matcde As New DataSet

        Try
            gspStr = "sp_select_SYSETINF_All '" & gsCompany & "','25'"
            rtnLong = execute_SQLStatement(gspStr, rs_matcde, rtnStr)
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SYM00015 sp_select_SYSETINF_All : " & rtnStr)
            Else
                Me.cboMatcde.Items.Clear()
                For Each dr As DataRow In rs_matcde.Tables("RESULT").Rows
                    Me.cboMatcde.Items.Add(dr.Item("ysi_cde").ToString & " - " & dr.Item("ysi_dsc").ToString)
                Next
            End If
        Finally
            rs_matcde = Nothing
            Me.Cursor = Windows.Forms.Cursors.Default
        End Try
    End Sub

    Private Sub cboVenno_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboVenno.SelectedIndexChanged
        cboMatcde.SelectedIndex = -1
        Call setStatus("Init")
    End Sub

    Private Sub cboMatCde_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cboMatcde.SelectedIndexChanged
        If Not cboVenno.SelectedItem Is Nothing Then
            Call ShowGrdDtl()
        End If
    End Sub

    Private Sub cmdClear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdClear.Click
        Dim YNC As Integer
        Dim flgMod As Boolean = False

        bindSrc.EndEdit()
        For Each dr As DataRow In rs_syvenfml.Tables("RESULT").Rows
            If dr.RowState = DataRowState.Modified Or dr.RowState = DataRowState.Added Then
                flgMod = True
            End If
        Next

        If flgMod Then
            YNC = MessageBox.Show("Record has been modified. Do you want to save?", "Question", MessageBoxButtons.YesNoCancel)

            If YNC = Windows.Forms.DialogResult.Yes Then
                If Enq_right_local Then
                    Call cmdSave_Click(sender, e)

                    If save_ok Then
                        Call SYM00015_Load(Nothing, Nothing)
                    Else
                        Exit Sub
                    End If
                Else
                    MsgBox("Sorry! You have not right to save!")
                End If
            ElseIf YNC = Windows.Forms.DialogResult.No Then
                Call SYM00015_Load(Nothing, Nothing)

            ElseIf YNC = Windows.Forms.DialogResult.Cancel Then
                Exit Sub
            End If
        Else
            Call SYM00015_Load(Nothing, Nothing)
        End If

    End Sub

    Private Sub ShowGrdDtl()
        Dim strVenno, strMatCde As String

        Try
            Me.Cursor = Windows.Forms.Cursors.WaitCursor

            strVenno = Split(cboVenno.SelectedItem, " - ")(0).Trim
            strMatCde = Split(cboMatcde.SelectedItem, " - ")(0).Trim

            If Not rs_fmlInf Is Nothing Then
                rs_fmlInf = Nothing
            End If

            If Not rs_syvenfml Is Nothing Then
                rs_syvenfml = Nothing
            End If

            gspStr = "sp_list_SYFMLINF '" & gsCompany & "'"
            rtnLong = execute_SQLStatement(gspStr, rs_fmlInf, rtnStr)
            If rtnLong <> RC_SUCCESS Then
                MsgBox("Error on loading SYM00015 sp_list_SYFMLINF : " & rtnStr)
            Else
                gspStr = "sp_select_SYVENFML '" & gsCompany & "','" & strVenno & "','','" & strMatCde & "'"
                rtnLong = execute_SQLStatement(gspStr, rs_syvenfml, rtnStr)
                If rtnLong <> RC_SUCCESS Then
                    MsgBox("Error on loading SYM00015 sp_select_SYVENFML : " & rtnStr)
                Else
                    If rs_syvenfml.Tables("RESULT").Rows.Count = 0 Then
                        cmdInsRow.Enabled = Enq_right_local
                        cmdDelRow.Enabled = False
                    Else
                        cmdInsRow.Enabled = False
                        cmdDelRow.Enabled = False
                        If Enq_right_local = True Then
                            cmdInsRow.Enabled = Enq_right_local
                            cmdDelRow.Enabled = True
                        End If
                    End If
                    Call setDataRowAttr()
                    Call displayGrid()
                End If
            End If
        Finally
            Me.Cursor = Windows.Forms.Cursors.Default
        End Try
    End Sub

    Private Sub displayGrid()
        Dim i As Integer
        Dim dv As DataView = rs_syvenfml.Tables("RESULT").DefaultView
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
                    Case 3
                        .Columns(i).Width = 90
                        .Columns(i).HeaderText = "Option"
                    Case 4
                        .Columns(i).Width = 390
                        .Columns(i).HeaderText = "Price Markup Formula"
                        .Columns(i).ReadOnly = True
                    Case 5
                        .Columns(i).Width = 95
                        .Columns(i).HeaderText = "Formula"
                        .Columns(i).ReadOnly = True
                    Case 6
                        .Columns(i).Width = 50
                        .Columns(i).HeaderText = "Default"
                        .Columns(i).ReadOnly = True
                    Case Else
                        .Columns(i).Visible = False
                End Select
                .Columns(i).SortMode = DataGridViewColumnSortMode.NotSortable
            Next i
        End With

        If Not dv.Count = 0 Then
            dv.Sort = "yvf_upddat desc"
            Dim drv As DataRowView = dv(0)
            Me.StatusBar.Items("lblRight").Text = Format(drv.Item("yvf_credat"), "MM/dd/yyyy") & " " & Format(drv.Item("yvf_upddat"), "MM/dd/yyyy") & " " & drv.Item("yvf_updusr")

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
            cmdExit.Enabled = True
            cmdClear.Enabled = True
            cmdInsRow.Enabled = False
            cmdDelRow.Enabled = False
            cmdSearch.Enabled = False

            cmdFirst.Enabled = False
            cmdLast.Enabled = False
            cmdNext.Enabled = False
            cmdPrevious.Enabled = False
            cboVenno.Enabled = True
            cboMatcde.Enabled = True

            Call ResetDefaultDisp()
            Call SetStatusBar(mode)

        ElseIf mode = "InsRow" Then
            cmdCopy.Enabled = False
            cmdFind.Enabled = False
            cmdSave.Enabled = Enq_right_local
            cmdDelRow.Enabled = Del_right_local
            cboVenno.Enabled = False
            cboMatcde.Enabled = False
            Call SetStatusBar(mode)

        ElseIf mode = "Save" Then
            Call ResetDefaultDisp()
            Call SetStatusBar(mode)
            MsgBox("Record Saved!")
            Call SYM00015_Load(Nothing, Nothing)

        ElseIf mode = "DelRow" Then
            cmdCopy.Enabled = False
            cmdFind.Enabled = False
            cmdSave.Enabled = Enq_right_local
            cmdDelRow.Enabled = Del_right_local
            cboVenno.Enabled = False
            cboMatcde.Enabled = False
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

    Private Sub createComboBoxCell(ByVal cell As DataGridViewCell)
        Dim cboCell As New DataGridViewComboBoxCell
        Dim iCol As Integer = cell.ColumnIndex
        Dim iRow As Integer = cell.RowIndex
        Dim dgView As DataGridView = cell.DataGridView

        For Each dr As DataRow In rs_fmlInf.Tables("RESULT").Rows
            cboCell.Items.Add(dr.Item("yfi_fmlopt").ToString.Trim)
        Next
        cboCell.DropDownWidth = 150
        cboCell.DisplayStyle = DataGridViewComboBoxDisplayStyle.Nothing

        dgView.Rows(iRow).Cells(iCol) = cboCell
        dgView.Rows(iRow).Cells(iCol).ReadOnly = False
    End Sub

    Private Sub cboOpt_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim iRow As Integer = DataGrid.CurrentCell.RowIndex
        Dim strSelItem As String

        If TypeOf (Me.DataGrid.CurrentCell) Is DataGridViewComboBoxCell Then
            Dim cboBox As ComboBox = CType(sender, ComboBox)
            If Not cboBox Is Nothing AndAlso Not cboBox.SelectedItem Is Nothing Then

                ' User has changed the option
                strSelItem = cboBox.SelectedItem.ToString
                RemoveHandler cboBox.SelectedIndexChanged, AddressOf cboOpt_SelectedIndexChanged
                Me.DataGrid.Rows(iRow).Cells("yvf_fmlopt").Value = strSelItem
                Me.DataGrid.Rows(iRow).Cells("yfi_prcfml").Value = rs_fmlInf.Tables("RESULT").Select("yfi_fmlopt = '" & cboBox.SelectedItem.ToString & "'")(0).Item("yfi_prcfml").ToString
                Me.DataGrid.Rows(iRow).Cells("yfi_fml").Value = rs_fmlInf.Tables("RESULT").Select("yfi_fmlopt = '" & cboBox.SelectedItem.ToString & "'")(0).Item("yfi_fml").ToString
                AddHandler cboBox.SelectedIndexChanged, AddressOf cboOpt_SelectedIndexChanged
            End If
        End If
    End Sub

    Private Sub DataGrid_EditingControlShowing(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewEditingControlShowingEventArgs) Handles DataGrid.EditingControlShowing

        If DataGrid.CurrentCell.ColumnIndex = 3 Then
            If TypeOf (e.Control) Is DataGridViewComboBoxEditingControl Then
                Dim cboBox As ComboBox = CType(e.Control, ComboBox)
                If Not cboBox Is Nothing Then
                    RemoveHandler cboBox.SelectedIndexChanged, AddressOf cboOpt_SelectedIndexChanged
                    AddHandler cboBox.SelectedIndexChanged, AddressOf cboOpt_SelectedIndexChanged
                End If
            End If
        End If
    End Sub

    Private Sub DataGrid_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGrid.CellClick
        Dim row As DataGridViewRow = DataGrid.CurrentRow

        If Not e.RowIndex = -1 Then

            If e.ColumnIndex = 0 Then
                ' Toggle Delete
                If Not (row.Cells("yvf_fmlopt").Value.ToString = "" Or row.Cells("yvf_def").Value.ToString = "Y") Then
                    Call cmdDelRow_Click(sender, e)
                End If

            ElseIf e.ColumnIndex = 3 Then
                If row.Cells("yvf_credat").Value.ToString = "" And row.Cells("yvf_status").Value.ToString = "" Then
                    If TypeOf (DataGrid.CurrentCell) Is DataGridViewTextBoxCell Then
                        createComboBoxCell(DataGrid.CurrentCell)
                        DataGrid.BeginEdit(True)
                        cmdSave.Enabled = Enq_right_local
                    End If
                Else
                    row.Cells(e.ColumnIndex).ReadOnly = True
                End If

            ElseIf e.ColumnIndex = 6 Then
                If row.Cells("yvf_status").Value.ToString = "" And row.Cells("yvf_def").Value.ToString = "N" Then
                    For Each dr As DataRow In rs_syvenfml.Tables("RESULT").Rows
                        If dr.Item("yvf_def").ToString = "Y" Then
                            dr.Item("yvf_def") = "N"
                        End If
                    Next
                    row.Cells("yvf_def").Value = "Y"
                    cmdSave.Enabled = Enq_right_local
                End If
            End If
        End If
    End Sub

    Private Sub DataGrid_CellValidating(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellValidatingEventArgs) Handles DataGrid.CellValidating
        Dim row As DataGridViewRow = DataGrid.CurrentRow
        Dim strNewVal As String

        strNewVal = row.Cells(e.ColumnIndex).EditedFormattedValue.ToString.Trim

        If row.Cells(e.ColumnIndex).IsInEditMode Then

            If e.ColumnIndex = 3 Then

                If Not chkGrdCellValue(row.Cells("yvf_fmlopt"), "String", 5) Then
                    e.Cancel = True
                Else
                    For Each drr As DataGridViewRow In DataGrid.Rows
                        If drr.Index <> e.RowIndex Then
                            If drr.Cells("yvf_fmlopt").Value.ToString.ToUpper = strNewVal.ToUpper Then
                                MsgBox("Duplicated option code!")
                                e.Cancel = True
                                Exit For
                            End If
                        End If
                    Next
                End If
            End If
            End If

    End Sub

    Private Sub cmdInsRow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdInsRow.Click
        Dim dt As DataTable
        Dim dr As DataRow

        dt = rs_syvenfml.Tables("RESULT")
        For Each dr In dt.Rows
            If dr.Item("yvf_fmlopt").ToString.Trim = "" Then
                MsgBox("Please input option code.")
                Exit Sub
            End If
        Next

        If rs_syvenfml.Tables("RESULT").Rows.Count > 0 Then
            dr = dt.NewRow
            dr.Item("yvf_status") = ""
            dr.Item("yvf_effdat") = System.DateTime.Now.ToString("MM/dd/yyyy")
            dr.Item("yvf_def") = "N"
            dt.Rows.Add(dr)
        Else
            dr = dt.NewRow
            dr.Item("yvf_status") = ""
            dr.Item("yvf_effdat") = System.DateTime.Now.ToString("MM/dd/yyyy")
            dr.Item("yvf_def") = "Y"
            dt.Rows.Add(dr)
        End If

        For Each drr As DataGridViewRow In DataGrid.Rows
            If IsDBNull(drr.Cells(3).Value) Then
                DataGrid.CurrentCell = drr.Cells(3)
                createComboBoxCell(DataGrid.CurrentCell)
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
            If Not (row.Cells("yvf_fmlopt").Value.ToString = "" Or row.Cells("yvf_def").Value.ToString = "Y") Then
                If row.Cells("yvf_status").Value.ToString = "" Then
                    row.Cells("yvf_status").Value = "Y"
                    cellStyle.BackColor = Color.LightBlue
                Else
                    row.Cells("yvf_status").Value = ""
                    cellStyle.BackColor = Nothing
                End If
                row.DataGridView.CurrentRow.DefaultCellStyle = cellStyle
                Call setStatus("DelRow")
            End If
        End If

    End Sub

    Private Sub cmdSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSave.Click
        Dim strVenno, strMatcde As String
        Dim flgErr As Boolean = False
        Dim flgReAct As Boolean = False

        Try
            Me.Cursor = Windows.Forms.Cursors.WaitCursor

            save_ok = True
            bindSrc.EndEdit()
            For Each row As DataGridViewRow In DataGrid.Rows

                If row.Cells("yvf_status").Value.ToString = "" Then

                    If Not chkGrdCellValue(row.Cells("yvf_fmlopt"), "String", 5) Then
                        save_ok = False
                        flgReAct = True
                    Else
                        If row.Cells("yvf_credat").Value.ToString = "" Then
                            For Each drr As DataGridViewRow In DataGrid.Rows
                                If drr.Index <> row.Index Then
                                    If drr.Cells("yvf_fmlopt").Value.ToString.ToUpper = row.Cells("yvf_fmlopt").Value.ToString.ToUpper And _
                                       drr.Cells("yvf_status").Value.ToString = "" Then

                                        MsgBox("Duplicated option code " & drr.Cells("yvf_fmlopt").Value.ToString & "!")
                                        save_ok = False
                                        flgReAct = True
                                        row.DataGridView.CurrentCell = row.Cells("yvf_fmlopt")
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
                With DataGrid
                    If flgReAct Then
                        ' if flgReAct = T, reactivate combo box
                        createComboBoxCell(.CurrentCell)
                    End If
                    .BeginEdit(True)
                End With
                Exit Sub
            Else
                gspStr = ""
                strVenno = Split(cboVenno.SelectedItem, " - ")(0).ToString.Replace("'", "''").Trim
                strMatcde = Split(cboMatcde.SelectedItem, " - ")(0).ToString.Replace("'", "''").Trim
                For Each dr As DataRow In rs_syvenfml.Tables("RESULT").Rows

                    If dr.RowState = DataRowState.Modified Then
                        If dr.Item("yvf_status") = "Y" Then
                            gspStr = "sp_physical_delete_SYVENFML '" & gsCompany & "','" & _
                                        strVenno & "','" & _
                                        dr.Item("yvf_fmlopt").ToString.Replace("'", "''").Trim & "','','" & _
                                        strMatcde & "','" & _
                                        dr.Item("yvf_effdat").ToString.Replace("'", "''").Trim & "'"
                        Else
                            gspStr = "sp_update_SYVENFML '" & gsCompany & "','" & _
                                        strVenno & "','" & _
                                        dr.Item("yvf_fmlopt").ToString.Replace("'", "''").Trim & "','" & _
                                        dr.Item("yvf_def").ToString.Replace("'", "''").Trim & "','" & _
                                        gsUsrID & "','','" & _
                                        strMatcde & "','" & _
                                        dr.Item("yvf_effdat").ToString.Replace("'", "''").Trim & "'"
                        End If
                    ElseIf dr.RowState = DataRowState.Added And Not dr.Item("yvf_status") = "Y" Then

                        If dr.Item("yvf_credat").ToString.Trim = "" Then
                            gspStr = "sp_insert_SYVENFML '" & gsCompany & "','" & _
                                        strVenno & "','" & _
                                        dr.Item("yvf_fmlopt").ToString.Replace("'", "''").Trim & "','" & _
                                        dr.Item("yvf_def").ToString.Replace("'", "''").Trim & "','" & _
                                        gsUsrID & "','','" & _
                                        strMatcde & "','" & _
                                        dr.Item("yvf_effdat").ToString.Replace("'", "''").Trim & "'"
                        End If
                    End If

                    If gspStr <> "" Then
                        rtnLong = execute_SQLStatement(gspStr, rs, rtnStr)
                        If rtnLong <> RC_SUCCESS Then
                            MsgBox("Error on loading SYM00015 sp_update_SYVENFML : " & rtnStr)
                            flgErr = True
                            Exit For
                        End If
                        gspStr = ""
                    End If
                Next

                If Not flgErr Then
                    rs_syvenfml.AcceptChanges()
                    Call setStatus("Save")
                Else
                    save_ok = False
                    rs_syvenfml.RejectChanges()
                    MsgBox("Record Not Updated!")
                End If
            End If

        Finally
            Me.Cursor = Windows.Forms.Cursors.Default
        End Try
    End Sub

    Private Sub SYM00015_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Dim YNC As Integer
        Dim flgMod As Boolean = False

        bindSrc.EndEdit()
        For Each dr As DataRow In rs_syvenfml.Tables("RESULT").Rows
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
        End If

    End Sub

    Private Sub CmdExit_Click() Handles cmdExit.Click
        Me.Close()
    End Sub

End Class