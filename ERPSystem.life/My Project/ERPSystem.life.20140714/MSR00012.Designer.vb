﻿<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class MSR00012
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
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.Label8 = New System.Windows.Forms.Label
        Me.Panel2 = New System.Windows.Forms.Panel
        Me.optSecNo = New System.Windows.Forms.RadioButton
        Me.optSecYes = New System.Windows.Forms.RadioButton
        Me.Label7 = New System.Windows.Forms.Label
        Me.Panel1 = New System.Windows.Forms.Panel
        Me.optExcelN = New System.Windows.Forms.RadioButton
        Me.optExcelY = New System.Windows.Forms.RadioButton
        Me.txtDateTo = New System.Windows.Forms.MaskedTextBox
        Me.cboCustTo = New System.Windows.Forms.ComboBox
        Me.OptEShp = New System.Windows.Forms.RadioButton
        Me.OptCust = New System.Windows.Forms.RadioButton
        Me.Label44 = New System.Windows.Forms.Label
        Me.Label42 = New System.Windows.Forms.Label
        Me.Label41 = New System.Windows.Forms.Label
        Me.Label31 = New System.Windows.Forms.Label
        Me.txtDateFrom = New System.Windows.Forms.MaskedTextBox
        Me.cboCustFrom = New System.Windows.Forms.ComboBox
        Me.Label30 = New System.Windows.Forms.Label
        Me.Label20 = New System.Windows.Forms.Label
        Me.Label19 = New System.Windows.Forms.Label
        Me.Label17 = New System.Windows.Forms.Label
        Me.Label16 = New System.Windows.Forms.Label
        Me.Label6 = New System.Windows.Forms.Label
        Me.txtCoNam = New System.Windows.Forms.TextBox
        Me.Label5 = New System.Windows.Forms.Label
        Me.cboCocde = New System.Windows.Forms.ComboBox
        Me.Label4 = New System.Windows.Forms.Label
        Me.cmdShow = New System.Windows.Forms.Button
        Me.GroupBox1.SuspendLayout()
        Me.Panel2.SuspendLayout()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(5, 31)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(607, 13)
        Me.Label3.TabIndex = 6
        Me.Label3.Text = "_________________________________________________________________________________" & _
            "___________________"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 12.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(136, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.HotTrack
        Me.Label1.Location = New System.Drawing.Point(126, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(329, 20)
        Me.Label1.TabIndex = 5
        Me.Label1.Text = " Outstanding Order Report By Customer"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(14, 14)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(61, 13)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "MSR00012"
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.Label8)
        Me.GroupBox1.Controls.Add(Me.Panel2)
        Me.GroupBox1.Controls.Add(Me.Label7)
        Me.GroupBox1.Controls.Add(Me.Panel1)
        Me.GroupBox1.Controls.Add(Me.txtDateTo)
        Me.GroupBox1.Controls.Add(Me.cboCustTo)
        Me.GroupBox1.Controls.Add(Me.OptEShp)
        Me.GroupBox1.Controls.Add(Me.OptCust)
        Me.GroupBox1.Controls.Add(Me.Label44)
        Me.GroupBox1.Controls.Add(Me.Label42)
        Me.GroupBox1.Controls.Add(Me.Label41)
        Me.GroupBox1.Controls.Add(Me.Label31)
        Me.GroupBox1.Controls.Add(Me.txtDateFrom)
        Me.GroupBox1.Controls.Add(Me.cboCustFrom)
        Me.GroupBox1.Controls.Add(Me.Label30)
        Me.GroupBox1.Controls.Add(Me.Label20)
        Me.GroupBox1.Controls.Add(Me.Label19)
        Me.GroupBox1.Controls.Add(Me.Label17)
        Me.GroupBox1.Controls.Add(Me.Label16)
        Me.GroupBox1.Controls.Add(Me.Label6)
        Me.GroupBox1.Location = New System.Drawing.Point(17, 78)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(595, 161)
        Me.GroupBox1.TabIndex = 13
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Input Criteria"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(172, 51)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(10, 13)
        Me.Label8.TabIndex = 65
        Me.Label8.Text = ":"
        '
        'Panel2
        '
        Me.Panel2.Controls.Add(Me.optSecNo)
        Me.Panel2.Controls.Add(Me.optSecYes)
        Me.Panel2.Location = New System.Drawing.Point(188, 45)
        Me.Panel2.Name = "Panel2"
        Me.Panel2.Size = New System.Drawing.Size(123, 25)
        Me.Panel2.TabIndex = 4
        '
        'optSecNo
        '
        Me.optSecNo.AutoSize = True
        Me.optSecNo.Location = New System.Drawing.Point(79, 3)
        Me.optSecNo.Name = "optSecNo"
        Me.optSecNo.Size = New System.Drawing.Size(39, 17)
        Me.optSecNo.TabIndex = 6
        Me.optSecNo.TabStop = True
        Me.optSecNo.Text = "No" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10)
        Me.optSecNo.UseVisualStyleBackColor = True
        '
        'optSecYes
        '
        Me.optSecYes.AutoSize = True
        Me.optSecYes.Checked = True
        Me.optSecYes.Location = New System.Drawing.Point(3, 4)
        Me.optSecYes.Name = "optSecYes"
        Me.optSecYes.Size = New System.Drawing.Size(43, 17)
        Me.optSecYes.TabIndex = 5
        Me.optSecYes.TabStop = True
        Me.optSecYes.Text = "Yes"
        Me.optSecYes.UseVisualStyleBackColor = True
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(10, 51)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(129, 13)
        Me.Label7.TabIndex = 61
        Me.Label7.Text = "Print Secondary Customer"
        '
        'Panel1
        '
        Me.Panel1.Controls.Add(Me.optExcelN)
        Me.Panel1.Controls.Add(Me.optExcelY)
        Me.Panel1.Location = New System.Drawing.Point(188, 125)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(160, 26)
        Me.Panel1.TabIndex = 11
        '
        'optExcelN
        '
        Me.optExcelN.AutoSize = True
        Me.optExcelN.Checked = True
        Me.optExcelN.Location = New System.Drawing.Point(79, 6)
        Me.optExcelN.Name = "optExcelN"
        Me.optExcelN.Size = New System.Drawing.Size(39, 17)
        Me.optExcelN.TabIndex = 13
        Me.optExcelN.TabStop = True
        Me.optExcelN.Text = "No"
        Me.optExcelN.UseVisualStyleBackColor = True
        '
        'optExcelY
        '
        Me.optExcelY.AutoSize = True
        Me.optExcelY.Location = New System.Drawing.Point(3, 5)
        Me.optExcelY.Name = "optExcelY"
        Me.optExcelY.Size = New System.Drawing.Size(43, 17)
        Me.optExcelY.TabIndex = 12
        Me.optExcelY.Text = "Yes"
        Me.optExcelY.UseVisualStyleBackColor = True
        '
        'txtDateTo
        '
        Me.txtDateTo.Location = New System.Drawing.Point(402, 76)
        Me.txtDateTo.Mask = "##/##/####"
        Me.txtDateTo.Name = "txtDateTo"
        Me.txtDateTo.Size = New System.Drawing.Size(176, 20)
        Me.txtDateTo.TabIndex = 8
        '
        'cboCustTo
        '
        Me.cboCustTo.FormattingEnabled = True
        Me.cboCustTo.Location = New System.Drawing.Point(402, 18)
        Me.cboCustTo.Name = "cboCustTo"
        Me.cboCustTo.Size = New System.Drawing.Size(176, 21)
        Me.cboCustTo.TabIndex = 3
        '
        'OptEShp
        '
        Me.OptEShp.AutoSize = True
        Me.OptEShp.Location = New System.Drawing.Point(267, 102)
        Me.OptEShp.Name = "OptEShp"
        Me.OptEShp.Size = New System.Drawing.Size(109, 17)
        Me.OptEShp.TabIndex = 10
        Me.OptEShp.TabStop = True
        Me.OptEShp.Text = "Earliest Ship Date"
        Me.OptEShp.UseVisualStyleBackColor = True
        '
        'OptCust
        '
        Me.OptCust.AutoSize = True
        Me.OptCust.Checked = True
        Me.OptCust.Location = New System.Drawing.Point(191, 102)
        Me.OptCust.Name = "OptCust"
        Me.OptCust.Size = New System.Drawing.Size(69, 17)
        Me.OptCust.TabIndex = 9
        Me.OptCust.TabStop = True
        Me.OptCust.Text = "Customer"
        Me.OptCust.UseVisualStyleBackColor = True
        '
        'Label44
        '
        Me.Label44.AutoSize = True
        Me.Label44.Location = New System.Drawing.Point(171, 130)
        Me.Label44.Name = "Label44"
        Me.Label44.Size = New System.Drawing.Size(10, 13)
        Me.Label44.TabIndex = 60
        Me.Label44.Text = ":"
        '
        'Label42
        '
        Me.Label42.AutoSize = True
        Me.Label42.Location = New System.Drawing.Point(172, 104)
        Me.Label42.Name = "Label42"
        Me.Label42.Size = New System.Drawing.Size(10, 13)
        Me.Label42.TabIndex = 58
        Me.Label42.Text = ":"
        '
        'Label41
        '
        Me.Label41.AutoSize = True
        Me.Label41.Location = New System.Drawing.Point(370, 79)
        Me.Label41.Name = "Label41"
        Me.Label41.Size = New System.Drawing.Size(26, 13)
        Me.Label41.TabIndex = 46
        Me.Label41.Text = "To :"
        '
        'Label31
        '
        Me.Label31.AutoSize = True
        Me.Label31.Location = New System.Drawing.Point(370, 23)
        Me.Label31.Name = "Label31"
        Me.Label31.Size = New System.Drawing.Size(26, 13)
        Me.Label31.TabIndex = 36
        Me.Label31.Text = "To :"
        '
        'txtDateFrom
        '
        Me.txtDateFrom.Location = New System.Drawing.Point(188, 76)
        Me.txtDateFrom.Mask = "##/##/####"
        Me.txtDateFrom.Name = "txtDateFrom"
        Me.txtDateFrom.Size = New System.Drawing.Size(176, 20)
        Me.txtDateFrom.TabIndex = 7
        '
        'cboCustFrom
        '
        Me.cboCustFrom.FormattingEnabled = True
        Me.cboCustFrom.Location = New System.Drawing.Point(188, 18)
        Me.cboCustFrom.Name = "cboCustFrom"
        Me.cboCustFrom.Size = New System.Drawing.Size(176, 21)
        Me.cboCustFrom.TabIndex = 2
        '
        'Label30
        '
        Me.Label30.AutoSize = True
        Me.Label30.Location = New System.Drawing.Point(146, 79)
        Me.Label30.Name = "Label30"
        Me.Label30.Size = New System.Drawing.Size(36, 13)
        Me.Label30.TabIndex = 24
        Me.Label30.Text = "From :"
        '
        'Label20
        '
        Me.Label20.AutoSize = True
        Me.Label20.Location = New System.Drawing.Point(146, 23)
        Me.Label20.Name = "Label20"
        Me.Label20.Size = New System.Drawing.Size(36, 13)
        Me.Label20.TabIndex = 14
        Me.Label20.Text = "From :"
        '
        'Label19
        '
        Me.Label19.AutoSize = True
        Me.Label19.Location = New System.Drawing.Point(10, 130)
        Me.Label19.Name = "Label19"
        Me.Label19.Size = New System.Drawing.Size(82, 13)
        Me.Label19.TabIndex = 13
        Me.Label19.Text = "Export To Excel"
        '
        'Label17
        '
        Me.Label17.AutoSize = True
        Me.Label17.Location = New System.Drawing.Point(10, 104)
        Me.Label17.Name = "Label17"
        Me.Label17.Size = New System.Drawing.Size(41, 13)
        Me.Label17.TabIndex = 11
        Me.Label17.Text = "Sort By"
        '
        'Label16
        '
        Me.Label16.AutoSize = True
        Me.Label16.Location = New System.Drawing.Point(10, 79)
        Me.Label16.Name = "Label16"
        Me.Label16.Size = New System.Drawing.Size(121, 13)
        Me.Label16.TabIndex = 10
        Me.Label16.Text = "Ship Date (mm/dd/yyyy)"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(10, 21)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(105, 13)
        Me.Label6.TabIndex = 0
        Me.Label6.Text = "Primary Customer No"
        '
        'txtCoNam
        '
        Me.txtCoNam.Enabled = False
        Me.txtCoNam.Location = New System.Drawing.Point(281, 52)
        Me.txtCoNam.Name = "txtCoNam"
        Me.txtCoNam.Size = New System.Drawing.Size(302, 20)
        Me.txtCoNam.TabIndex = 1
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(190, 55)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(85, 13)
        Me.Label5.TabIndex = 12
        Me.Label5.Text = "Company Name:"
        '
        'cboCocde
        '
        Me.cboCocde.FormattingEnabled = True
        Me.cboCocde.Location = New System.Drawing.Point(100, 51)
        Me.cboCocde.Name = "cboCocde"
        Me.cboCocde.Size = New System.Drawing.Size(70, 21)
        Me.cboCocde.TabIndex = 0
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(14, 55)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(82, 13)
        Me.Label4.TabIndex = 11
        Me.Label4.Text = "Company Code:"
        '
        'cmdShow
        '
        Me.cmdShow.Location = New System.Drawing.Point(255, 254)
        Me.cmdShow.Name = "cmdShow"
        Me.cmdShow.Size = New System.Drawing.Size(109, 23)
        Me.cmdShow.TabIndex = 14
        Me.cmdShow.Text = "&Show Report"
        Me.cmdShow.UseVisualStyleBackColor = True
        '
        'MSR00012
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(622, 298)
        Me.Controls.Add(Me.cmdShow)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.txtCoNam)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.cboCocde)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.Label2)
        Me.MaximumSize = New System.Drawing.Size(630, 332)
        Me.MinimumSize = New System.Drawing.Size(630, 332)
        Me.Name = "MSR00012"
        Me.Text = "MSR00012 - Outstanding Order Report By Customer"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.Panel2.ResumeLayout(False)
        Me.Panel2.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Friend WithEvents optExcelN As System.Windows.Forms.RadioButton
    Friend WithEvents optExcelY As System.Windows.Forms.RadioButton
    Friend WithEvents txtDateTo As System.Windows.Forms.MaskedTextBox
    Friend WithEvents cboCustTo As System.Windows.Forms.ComboBox
    Friend WithEvents OptEShp As System.Windows.Forms.RadioButton
    Friend WithEvents OptCust As System.Windows.Forms.RadioButton
    Friend WithEvents Label44 As System.Windows.Forms.Label
    Friend WithEvents Label42 As System.Windows.Forms.Label
    Friend WithEvents Label41 As System.Windows.Forms.Label
    Friend WithEvents Label31 As System.Windows.Forms.Label
    Friend WithEvents txtDateFrom As System.Windows.Forms.MaskedTextBox
    Friend WithEvents cboCustFrom As System.Windows.Forms.ComboBox
    Friend WithEvents Label30 As System.Windows.Forms.Label
    Friend WithEvents Label20 As System.Windows.Forms.Label
    Friend WithEvents Label19 As System.Windows.Forms.Label
    Friend WithEvents Label17 As System.Windows.Forms.Label
    Friend WithEvents Label16 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents txtCoNam As System.Windows.Forms.TextBox
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents cboCocde As System.Windows.Forms.ComboBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents Panel2 As System.Windows.Forms.Panel
    Friend WithEvents optSecNo As System.Windows.Forms.RadioButton
    Friend WithEvents optSecYes As System.Windows.Forms.RadioButton
    Friend WithEvents cmdShow As System.Windows.Forms.Button
End Class
