﻿<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class IMR00009
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.Label1 = New System.Windows.Forms.Label
        Me.txtCoNam = New System.Windows.Forms.TextBox
        Me.Label2 = New System.Windows.Forms.Label
        Me.cboCoCde = New System.Windows.Forms.ComboBox
        Me.Label3 = New System.Windows.Forms.Label
        Me.grpSCNo = New System.Windows.Forms.GroupBox
        Me.Label15 = New System.Windows.Forms.Label
        Me.Label14 = New System.Windows.Forms.Label
        Me.txtToSCNo = New System.Windows.Forms.TextBox
        Me.txtFromSCNo = New System.Windows.Forms.TextBox
        Me.cmdExport = New System.Windows.Forms.Button
        Me.grpSCNo.SuspendLayout()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 14.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.Color.Blue
        Me.Label1.Location = New System.Drawing.Point(12, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(511, 23)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Document Report for Label"
        Me.Label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'txtCoNam
        '
        Me.txtCoNam.BackColor = System.Drawing.Color.White
        Me.txtCoNam.Enabled = False
        Me.txtCoNam.Location = New System.Drawing.Point(255, 41)
        Me.txtCoNam.Name = "txtCoNam"
        Me.txtCoNam.Size = New System.Drawing.Size(268, 20)
        Me.txtCoNam.TabIndex = 8
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(170, 43)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(85, 13)
        Me.Label2.TabIndex = 7
        Me.Label2.Text = "Company Name:"
        '
        'cboCoCde
        '
        Me.cboCoCde.BackColor = System.Drawing.Color.White
        Me.cboCoCde.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboCoCde.FormattingEnabled = True
        Me.cboCoCde.Location = New System.Drawing.Point(95, 40)
        Me.cboCoCde.Name = "cboCoCde"
        Me.cboCoCde.Size = New System.Drawing.Size(72, 21)
        Me.cboCoCde.TabIndex = 6
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.ForeColor = System.Drawing.Color.Blue
        Me.Label3.Location = New System.Drawing.Point(13, 44)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(79, 13)
        Me.Label3.TabIndex = 5
        Me.Label3.Text = "Company Code"
        '
        'grpSCNo
        '
        Me.grpSCNo.Controls.Add(Me.Label15)
        Me.grpSCNo.Controls.Add(Me.Label14)
        Me.grpSCNo.Controls.Add(Me.txtToSCNo)
        Me.grpSCNo.Controls.Add(Me.txtFromSCNo)
        Me.grpSCNo.Location = New System.Drawing.Point(16, 67)
        Me.grpSCNo.Name = "grpSCNo"
        Me.grpSCNo.Size = New System.Drawing.Size(371, 46)
        Me.grpSCNo.TabIndex = 9
        Me.grpSCNo.TabStop = False
        Me.grpSCNo.Text = "Sales Confirmation No."
        '
        'Label15
        '
        Me.Label15.AutoSize = True
        Me.Label15.Location = New System.Drawing.Point(6, 19)
        Me.Label15.Name = "Label15"
        Me.Label15.Size = New System.Drawing.Size(36, 13)
        Me.Label15.TabIndex = 5
        Me.Label15.Text = "From :"
        '
        'Label14
        '
        Me.Label14.AutoSize = True
        Me.Label14.Location = New System.Drawing.Point(206, 19)
        Me.Label14.Name = "Label14"
        Me.Label14.Size = New System.Drawing.Size(26, 13)
        Me.Label14.TabIndex = 7
        Me.Label14.Text = "To :"
        '
        'txtToSCNo
        '
        Me.txtToSCNo.Location = New System.Drawing.Point(238, 16)
        Me.txtToSCNo.Name = "txtToSCNo"
        Me.txtToSCNo.Size = New System.Drawing.Size(124, 20)
        Me.txtToSCNo.TabIndex = 8
        '
        'txtFromSCNo
        '
        Me.txtFromSCNo.Location = New System.Drawing.Point(55, 16)
        Me.txtFromSCNo.Name = "txtFromSCNo"
        Me.txtFromSCNo.Size = New System.Drawing.Size(124, 20)
        Me.txtFromSCNo.TabIndex = 6
        '
        'cmdExport
        '
        Me.cmdExport.Location = New System.Drawing.Point(402, 76)
        Me.cmdExport.Name = "cmdExport"
        Me.cmdExport.Size = New System.Drawing.Size(111, 32)
        Me.cmdExport.TabIndex = 10
        Me.cmdExport.Text = "E&xport to Excel"
        Me.cmdExport.UseVisualStyleBackColor = True
        '
        'IMR00009
        '
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit
        Me.ClientSize = New System.Drawing.Size(537, 126)
        Me.Controls.Add(Me.cmdExport)
        Me.Controls.Add(Me.grpSCNo)
        Me.Controls.Add(Me.txtCoNam)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.cboCoCde)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.Name = "IMR00009"
        Me.Text = "IMR00009 - Print Product Label List"
        Me.grpSCNo.ResumeLayout(False)
        Me.grpSCNo.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents txtCoNam As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents cboCoCde As System.Windows.Forms.ComboBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents grpSCNo As System.Windows.Forms.GroupBox
    Friend WithEvents Label15 As System.Windows.Forms.Label
    Friend WithEvents Label14 As System.Windows.Forms.Label
    Friend WithEvents txtToSCNo As System.Windows.Forms.TextBox
    Friend WithEvents txtFromSCNo As System.Windows.Forms.TextBox
    Friend WithEvents cmdExport As System.Windows.Forms.Button
End Class
